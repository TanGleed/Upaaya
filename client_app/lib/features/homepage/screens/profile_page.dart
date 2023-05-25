import 'package:client_app/constants/global_variable.dart';
import 'package:client_app/providers/UserProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'changeProfile.dart';

class ProfilePage extends StatefulWidget {
  static const String routeName = '/profilepage-screen';

  const ProfilePage({
    super.key,
  });

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
  }

  String name = 'na';
  String contact = 'na';
  String address = 'na';
  String image = '';
  String dob = '';
  final double coverHeight = 220;
  final double profileHeight = 110;

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<UserProvider>(context, listen: true);
    name = provider.user.name;
    contact = provider.user.contactno;
    address = provider.user.address;
    dob = provider.user.dob;
    image = provider.user.avatar;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: GlobalVariable.backgroundcolor,
          title: Text(name),
          centerTitle: true,
        ),
        body: staticPage());
  }

  Widget staticPage() {
    return ListView(
      children: [buildTop(), buildBody(), buildButton()],
    );
  }

  //body
  Widget buildBody() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        const SizedBox(height: 10.0),
        Text(
          name,
          style: const TextStyle(
            fontSize: 22.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 5.0),
        Text(
          contact,
          style: TextStyle(
            fontSize: 18.0,
            color: Colors.grey[600],
          ),
        ),
        const SizedBox(height: 10.0),
        const Text(
          'About Me',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 5.0),
        Container(
          alignment: Alignment.center,
          width: 300,
          child: Text(
            'Birth Date: $dob',
            style: TextStyle(
              fontSize: 16.0,
              color: Colors.grey[600],
            ),
          ),
        ),
        SizedBox(
          height: GlobalVariable.screenHeight * 0.01,
        ),
        Text(
          'Address:$address',
          style: TextStyle(
            fontSize: 16.0,
            color: Colors.grey[600],
          ),
        ),
        const SizedBox(height: 20.0),
      ],
    );
  }

//top
  Widget buildTop() {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(bottom: profileHeight / 2),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: Image.network(
              'https://thumbs.dreamstime.com/b/stainless-steel-kitchen-sink-double-bowl-white-granite-worktop-33727821.jpg',
              width: double.infinity, // This is cover photo
              height: coverHeight,
              fit: BoxFit.fill,
            ),
          ),
        ),
        Positioned(
          top: coverHeight - profileHeight / 2,
          child: CircleAvatar(
            radius: profileHeight / 2,
            backgroundColor: GlobalVariable.backgroundcolor,
            backgroundImage: NetworkImage(
              image, // Profile photo is here
            ),
          ),
        )
      ],
    );
  }

  Widget buildButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 80),
      child: InkWell(
        child: Container(
            height: 50,
            width: 150,
            decoration: BoxDecoration(
                color: GlobalVariable.buttonsColors,
                borderRadius: BorderRadius.circular(20)),
            child: const Center(
                child: Text('Change Profile',
                    style: TextStyle(color: Colors.white, fontSize: 18)))),
        onTap: () => {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ChangeProfile()),
          )
        },
      ),
    );
  }
}
