+++
title = "OOP 和 FP 在架构弹性的比较-2"
date = 2021-11-23T00:00:00+08:00
tags = ["scala"]
categories = ["fp"]
draft = false
author = "Xiong ChenYu"
+++

承接上文结论，简单 OOP 范式下数据结构的扩展成本比较低下，而 FP 范式下算子的扩展成本
比较低下，在解决代码复杂度上是没有,好哒方法，但是代码组织结构上还是有优化的空间。
这 2 种范式都有自己的方法来解决双向扩展所带来的代码分散问题。


## OOP(Visitor Pattern) {#oop--visitor-pattern}

是时候操起设计模式大法了，23 种扫了一眼，访问者模式看起来在这儿挺能打的。那么撸起
袖子改起来，首先我们来看上回的代码。

```scala

trait Expr {
   def eval: Double
   def prettyPrint: String
}

case class Number(value: Double) extends Expr {
  override def eval = value
  override def print = value.toString
}

case class Add(a: Expr, b: Expr) extends Expr {
  override def eval = a.eval + b.eval
  override def print = s”(${a.print} + ${b.print})”
}

case class Neg(a: Expr) extends Expr {
  override def eval = — a.eval
  override def print = s”-${a.print}”
}
```

核心就是把数据

```scala

trait Expr {
   def accept(visitor: IExpresstionEvalutaion): Double = visitor.visit(this)
   def accept(visitor: IExpresstionPrettyPrint): Void = visitor.visit(this)
}

case class Number(value: Double) extends Expr
case class Add(a: Expr, b: Expr) extends Expr
case class Neg(a: Expr) extends Expr

object IExpresstionEvalutaion {
   def visit( number : Number) = number.value;
   def visit( number : Add) =  eval(number.a) + eval(number.b)
   def visit( number : Nug) =  eval(number.a)
}
object IExpresstionPrettyPrint {
   def visit( number : Number) = number.toString;
   def visit( number : Add) = s"${visit(number.a)} + ${visit(number.b)}"
   def visit( number : Nug) =  s"-${(number.a)}""
}
```

之后无论扩展数据结构还是算子都收敛在一个文件内


## FP(type class) {#fp--type-class}

这是朴素的 fp

```scala
trait Expr
case class Number(value: Double) extends Expr
case class Add(a: Expr, b: Expr) extends Expr
case class Neg(a: Expr) extends Expr

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

typeclass 是一种 ad-hot polymorphism 技术，可以对任意类型进行方法的扩张，源自于
Haskell，在 scala 中可以利用隐式转换实现。

```scala
@typeclass trait Eval[A] {
   def eval(a : A): Double
}
@typeclass trait PrettyPrint[A]{
  def prettyPrint(a : A): String
}

trait Expr
case class Number(value: Double) extends Expr
case class Add(a: Expr, b: Expr) extends Expr
case class Neg(a: Expr) extends Expr

implicit val EvalNumberInstance = new Eval[Number]{
  override def eval(a : Number) = a.value
}
implicit val EvalAddInstance = new Eval[Add]{
  override def eval(x : Add) = x.a.eval + x.b.eval
}
implicit val EvalNegInstance = new Eval[Neg]{
  override def eval(x : Number) = - e.eval
}
implicit val PrettyPrintNumberInstance = new PrettyPrint[Number]{
  override def prettyprint(a : Number) = a.toString
}
implicit val PrettyPrintAddInstance = new PrettyPrint[Add]{
  override def prettyprint(x : Add) = s"${x.a.prettyprint} + ${x.b.prettyprint}"
}
implicit val PrettyPrintNegInstance = new PrettyPrint[Neg]{
  override def prettyprint(x : Number) = s"- ${e.prettyprint}"
}
```
