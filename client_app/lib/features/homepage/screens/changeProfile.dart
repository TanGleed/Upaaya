import 'package:client_app/constants/global_variable.dart';
import 'package:flutter/material.dart';

class ChangeProfile extends StatelessWidget {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();
  final TextEditingController _DOBController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Change Profile'),
          centerTitle: true,
          backgroundColor: GlobalVariable.backgroundcolor,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
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
              buildTextfield(
                icon: Icons.phone_android,
                hintText: 'Contact',
                controller: _contactController,
                labeltext: 'Contact number',
              ),
              const SizedBox(
                height: 20,
              ),
              buildTextfield(
                icon: Icons.date_range,
                hintText: 'birth data',
                controller: _DOBController,
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
            ],
          ),
        ));
  }
}

Widget imageProfile(BuildContext context) {
  return Center(
    child: Stack(children: [
      const CircleAvatar(
          radius: 60.0,
          backgroundImage: AssetImage("assets/images/profile.png")),
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
    String? labeltext}) {
  return TextFormField(
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
        children: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.camera),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.image),
          ),
        ],
      )
    ]),
  );
}