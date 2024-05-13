void newPrint() {
  print("Function Called");
}

num sum(num x, num y) {
  return x + y;
}

num sum1(num x, num y) => x + y;

num square(num x) {
  return x * x;
}

num squareSum(num x, num y) {
  return square(x) + square(y);
}

printer(num n, {String? s1, String? s2}) {
  print(n);
  print(s1);
  print(s2);
}

String mysteryMessage(String who, [String? what, String? where]) {
  var message = '$who';
  if (what != null && where == null) {
    message = '$message said $what';
  } else if (where != null) {
    message = '$message said $what at $where';
  }
  return message;
}

int factorial(int x) {
  if (x == 1) {
    // Base Case
    return 1;
  } else {
    return x * factorial(x - 1); // Recursive Call
  }
}

List<int> forAll(Function f, List<int> intList) {
  var newList = <int>[];
  for (var i = 0; i < intList.length; i++) {
    newList.add(f(intList[i]));
  }
  return newList;
}

void outerFunction() {
  print("Outer Function");
  void nestedFunction() {
    print("Nested Function");
  }

  nestedFunction();
}

// Driver Code
main() {
  newPrint();
  print(sum(1, 2));
  print(sum1(3, 4));

  var result = square(5);
  print(result);

  result = squareSum(2, 5);
  print(result);

  printer(75, s1: 'hello');

  var result1 = mysteryMessage('Billy', 'howdy');
  print(result1);

  result1 = mysteryMessage('Billy', 'howdy', 'the ranch');
  print(result1);

  var result2 = factorial(5);
  print(result2);

  var tester = [1, 2, 3];
  var result3 = forAll(factorial, tester);
  print(tester);
  print(result3);

  tester.forEach(print);

  var list = [1, 2, 3];
  list.forEach((item) {
    print(item * item * item);
  });

  list.forEach((item) => print(item * item * item));

  outerFunction();

  var amIVisible = 0;

  void result4() {
    var amIVisible = square(3);
    print("Variable Inside Block: $amIVisible");
  }

  result4();
  print("Variable Outside Block: $amIVisible");
}
