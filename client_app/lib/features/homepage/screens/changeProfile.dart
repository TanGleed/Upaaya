import 'dart:io';

import 'package:client_app/constants/global_variable.dart';
import 'package:client_app/features/homepage/screens/profile_page.dart';
import 'package:client_app/providers/UserProvider.dart';
import 'package:client_app/sharedpreferences.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';

class ChangeProfile extends StatefulWidget {
  const ChangeProfile({super.key});

  @override
  State<ChangeProfile> createState() => _ChangeProfileState();
}

class _ChangeProfileState extends State<ChangeProfile> {
  final _globalKey = GlobalKey<FormState>();
  final ImagePicker _picker = ImagePicker();

  bool isasynccall = false;
  final TextEditingController _nameController = TextEditingController();

  // final TextEditingController _contactController = TextEditingController();

  final TextEditingController _dobController = TextEditingController();
  String image = '';
  final TextEditingController _addressController = TextEditingController();

  void changeuserdetails(BuildContext context) async {
    var provider = Provider.of<UserProvider>(context, listen: false);
    String email = await LoginSharedPreferences().getemail();
    await provider.setUserDetails(_nameController.text, _dobController.text,
        email, _addressController.text);
    if (provider.setUser) {
      isasynccall = false;
      setState(() {});
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Profile Updated Successfully'),
        ),
      );
      Navigator.of(context).pushNamed(ProfilePage.routeName);
    } else {
      isasynccall = false;
      setState(() {});
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Cannot Update Profile'),
        ),
      );
    }
  }

  void changeImage(BuildContext context, File imagefile) async {
    var provider = Provider.of<UserProvider>(context, listen: false);
    await provider.changeImage("sudeepbhattarai1792@gmail.com", imagefile);
    if (provider.imageChanged) {
      isasynccall = false;
      setState(() {});
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Image Changed Successfully'),
        ),
      );
    } else {
      isasynccall = false;
      setState(() {});
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Cannot Update Image'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<UserProvider>(context, listen: true);
    // ignore: unused_local_variable
    image = provider.user.avatar;
    return Scaffold(
        appBar: AppBar(
          title: const Text('Change Profile'),
          centerTitle: true,
          backgroundColor: GlobalVariable.backgroundcolor,
        ),
        body: Builder(builder: (context) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: ProgressHUD(
              key: UniqueKey(),
              inAsyncCall: isasynccall,
              child: Form(
                key: _globalKey,
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    imageProfile(context),
                    const SizedBox(
                      height: 10,
                    ),
                    buildTextfield(
                      icon: Icons.person_2,
                      hintText: 'Your Name',
                      controller: _nameController,
                      labeltext: 'Name',
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    // buildTextfield(
                    //   icon: Icons.phone_android,
                    //   hintText: 'Contact',
                    //   controller: _contactController,
                    //   labeltext: 'Contact number',
                    // ),
                    // const SizedBox(
                    //   height: 20,
                    // ),
                    buildTextfield(
                      icon: Icons.date_range,
                      hintText: 'birth data',
                      controller: _dobController,
                      labeltext: 'DoB',
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    buildTextfield(
                      icon: Icons.text_format_rounded,
                      hintText: 'Dhulikhel, Kavre',
                      controller: _addressController,
                      labeltext: 'Address',
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    InkWell(
                      child: Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                              color: GlobalVariable.buttonsColors,
                              borderRadius: BorderRadius.circular(20)),
                          child: const Center(
                              child: Text('Submit',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18)))),
                      onTap: () async {
                        if (_globalKey.currentState!.validate()) {
                          isasynccall = true;
                          setState(() {});
                          changeuserdetails(context);
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        }));
  }

  void takePhoto(ImageSource source) async {
    final pickedFile = await _picker.pickImage(
      source: source,
    );
    final imageFile = File(pickedFile!.path);
    // ignore: use_build_context_synchronously
    changeImage(context, imageFile);
  }

  Widget bottomSheet(BuildContext context) {
    return Container(
      height: 100.0,
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Column(children: [
        const Text(
          "Choose Profile photo",
          style: TextStyle(
            fontSize: 20.0,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              onPressed: () {
                takePhoto(ImageSource.camera);
              },
              icon: const Icon(Icons.camera),
            ),
            SizedBox(
              width: GlobalVariable.screenWidth / 4,
            ),
            IconButton(
              onPressed: () {
                takePhoto(ImageSource.gallery);
              },
              icon: const Icon(Icons.image),
            ),
          ],
        )
      ]),
    );
  }

  Widget imageProfile(BuildContext context) {
    return Center(
      child: Stack(children: [
        CircleAvatar(
          radius: 60.0,
          backgroundImage: NetworkImage(image),
        ),
        Positioned(
          bottom: 20.0,
          right: 20.0,
          child: InkWell(
            onTap: () {
              showBottomSheet(
                context: context,
                builder: ((builder) => bottomSheet(context)),
              );
            },
            child: const Icon(
              Icons.camera_alt,
              color: Colors.white,
              size: 23.0,
            ),
          ),
        ),
      ]),
    );
  }

  Widget buildTextfield(
      {IconData? icon,
      String? hintText,
      TextEditingController? controller,
      String? labeltext,
      String? val}) {
    return TextFormField(
      initialValue: val,
      validator: (value) {
        if (value!.isEmpty) return "Can't be empty";
      },
      controller: controller,
      decoration: InputDecoration(
        labelText: labeltext,
        hintText: hintText,
        prefixIcon: icon != null ? Icon(icon) : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
      ),
    );
  }
}
