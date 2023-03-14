class Person {
  late String name = "";
  late String gender = "";
  int age = 0; // Declare age, initially 0.

  walking() => print("$name is walking");
  talking() => print("$name is talking");
}

int main() {
  // Creating an object of the Person class
  var firstPerson = Person();

  firstPerson.name = "Sarah";
  firstPerson.gender = "female";
  firstPerson.age = 25;

  print(firstPerson.name);
  print(firstPerson.gender);
  print(firstPerson.age);

  firstPerson.walking();
  firstPerson.talking();

  // Creating an object of the Person class
  var secondPerson = Person();
  secondPerson.name = "Ben";

  // Creating an object of the Person class
  var thirdPerson = Person();
  thirdPerson.name = "Martin";

  // Creating an object of the Person class
  var fourthPerson = Person();
  fourthPerson.name = "Hannah";

  // Driver Code
  print(firstPerson.name);
  print(secondPerson.name);
  print(thirdPerson.name);
  print(fourthPerson.name);
  return 0;
}
