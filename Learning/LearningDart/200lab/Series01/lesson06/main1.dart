class Person {
  late String name;
  late String gender;
  late int age;

  // Generative Constructor
  Person(this.name, this.gender, int this.age);

  // Named Constructor
  Person.newBorn() {
    this.age = 0;
  }

  // Getter function getting the value of name
  String get personName => name;

  // Setter function for setting the value of age
  void set personAge(int val) {
    if (val < 0) {
      print("Age cannot be negative");
    } else {
      this.age = val;
    }
  }

  walking() => print('$name is walking');
  talking() => print('$name is talking');
}

int main() {
  var firstPerson = Person("Sarah", "Female", 25);
  print(firstPerson.name);
  print(firstPerson.gender);
  print(firstPerson.age);

  var secondPerson = Person.newBorn();
  print(secondPerson.age);

  print(firstPerson.personName);

  firstPerson.personAge = -5;
  print(firstPerson.age);

  return 0;
}
