import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_app/presentation/providers/providers.dart';

class StreamProviderScreen extends ConsumerWidget {
  const StreamProviderScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final usersInChat = ref.watch(usersInChatProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Stream Provider'),
      ),
      body: usersInChat.when(
        data: (data) => ListView.builder(
          itemCount: data.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(data[index]),
            );
          },
        ),
        error: (error, stackTrace) => Text(error.toString()),
        loading: () => const CircularProgressIndicator(),
      ),
    );
  }
}
