+++
title = "C/C++"
date = 2021-11-20T13:20:00+08:00
draft = false
+++

## volatile {#volatile}

不用 cpu register ，每次从内存读， needed for memory-mapped I/O


## ccls/clangd {#ccls-clangd}

```shell
cmake -H. -BDebug -DCMAKE_BUILD_TYPE=Debug -DCMAKE_EXPORT_COMPILE_COMMANDS=YES -DCONAN_DISABLE_CHECK_COMPILER=YES
ln -s Debug/compile_commands.json
```


## type convert {#type-convert}


### C++ {#c-plus-plus}

```C++ { linenos=true, linenostart=1 }
using namespace std;
int z = 13;
string s = to_string(z);
int m = stoi(s);
cout << s << endl;
cout << m << endl;
```


### C {#c}

```C
char* x = "1234567890";
long  y = atol(x);
char* z = "1.234567890";
double u = strtod(z, NULL);

printf("%d\n",y);
printf("%g",z);
```


## product type {#product-type}

```C++
using namespace std;
auto n = std::make_tuple(1, 'c', "fsadf");
auto ll = get<2>(n);
cout << get<0>(n);
cout << get<1>(n);
cout << get<2>(n) << endl;
```


## C++ type size {#c-plus-plus-type-size}

```C++
using namespace std;
auto num_bytes_signed = sizeof(signed int);
auto min_signed = std::numeric_limits<signed int>().min();
auto max_signed = std::numeric_limits<signed int>().max();

auto num_bytes_unsigned = sizeof(unsigned int);
auto min_unsigned = std::numeric_limits<unsigned int>().min();
auto max_unsigned = std::numeric_limits<unsigned int>().max();

std::cout << "int bytes (signed): " << num_bytes_signed << '\n';
std::cout << "min value (signed): " << min_signed << '\n';
std::cout << "max value (signed): " << max_signed << '\n';

std::cout << '\n';

std::cout << "int bytes (unsigned): " << num_bytes_unsigned << '\n';
std::cout << "min value (unsigned): " << min_unsigned << '\n';
std::cout << "max value (unsigned): " << max_unsigned << '\n';
```


## C format {#c-format}

%x 即按十六进制输出，英文字母小写，右对齐。
%02X 有以下变化：英文字母变大写，如果输出字符不足两位的，输出两位宽度，右对齐，空的一位补 0。超过两位的，全部输出。

```C
unsigned int x = {0x7f, 0xAB0, 0xA0A0, 0xFAFA, 0x100};

x = ~ x;
int arr[4]={1,2,3,4};
int *ptr1=(int *)(&arr+1);
int *ptr2=(int *)((int)arr+1);

int (*arrp)[4]= 0x64;

int *parr[5]={0x64, 0xAB0, 0xA0A0, 0xFAFA, 0x100};

int i;

printf("hello world ddd %x\n", x);

printf("Array elements are\n");

for(i=0;i<5;i++)
printf("Arrp Decimal: %d, Hex: %X\n", arrp , arrp + i);

for(i=0;i<5;i++)
printf("Parrallel Decimal: %d, Hex: %X\n",parr[i],parr[i]);

printf("%x %x %x\n",&arr,ptr1,ptr2);
printf("%016x",ptr1);
return 0;
```


## C str {#c-str}

```C++
using namespace std;
const char* eee = "fsdaf";

cerr << eee << endl;

while (*eee != '\0') {
    cout << *eee << endl;
    ++eee;
}
```


## Multi-thread {#multi-thread}

2 thread add to one number alternatively


### atomic {#atomic}

```cpp
using namespace std;
atomic_int e = 0;

auto ff = [&e](string x, int i) {
    while (e < 20) {
        if (e % 2 == i) {
            cout << x << " : " << e << endl;
            e.fetch_add(1);
        }
    }
};

thread dd(ff, "d", 0);
thread ee(ff, "e", 1);

dd.join();
ee.join();
```


### conditional variable {#conditional-variable}

