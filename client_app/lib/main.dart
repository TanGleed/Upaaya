import 'package:client_app/features/auth/screens/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// We create a "provider", which will store a value (here "Hello world").
// By using a provider, this allows us to mock/override the value exposed.
final exampleProvider = Provider((_) => 'Upaaya Client');

void main() {
  runApp(
    // For widgets to be able to read providers, we need to wrap the entire
    // application in a "ProviderScope" widget.
    // This is where the state of our providers will be stored.
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

// Extend HookConsumerWidget instead of HookWidget, which is exposed by Riverpod
class MyApp extends HookConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // We can use hooks inside HookConsumerWidget
    final counter = useState(0);

    final String value = ref.watch(exampleProvider);

    return MaterialApp(
      home: Auth(),
    );
  }
}
