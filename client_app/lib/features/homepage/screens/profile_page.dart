import 'package:client_app/constants/global_variable.dart';
import 'package:flutter/material.dart';

import 'changeProfile.dart';

class ProfilePage extends StatefulWidget {
  final String name;
  final String image;

  const ProfilePage({super.key, required this.name, required this.image});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
  }

  final double coverHeight = 220;

  final double profileHeight = 110;

  @override
  Widget build(BuildContext context) => Scaffold(
<<<<<<< HEAD
      appBar: AppBar(
        backgroundColor: GlobalVariable.backgroundcolor,
        title: Text(widget.name),
        centerTitle: true,
      ),
      body: staticPage());

  Widget staticPage() {
    return ListView(
      children: [buildTop(), buildBody(), buildButton()],
    );
  }
=======
        appBar: AppBar(
          backgroundColor: Colors.deepPurpleAccent,
          title: Text(name),
          centerTitle: true,
        ),
        body: ListView(
          children: [buildTop(), buildBody(), const changeButton()],
        ),
      );
>>>>>>> d51c0a0e740d40ac1c4b288842c80c42f9325071

  //body
  Widget buildBody() {
    return Column(
      children: [
        const SizedBox(height: 10.0),
        Text(
          widget.name,
          style: const TextStyle(
            fontSize: 22.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 5.0),
        Text(
          '9800000000',
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
            'Occupation: Plumber \n',
            style: TextStyle(
              fontSize: 16.0,
              color: Colors.grey[600],
            ),
          ),
        ),
        Text(
          'Experience: 10 years \n',
          style: TextStyle(
            fontSize: 16.0,
            color: Colors.grey[600],
          ),
        ),
        Text(
          'Address: Bhaktapur \n',
          style: TextStyle(
            fontSize: 16.0,
            color: Colors.grey[600],
          ),
        ),
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
              widget.image, // Profile photo is here
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
