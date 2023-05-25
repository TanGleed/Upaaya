import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:worker_app/features/auth/screens/auth.dart';
import 'package:worker_app/features/auth/screens/login.dart';
import 'package:worker_app/pages/about_us.dart';
import 'package:worker_app/pages/profile_page.dart';

class NavigationDrawerWidget extends StatelessWidget {
  final padding = EdgeInsets.symmetric(horizontal: 20);
  // const NavigationDrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final name = 'Prabesh Timilsina';
    final phone = '9800000000';
    const image =
        'https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&w=400';
    return Drawer(
      child: Material(
          color: Colors.deepPurple,
          child: ListView(padding: padding, children: <Widget>[
            buildHeader(
                image: image,
                name: name,
                phone: phone,
                onClicked: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ProfilePage(
                          name: name,
                          image: image,
                        )))),
            const SizedBox(height: 16),
            buildMenuItem(text: 'Payments', icon: Icons.payment),
            const SizedBox(height: 16),
            buildMenuItem(
              text: 'About us',
              icon: Icons.info_outlined,
              onClicked: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AboutUsPage()),
              ),
            ),
            const SizedBox(height: 16),
            Divider(color: Colors.white70),
            const SizedBox(height: 16),
            buildMenuItem(text: 'Contact', icon: Icons.phone),
            const SizedBox(height: 16),
            buildMenuItem(text: 'Terms and conditions', icon: Icons.note),
            const SizedBox(height: 16),
            buildMenuItem(
                text: 'Logout',
                icon: Icons.logout,
                onClicked: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => Auth()));
                }),
            const SizedBox(height: 24),
          ])),
    );
  }

  buildMenuItem({
    required String text,
    required IconData icon,
    VoidCallback? onClicked,
  }) {
    final color = Colors.white;

    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(text, style: TextStyle(color: color)),
      onTap: onClicked,
    );
  }

  Widget buildHeader({
    required String image,
    required String name,
    required String phone,
    required VoidCallback onClicked,
  }) =>
      InkWell(
          onTap: onClicked,
          child: Container(
              padding: padding.add(EdgeInsets.symmetric(vertical: 40)),
              child: Row(
                children: [
                  CircleAvatar(
                      radius: 30, backgroundImage: NetworkImage(image)),
                  SizedBox(
                    width: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: TextStyle(fontSize: 14, color: Colors.white),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Text(
                        phone,
                        style: TextStyle(fontSize: 14, color: Colors.white),
                      ),
                    ],
                  ),
                ],
              )));
}
