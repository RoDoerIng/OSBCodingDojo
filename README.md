# OSBCodingDojo
Monthly Coding Dojo for skill development and/or improvement

## OCP (Open Closed Principle)
- OPEN for Extension
- CLOSED for Modification

## Patterns

- [Fluent Interfaces](#fluent-interfaces)
- [Decorator Pattern](#decorator-pattern)
- [Apater Pattern](#adapter-pattern)

### Fluent Interfaces
With methods returning `this` you can combine one method after another like:

```
bmwService.withMechanicalMaintenance().withSafetyTest().getCost()
```

### Decorator Pattern
Base object is extended by decorator objects.

All classes (base and decorators) implement the same interface. Decorator class constructors take the common interface as an input argument. After the base object is constructed it can be **decorated** by constructing decorator objects with the before created base object.

##### Example:
Imagine an interface called `IPizza` with a method `getCost()`.
```CSharp
interface IPizza {
  double getCost();
}
```
This interface is implemented by a base class called `PizzaBase`.
```CSharp
class PizzaBase : IPizza{
  private double cost;

  public PizzaBase(){
    this.cost = 4.5;    //price for pizza without extra toppings
  }

  public double getcost(){
    return cost;
  }
}
```

The decorator classes also implement the interface.
```CSharp
class PizzaToppingCheese : IPizza{
  private IPizza pizza;
  private double cost;

  public PizzaToppingCheese(IPizza aPizza){
    this.pizza = aPizza;
    this.cost = 0.8;
  }

  public double getCost(){
    return this.pizza.getCost() + this.cost;
  }
}

class PizzaToppingMushrooms : IPizza{
  private IPizza pizza;
  private double cost;

  public PizzaToppingMushrooms(IPizza aPizza){
    this.pizza = aPizza;
    this.cost = 1.0;
  }

  public double getCost(){
    return this.pizza.getCost() + this.cost;
  }
}
```

To use the decorator pattern, the base object (or its cosntructor) is passed to the constructor of a decorator object which itself can be passed to another decorator object constructor. See the code snippet below:

```CSharp
static void Main(string[] args)
{
    Console.WriteLine(new PizzaToppingMushrooms(new PizzaToppingCheese(new PizzaBase())).getCost());               
}
```
This outputs the cost for a Pizza + Cheese + Mushrooms.
```PowerShell
6.3
```

### Adapter Pattern

Imagine a class `Caller` that contains an object of class `ClassA` with the interface `IClassA`. Now you've got an object of class `ClassB` that generally serves the same purpose as `ClassA` but implements different methods to achieve that functionality. To use `ClassB` within `Caller` you need to create an adapter class  `AdapterA2B` that implements the interface `IClassA` and **adapts** `ClassB`'s methods to them of `ClassA`.

The mentioned classes could look like follows:
```CSharp
public interface IClassA{
  void doAFoo();
}
```

```CSharp
public class ClassA : IClassA{
  public void doAFoo() {
    Console.WriteLine("doing Foo the A way...");
  }
}
```

```CSharp
public class ClassB{
  public void doBFoo() {
    Console.WriteLine("doing Foo the B way...");
  }
}
```
```CSharp
public class Caller{
  private IClassA fooClass

  public Caller(IClassA fooClass){
    this.fooClass = fooClass;
  }

  public void doFoo(){
    fooClass.doFoo();
  }
}
```

```CSharp
public class AdapterA2B : IClassA{
  private ClassB class2Adapt

  public AdapterA2B(ClassB class2Adapt){
    this.class2Adapt = class2Adapt;
  }

  public void doAFoo() {
    class2Adapt.doBFoo();
  }
}
```

Using `Caller` with both classes `ClassA` and `ClassB` could look like that:

```CSharp
static void Main(string[] args)
{
    Caller caller1 = new Caller(new ClassA());
    Caller caller2 = new Caller(new AdapterA2B(new ClassB()));

    caller1.doFoo();
    caller2.doFoo();                       
}
```

... and produce the following output:
```PowerShell
doing Foo the A way...
doing Foo the B way...
```
