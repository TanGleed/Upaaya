// ignore_for_file: use_build_context_synchronously
import 'package:client_app/constants/global_variable.dart';
import 'package:client_app/features/homepage/screens/profile_page.dart';
import 'package:client_app/features/homepage/screens/request_page.dart';
import 'package:client_app/features/homepage/screens/settings_page.dart';
import 'package:flutter/material.dart';

class NavigationDrawerWidget extends StatelessWidget {
  final padding = EdgeInsets.symmetric(
    horizontal: GlobalVariable().getProportionateScreenWidth(15),
  );
  // const NavigationDrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    const name = 'Prabesh Timilsina';
    const phone = '9800000000';
    const image =
        'https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&w=400';
    return Drawer(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      width: GlobalVariable.screenWidth * 0.65,
      child: Material(
          type: MaterialType.button,
          color: const Color.fromRGBO(169, 169, 169, 1),
          child: ListView(padding: padding, children: <Widget>[
            buildHeader(
                image: image,
                name: name,
                phone: phone,
                onClicked: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const ProfilePage(
                          name: name,
                          image: image,
                        )))),
            SizedBox(height: GlobalVariable().getProportionateScreenHeight(40)),
            const Divider(color: Colors.white70),
            buildMenuItem(
              text: 'About us',
              icon: Icons.info_outlined,
            ),
            const SizedBox(height: 16),
            buildMenuItem(
              text: 'Settings',
              icon: Icons.settings_outlined,
              onClicked: () => selectedItem(context, 1),
            ),
            const SizedBox(height: 16),
            buildMenuItem(text: 'Contact', icon: Icons.phone),
            const SizedBox(height: 16),
            buildMenuItem(text: 'Terms and conditions', icon: Icons.note),
            const SizedBox(height: 16),
          ])),
    );
  }

  buildMenuItem({
    required String text,
    required IconData icon,
    VoidCallback? onClicked,
  }) {
    const color = Colors.white;

    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(text, style: const TextStyle(color: color)),
      onTap: onClicked,
    );
  }

  void selectedItem(BuildContext context, int i) {
    Navigator.of(context).pop();
    switch (i) {
      case 0:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const RequestPage(),
        ));
        break;
      case 1:
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const SettingsPage()));
    }
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
              padding: EdgeInsets.only(
                  top: GlobalVariable().getProportionateScreenHeight(60)),
              child: Row(
                children: [
                  CircleAvatar(
                      radius: 30, backgroundImage: NetworkImage(image)),
                  const SizedBox(
                    width: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style:
                            const TextStyle(fontSize: 14, color: Colors.white),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Text(
                        phone,
                        style:
                            const TextStyle(fontSize: 14, color: Colors.white),
                      ),
                    ],
                  ),
                ],
              )));
}
