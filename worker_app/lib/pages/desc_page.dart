// ignore_for_file: prefer_const_constructors

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:worker_app/constants/globalVariable.dart';

import 'package:worker_app/models/job.dart';
import 'package:worker_app/pages/map_page.dart';
import 'package:worker_app/services/Mapservices.dart';

class DescPage extends StatefulWidget {
  final Job job;
  const DescPage({Key? key, required this.job}) : super(key: key);

  @override
  State<DescPage> createState() => _DescPageState();
}

class _DescPageState extends State<DescPage> {
  double sourcelat = 27.6195;
  double sourcelng = 85.5386;
  void setlocation() async {}

  @override
  Widget build(BuildContext context) {
    List<String> imageList = widget.job.media;
    return Scaffold(
      appBar: AppBar(
        title: Text('Description'),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: double.maxFinite,
          height: 950,
          child: Stack(children: [
            Positioned(
              left: 10,
              right: 10,
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 10,
                  ),
                  CarouselSlider(
                    items: imageList
                        .map(
                          (e) => ClipRRect(
                            borderRadius: BorderRadius.circular(6),
                            child: Image.network(
                              ApiURL.imageURL + e,
                              height: MediaQuery.of(context).size.height * 0.4,
                              width: double.maxFinite,
                            ),
                          ),
                        )
                        .toList(),
                    options: CarouselOptions(
                      autoPlay: true,
                      enableInfiniteScroll: false,
                      enlargeCenterPage: true,
                      height: MediaQuery.of(context).size.height * 0.3,
                    ),
                  )
                ],
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
                          widget.job.title,
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
                          "Location: ${widget.job.location}",
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
                          widget.job.tags,
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
                      widget.job.description,
                      style: TextStyle(
                          color: Color.fromARGB(255, 68, 65, 65),
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      widget.job.additionalInfo,
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
                      "Name:${widget.job.id}",
                      style: TextStyle(
                        color: Color.fromARGB(255, 68, 65, 65),
                        fontSize: 15,
                      ),
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    Text(
                      "Contact:${widget.job.clientemail}",
                      style: TextStyle(
                        color: Color.fromARGB(255, 68, 65, 65),
                        fontSize: 15,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: MaterialButton(
                        color: Colors.deepPurple,
                        onPressed: () async {
                          await MapServices()
                              .determinePosition()
                              .then((value) => {
                                    print(value.latitude),
                                    sourcelat = value.latitude,
                                    sourcelng = value.longitude,
                                  });

                          setState(() {});
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MapPage(
                                      desLat: double.parse(widget.job.latitude),
                                      desLng:
                                          double.parse(widget.job.longitude),
                                      sourcelat: sourcelat,
                                      sourcelng: sourcelng,
                                    )),
                          );
                        },
                        child: Text(
                          'Accept',
                          style: TextStyle(color: Colors.white, fontSize: 15),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Positioned(
            //     bottom: 20,
            //     right: 20,
            //     child: Row(
            //       mainAxisAlignment: MainAxisAlignment.center,
            //       children: [
            //         Padding(
            //           padding: const EdgeInsets.only(left: 75),
            //           child: MaterialButton(
            //             color: Colors.deepPurple,
            //             onPressed: () => Navigator.push(
            //               context,
            //               MaterialPageRoute(builder: (context) => MapPage()),
            //             ),
            //             child: Text(
            //               'Accept',
            //               style: TextStyle(color: Colors.white, fontSize: 15),
            //             ),
            //           ),
            //         ),
            //       ],
            //     ))
          ]),
        ),
      ),
    );
  }
}
