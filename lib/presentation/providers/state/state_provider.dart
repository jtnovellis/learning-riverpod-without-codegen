import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'state_provider.g.dart';

@riverpod
class Counter extends _$Counter {
  @override
  int build() {
    return 0;
  }

  void increment() {
    state++;
  }
}

@riverpod
class DarkMode extends _$DarkMode {
  @override
  bool build() {
    return false;
  }

  void toggle() {
    state = !state;
  }
}

@riverpod
class UserName extends _$UserName {
  @override
  String build() {
    return 'Jairo Toro';
  }

  void changeName(String name) {
    state = name;
  }
}
