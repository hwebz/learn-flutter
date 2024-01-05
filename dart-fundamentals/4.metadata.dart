class Television {
  void turnOn() {
    print("Turn on the TV");
  }

  @Deprecated('Use turnOn instead')
  // @deprecated
  void activate() {
    turnOn();
  }
}

class Todo {
  final String who;
  final String what;

  const Todo(this.who, this.what);
}

@Todo('Dash', 'Implement this function')
void doSomething() {
  print('do something');
}

void main() {
  Television tv = Television();
  tv.activate();
}
