import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_app/presentation/providers/providers.dart';

class FutureProviderScreen extends ConsumerWidget {
  const FutureProviderScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pokemonName = ref.watch(pokemonNameProvider);
    return Scaffold(
        appBar: AppBar(
          title: const Text('Future Provider'),
        ),
        body: Center(
          child: pokemonName.when(
            data: (data) => Text(data),
            error: (error, stackTrace) => Text(error.toString()),
            loading: () => const CircularProgressIndicator(),
          ),
        ),
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              heroTag: 'previousPokemon',
              child: const Icon(Icons.arrow_back),
              onPressed: () {
                ref.read(pokemonIdProvider.notifier).previousPokemon();
              },
            ),
            const SizedBox(width: 30),
            FloatingActionButton(
              heroTag: 'nextPokemon',
              child: const Icon(Icons.arrow_forward),
              onPressed: () {
                ref.read(pokemonIdProvider.notifier).nextPokemon();
              },
            ),
          ],
        ));
  }
}
