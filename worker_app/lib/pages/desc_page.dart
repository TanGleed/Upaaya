import 'package:flutter/material.dart';

import 'package:worker_app/models/job.dart';
import 'package:worker_app/pages/map_page.dart';

class DescPage extends StatelessWidget {
  final Job job;
  const DescPage({Key? key, required this.job}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Description'),
        ),
        body: Container(
          width: double.maxFinite,
          height: double.maxFinite,
          child: Stack(children: [
            Positioned(
              left: 10,
              right: 10,
              child: Container(
                width: double.maxFinite,
                height: 300,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/car.png'),
                      fit: BoxFit.contain),
                ),
              ),
            ),
            Positioned(
              top: 290,
              child: Container(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                width: MediaQuery.of(context).size.width,
                height: 700,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          job.title,
                          style: TextStyle(
                            color: Color.fromARGB(255, 49, 49, 49),
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    Row(
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        Icon(
                          Icons.location_on,
                          color: Color.fromARGB(255, 244, 74, 74),
                          size: 16,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          "Location: ${job.location}",
                          style: TextStyle(
                            color: Color.fromARGB(255, 68, 65, 65),
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    Row(
                      children: [
                        Text(
                          "Category:",
                          style: TextStyle(
                            color: Color.fromARGB(255, 244, 74, 74),
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          job.title,
                          style: TextStyle(
                            color: Color.fromARGB(255, 68, 65, 65),
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      job.description,
                      style: TextStyle(
                          color: Color.fromARGB(255, 68, 65, 65),
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      job.additionalInfo,
                      style: TextStyle(
                        color: Color.fromARGB(255, 68, 65, 65),
                        fontSize: 15,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Published by",
                      style: TextStyle(
                          color: Color.fromARGB(255, 68, 65, 65),
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Name:${job.id}",
                      style: TextStyle(
                        color: Color.fromARGB(255, 68, 65, 65),
                        fontSize: 15,
                      ),
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    Text(
                      "Contact:xxxxxxxxxx",
                      style: TextStyle(
                        color: Color.fromARGB(255, 68, 65, 65),
                        fontSize: 15,
                      ),
                    )
                  ],
                ),
              ),
            ),
            Positioned(
                bottom: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 75),
                      child: MaterialButton(
                        color: Colors.deepPurple,
                        onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => MapPage()),
                        ),
                        child: Text(
                          'Accept',
                          style: TextStyle(color: Colors.white, fontSize: 15),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: MaterialButton(
                        color: Colors.deepPurple,
                        onPressed: () {},
                        child: Text(
                          'Decline',
                          style: TextStyle(color: Colors.white, fontSize: 15),
                        ),
                      ),
                    ),
                  ],
                ))
          ]),
        ));
  }
}
