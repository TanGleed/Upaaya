import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class DescPage extends StatefulWidget {
  const DescPage({super.key});

  @override
  State<DescPage> createState() => _DescPageState();
}

class _DescPageState extends State<DescPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
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
                      image: NetworkImage(
                          "https://media.wd-40.ua/app/uploads/2021/12/23143818/Remove-broken-tap-featured.jpg"),
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
                          "Broken Sink",
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
                          "28 kilo, Dhulikhel",
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
                          "Plumbing",
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
                      "Description",
                      style: TextStyle(
                          color: Color.fromARGB(255, 68, 65, 65),
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "This handy tool helps you create dummy text for all your layout needs. We are gradually adding new functionality and we welcome your suggestions and feedback.",
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
                      "Name:Aawishkar Tiwari",
                      style: TextStyle(
                        color: Color.fromARGB(255, 68, 65, 65),
                        fontSize: 15,
                      ),
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    Text(
                      "Contact:980000000",
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
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 75),
                      child: MaterialButton(
                        color: Colors.deepPurple,
                        onPressed: () {},
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
