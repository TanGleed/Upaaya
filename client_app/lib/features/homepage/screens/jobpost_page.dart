import 'dart:io';

import 'package:client_app/constants/global_variable.dart';
import 'package:client_app/features/homepage/widgets/job_categories.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:client_app/features/homepage/services/job_post_notifier.dart';
import 'package:client_app/theme/jobpost_text_field.dart';
import 'package:client_app/features/homepage/models/jobpost/jobpost.dart';

class JobPostPage extends StatefulWidget {
  JobPostPage({Key? key}) : super(key: key);

  @override
  State<JobPostPage> createState() => _JobPostPageState();
}

class _JobPostPageState extends State<JobPostPage> {
  //final List<String> tagOptions = ['option1', 'option2', 'option3'];
  final TextEditingController titleController = TextEditingController();

  final TextEditingController descriptionController = TextEditingController();

  final TextEditingController locationController = TextEditingController();

  final TextEditingController tagController = TextEditingController();

  final TextEditingController additionalInfoController =
      TextEditingController();
  double latitude = 0;
  double longitude = 0;
  //String? selectedTag;
  List<File> imageFiles = [];

  void pickimage() {
    if (imageFiles.length < 6) {
      _getImage();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Maximum 6 Image Can be selected'),
        ),
      );
    }
  }

  void _getImage() async {
    var images = await ImagePicker().pickMultiImage();
    // ignore: unnecessary_null_comparison
    if (images != null) {
      if (images.length <= 6) {
        setState(() {
          imageFiles.addAll(images.map((image) => File(image.path)).toList());
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Maximum 6 Image Can be selected'),
          ),
        );
      }
    }
  }

  void _removeImage(int index) {
    setState(() {
      imageFiles.removeAt(index);
    });
  }

  void jobposting(BuildContext context) async {
    String title = titleController.text.trim();
    String description = descriptionController.text.trim();
    String location = locationController.text.trim();
    String tags = tagController.text.trim();
    List<String> image = [];
    String additionalInfo = additionalInfoController.text.trim();

    JobPost job = JobPost(
      latitude: latitude,
      longitude: longitude,
      title: title,
      description: description,
      location: location,
      tags: tags,
      additionalInfo: additionalInfo,
      media: imageFiles,
    );
    var provider = Provider.of<JobPostNotifier>(context, listen: false);
    await provider.post(job, imageFiles);

    if (provider.isJobPosted) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Job Posted Successfully'),
        ),
      );
    } else {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Job Posting Failed'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Consumer<JobPostNotifier>(
        builder: (context, data, child) {
          locationController.text = data.job.location;
          latitude = data.job.latitude;
          longitude = data.job.longitude;

          return data.isLoading
              ? Center(
                  child: SpinKitThreeBounce(
                    itemBuilder: (BuildContext context, int index) {
                      return DecoratedBox(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: index.isEven ? Colors.red : Colors.green,
                        ),
                      );
                    },
                  ),
                )
              : ListView(children: [
                  Column(
                    children: [
                      const JobCategories(),
                      SizedBox(
                        height: GlobalVariable.screenHeight * 0.01,
                      ),
                      AppTextField(
                        textController: locationController,
                        hintText: 'Location',
                        icon: Icons.location_on,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      AppTextField(
                        textController: titleController,
                        hintText: 'Title',
                        icon: Icons.work,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      AppTextField(
                        maxLines: 5,
                        textController: descriptionController,
                        hintText: 'Description',
                        icon: Icons.description,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      AppTextField(
                        textController: tagController,
                        hintText: 'Tags',
                        icon: Icons.tag,
                      ),
                      // DropdownButton<String>(
                      //   hint: const Text('Select Tag'),
                      //   value: selectedTag,
                      //   onChanged: (String? value) {
                      //     selectedTag = value;
                      //   },
                      //   items: tagOptions.map((String value) {
                      //     return DropdownMenuItem<String>(
                      //       value: value,
                      //       child: Text(value),
                      //     );
                      //   }).toList(),
                      // ),
                      const SizedBox(
                        height: 20,
                      ),
                      AppTextField(
                        textController: additionalInfoController,
                        hintText: 'Additional Info',
                        icon: Icons.info,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: GlobalVariable.screenWidth * 0.1,
                            right: GlobalVariable.screenWidth * 0.7),
                        child: const Text(
                          'Add Images',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        height: 300,
                        width: GlobalVariable.screenWidth * 0.85,
                        child: Column(
                          children: [
                            Expanded(
                              child: GridView.builder(
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  childAspectRatio: 1,
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 10,
                                ),
                                itemCount: imageFiles.length + 1,
                                itemBuilder: (BuildContext context, int index) {
                                  if (index == 0) {
                                    return GestureDetector(
                                      onTap: pickimage,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.grey[200],
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Icon(Icons.add),
                                      ),
                                    );
                                  } else {
                                    return Stack(
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                            border: Border.all(),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            image: DecorationImage(
                                              image: FileImage(
                                                  imageFiles[index - 1]),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          top: 0,
                                          right: 0,
                                          child: GestureDetector(
                                            onTap: () {
                                              _removeImage(index - 1);
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors.red,
                                              ),
                                              child: Icon(Icons.close,
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                      ],
                                    );
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          jobposting(context);
                        },
                        child: Container(
                          height: 70,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 40,
                            vertical: 23,
                          ),
                          margin: const EdgeInsets.only(
                            left: 40,
                            right: 40,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.grey,
                                offset: Offset(4, 4),
                                blurRadius: 15,
                                spreadRadius: 1,
                              ),
                              BoxShadow(
                                color: Colors.white,
                                offset: Offset(-4, -4),
                                blurRadius: 15,
                                spreadRadius: 1,
                              ),
                            ],
                          ),
                          child: const Text(
                            'Post Job',
                            style: TextStyle(
                              color: Color.fromARGB(255, 21, 93, 122),
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ]);
        },
      ),
    );
  }
}
