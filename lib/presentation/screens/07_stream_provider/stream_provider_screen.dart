import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_app/presentation/providers/providers.dart';

class StreamProviderScreen extends StatelessWidget {
  const StreamProviderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stream Provider'),
      ),
      body: const _StreamView(),
    );
  }
}

class _StreamView extends ConsumerWidget {
  const _StreamView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final usersInChat = ref.watch(usersInChatProvider);

    return Container(
      child: usersInChat.when(
        data: (users) => ListView.builder(
          itemCount: users.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(users[index]),
            );
          },
        ),
        error: (error, _) => Text(error.toString()),
        loading: () => const CircularProgressIndicator(),
      ),
    );
  }
}
