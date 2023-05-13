import 'dart:io';

import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';

class PostImage extends StatefulWidget {
  const PostImage({super.key});

  @override
  State<PostImage> createState() => _PostImageState();
}

class _PostImageState extends State<PostImage> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upload Images'),
      ),
      body: SizedBox(
        height: 300,
        width: 300,
        child: Column(
          children: [
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
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
                          borderRadius: BorderRadius.circular(10),
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
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                              image: FileImage(imageFiles[index - 1]),
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
                              child: Icon(Icons.close, color: Colors.white),
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
    );
  }
}
