import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_app/presentation/providers/providers.dart';

class FamilyFutureScreen extends ConsumerStatefulWidget {
  const FamilyFutureScreen({super.key});

  @override
  ConsumerState<FamilyFutureScreen> createState() => _FamilyFutureScreenState();
}

class _FamilyFutureScreenState extends ConsumerState<FamilyFutureScreen> {
  int _pokemonId = 1;

  @override
  Widget build(BuildContext context) {
    final pokemon = ref.watch(pokemonProvider(_pokemonId));

    return Scaffold(
      appBar: AppBar(
        title: Text('Pokemon Id: $_pokemonId'),
      ),
      body: Center(
        child: pokemon.when(
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
              if (_pokemonId > 1) {
                _pokemonId--;
                setState(() {});
              }
            },
          ),
          const SizedBox(width: 30),
          FloatingActionButton(
            heroTag: 'nextPokemon',
            child: const Icon(Icons.arrow_forward),
            onPressed: () {
              if (_pokemonId < 1000) {
                _pokemonId++;
                setState(() {});
              }
            },
          ),
        ],
      ),
    );
  }
}
