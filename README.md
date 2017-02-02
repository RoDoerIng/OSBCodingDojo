# OSBCodingDojo
Monthly Coding Dojo for skill development and/or improvement

## OCP (Open Closed Principle)
- OPEN for Extension
- CLOSED for Modification

## Patterns

### Fluent Interfaces
With methods returning `this` you can combine onemethod after another like:

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
    Console.WriteLine(new PizzaToppingMushrooms(new PizzaToppingCheese(newzaBase())).getCost());               
}
```
This outputs the cost for a Pizza + Cheese + Mushrooms.
```PowerShell
6.3
```
