import 'package:client_app/constants/global_variable.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  final String name;
  final String image;
  final double coverHeight = 240;
  final double profileHeight = 120;

  const ProfilePage({super.key, required this.name, required this.image});

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: Text(name),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          buildTop(),
          buildBody(),
        ],
      ));

  Widget buildBody() {
    return Column(
      children: [
        SizedBox(height: 10.0),
        Text(
          name,
          style: TextStyle(
            fontSize: 22.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 5.0),
        Text(
          '9800000000',
          style: TextStyle(
            fontSize: 18.0,
            color: Colors.grey[600],
          ),
        ),
        SizedBox(height: 20.0),
        Text(
          'About Me',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 5.0),
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
}
