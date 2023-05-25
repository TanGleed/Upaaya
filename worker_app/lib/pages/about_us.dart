import 'package:flutter/material.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About US'),
      ),
      body: Container(
        width: double.maxFinite,
        height: double.maxFinite,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Text(
                'Welcome to Upaaya, where you can easily connect with skilled professionals to get your tasks done. Whether you need a plumber, electrician, or painter, we simplify the process of finding the right worker for your project.',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'How it works: Post your job with details like location, description, category. Skilled professionals in your area can then browse and express interest and accept your work',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'We prioritize your safety and peace of mind. We verify worker credentials and facilitate secure payment transactions.',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Our user-friendly platform streamlines the process of finding reliable professionals for physical work. Say goodbye to traditional methods and embrace a convenient, efficient, and trustworthy solution. Join us today and experience the future of physical freelancing.',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
