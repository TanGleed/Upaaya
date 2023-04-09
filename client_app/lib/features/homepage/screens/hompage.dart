import 'package:client_app/features/homepage/widgets/navigation_drawer.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        drawer: NavigationDrawerWidget(),
        appBar: AppBar(title: Center(child: const Text('Upaaya-Cilent'))),
        body: Center(),
      ),
      theme: ThemeData(primarySwatch: Colors.grey),
    );
  }
}
