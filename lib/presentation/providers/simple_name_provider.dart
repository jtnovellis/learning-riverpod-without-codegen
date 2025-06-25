import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_app/config/helpers/random_generator.dart';

// This provider is used only to read data

// This provider keep the state of the data
// final simpleNameProvider = Provider<String>((ref) {
//   return RandomGenerator.getRandomName();
// });

// This provider keep the state of the data and dispose it when it is not used
final simpleNameProvider = Provider.autoDispose<String>((ref) {
  return RandomGenerator.getRandomName();
});
