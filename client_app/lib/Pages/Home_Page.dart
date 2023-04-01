import 'package:client_app/widget/navigation_drawer_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

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
