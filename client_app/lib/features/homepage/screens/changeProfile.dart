import 'package:client_app/constants/globalVariable.dart';
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
          title: Text('Change Profile'),
          centerTitle: true,
          backgroundColor: GlobalVariable.backgroundcolor,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: ListView(
            shrinkWrap: true,
            children: [
              imageProfile(context),
              SizedBox(
                height: 10,
              ),
              buildTextfield(
                icon: Icons.person_2,
                hintText: 'Raman Ragav',
                controller: _nameController,
                labeltext: 'Name',
              ),
              SizedBox(
                height: 20,
              ),
              buildTextfield(
                icon: Icons.phone_android,
                hintText: '98...(unique)',
                controller: _contactController,
                labeltext: 'Contact number',
              ),
              SizedBox(
                height: 20,
              ),
              buildTextfield(
                icon: Icons.date_range,
                hintText: '2000/10/10',
                controller: _DOBController,
                labeltext: 'DoB',
              ),
              SizedBox(
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
    margin: EdgeInsets.symmetric(
      horizontal: 20,
      vertical: 20,
    ),
    child: Column(children: [
      Text(
        "Choose Profile photo",
        style: TextStyle(
          fontSize: 20.0,
        ),
      ),
      SizedBox(
        height: 20,
      ),
      Row(
        children: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.camera),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.image),
          ),
        ],
      )
    ]),
  );
}
