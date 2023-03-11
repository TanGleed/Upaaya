import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class ProfilePage extends StatelessWidget {
  final String name;
  final String image;

  const ProfilePage({super.key, required this.name, required this.image});

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: Text(name),
        centerTitle: true,
      ),
      body: Image.network(
        image,
        width: double.infinity,
        height: double.infinity,
        fit: BoxFit.cover,
      ));
}
