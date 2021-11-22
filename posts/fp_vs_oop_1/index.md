# OOP 和 FP 在架构弹性的比较-1


对于一个互联网公司的程序，代码的范式是很重要的，好的范式可以让你面对产品经理的指
示的时候痛苦感会降低， 这个时候架构就非常重要了。那么我将以 scala 为例，支持多范式
的语言不多，scala 是各种范式都能 hold 比较好的。展示一下 FP 和 OOP 的优缺点。

我们对架构先提出几点要求

1.  拓展起来不会影响现有代码的清晰度
2.  拓展起来的改动比较少
3.  代码简单易测

假如有一天产品告诉你，来我们搞个计算器吧。第一期要实现加法和减法。那么你考虑的就
是这个

> (2 +3 ) + 4

用 scala 程序表示起来, 就是要求值下面这个东西。

```scala
val expression = Add(Add(Number(2), Number(3)), Number(4))
```


## Round One {#round-one}


### OOP {#oop}

首先来了一个 OOP 程序员,拿起 IDE，三军未动粮草先行, 先来个接口爽一下。

```scala
    trait Expr {
    def eval: Double
    }
```

emm，不错，之后在快速继承一遍

```scala

case class Number(value: Double) extends Expr {
  override def eval = value
}

case class Add(a: Expr, b: Expr) extends Expr {
  override def eval = a.eval + b.eval
}
```

下面是见证奇迹的时刻

```scala
  expression.eval //res0: Double = 9.0
```

完美!


### FP {#fp}

接着来了一个 FP 程序员，嘴里念叨着 Functional core imperative shell, 首先把数据结构
和计算拆开来了

```scala

trait Expr
case class Number(value: Double) extends Expr
case class Add(a: Expr, b: Expr) extends Expr
```

emm，纯数据结构清爽

```scala
def evaluate(expression: Expr): Double = expression match {

  case Number(a) => a
  case Add(a, b) => evaluate(a) + evaluate(b)
}
```

emm, 纯计算，清爽

下面是见证奇迹的时刻

```scala
  evaluate(expression) //res0: Double = 9.0
```

完美!


## Round 2 {#round-2}

这个时候产品说了，这个计算器有点丑啊，能不能打印好看点


### OOP {#oop}

OOP 程序员熟练的修改了接口（改动+1）

```scala
    trait Expr {
    def eval: Double
    def prettyPrint: String
    }
```

然后（改动+1 + 1） =  3 处

```scala

case class Number(value: Double) extends Expr {
  override def eval = value
  override def print = value.toString
}

case class Add(a: Expr, b: Expr) extends Expr {
  override def eval = a.eval + b.eval
  override def print = s”(${a.print} + ${b.print})”
}
```


### FP {#fp}

这就是加个方法的事儿（改动 +1) = 1 处

```scala

def print(expression: Expr): String = expression match {
  case Number(a) => a.toString
  case Add(a, b) => s”(${print(a)} + ${print(b)})”
}
```


## Round 3 {#round-3}

产品又说了，只有加法不够呀，我们还需要个减法


### OOP {#oop}

就是再实现一次接口呗（改动 +1)

```scala
case class Neg(a: Expr) extends Expr {
  override def eval = — a.eval
  override def print = s”-${a.print}”
}
```


### FP {#fp}

首先要拓展一个数据结构

```scala
case class Neg(a: Expr) extends Expr
```

然后所有的函数都要随之改动

```scala

def evaluate(expression: Expr): Double = expression match {
  case Number(a) => a
  case Add(a, b) => evaluate(a) + evaluate(b)
  case Neg(a) => — evaluate(a)
}

def print(expression: Expr): String = expression match {
  case Number(a) => a.toString
  case Add(a, b) => s”(${print(a)} + ${print(b)})”
  case Neg(a) => s”-${print(a)}”
}
```


## 结论 {#结论}

没有银弹，OOP 范式下数据结构的扩展成本比较低，FP 范式下算子的扩展成本比较低。