```cpp
using namespace std;
std::mutex mu;
std::condition_variable cv;

vector<int> myvector{5, 4,  6, 7, 9, 3, 10, 9, 5, 6};// myvector:  99  99  99  99

auto f = [&](string x) {
    while (1) {
        unique_lock<mutex> um(mu);
        if (myvector.size() != 0) {
            cout << x << " : " << myvector.front() << endl;
            myvector.erase(myvector.begin());
            cv.notify_one();
            cv.wait(um);
        } else {
            // close other thread
            cv.notify_one();
            break;
        }
    }
};

thread a(f, "a");
thread b(f, "b");

cv.notify_one();
a.join();
b.join();
```


### future {#future}

```cpp
cout << "main thread id is :" << this_thread::get_id() << endl;
vector<future<void> > futures;
for (int i = 0; i < 10; ++i) {
    futures.emplace_back(async([]() {
        this_thread::sleep_for(chrono::seconds(2));
        cout << this_thread::get_id() << endl;
    }));
}
for_each(futures.begin(), futures.end(),
            [=](future<void> &fut) { fut.wait(); });
```


## Left and righ value {#left-and-righ-value}

```cpp
std::string s1 = "Test";

std::string& r1 = s1;// 错误：不能绑定到左值

const std::string& r2 = s1;// 可行：到常值的左值引用延长生存期
//  r2 += "Test";                    // 错误：不能通过到常值的引用修改

std::string&& r3 = s1 + s1;// 可行：右值引用延长生存期
r3 += "Test";// 可行：能通过到非常值的右值引用修改
```


## [Algorithm]({{< relref "math.md#algorithm-theory" >}}) {#algorithm--math-dot-md}

```cpp
vector<int> myints{10, 20, 50, 30, 40};
auto myints_it = myints.begin();
vector<int> myvector{5, 4,  6, 7, 9,
                    3, 10, 9, 5, 6};

iter_swap(myints_it + 3, myvector.begin() + 2);
partial_sort(myints_it, myints_it + 3, myints_it + 4, less<int>());

for (auto x : myints) {
    cout << x << endl;
}
cout << "\n";

for (auto x : myvector) {
    cout << x << endl;
}
int sum = std::accumulate(myints.begin(), myints.end(), (int)0);
```


## C Duff's device {#c-duff-s-device}

```C
#define crBegin static int state=0; switch(state) { case 0:
#define crReturn(i,x) do { state=i; return x; case i:; } while (0)
#define crFinish }
int function(void) {
    static int i;
    crBegin;
    for (i = 0; i < 10; i++)
        crReturn(1, i);
    crFinish;
}

int main() {
  printf("start %d \n", function());
  printf("run %d \n", function());
  printf("run %d \n", function());
  printf("run %d \n", function());
  printf("run %d \n", function());
  printf("run %d \n", function());
  printf("run %d \n", function());
  printf("run %d \n", function());
  printf("run %d \n", function());
  printf("run %d \n", function());
  printf("finished %d \n", function());
  //printf(function());
  return 0;
}

```


## C set jump/long jump {#c-set-jump-long-jump}

```C
static jmp_buf buf;
static jmp_buf buf2;

void second(void) {
    int stack_variable = 200;
    printf("second\n");         // 打印
    setjmp(buf2);
    printf("stack_variable after long jump down is %d, ", stack_variable);

    longjmp(buf,1);             // 跳回setjmp的调用处 - 使得setjmp返回值为1
}

void first(void) {
    second();
    printf("first\n");          // 不可能执行到此行
}

int main() {
    static int loop_times = 5;
    int stack_variable = 100;
    if ( ! setjmp(buf) ) {
        first();                // 进入此行前，setjmp返回0
    } else {                    // 当longjmp跳转回，setjmp返回1，因此进入此行
        printf(" main\n");       // 打印
    }
    printf("stack_variable after long jump up is %d ,", stack_variable);
    while(1) {
      --loop_times;
      if(loop_times <0) break;
      longjmp(buf2,1);
    }

    return 0;
  }
```
