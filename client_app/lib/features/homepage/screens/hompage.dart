import 'package:client_app/constants/globalVariable.dart';
import 'package:client_app/features/homepage/widgets/job_categories.dart';
import 'package:client_app/features/homepage/widgets/navigation_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String message = "";

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final arguments = ModalRoute.of(context)!.settings.arguments;

    if (arguments != null) {
      Map? pushArguments = arguments as Map;

      setState(() {
        message = pushArguments[message];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
<<<<<<< HEAD
        drawer: NavigationDrawerWidget(),
        appBar: AppBar(title: Center(child: const Text('Upaaya-Cilent'))),
        body: Center(
          child: Container(
            child: Text("Push Message: $message"),
          ),
        ),
      ),
=======
          backgroundColor: GlobalVariable.backgroundcolor,
          drawer: NavigationDrawerWidget(),
          appBar: AppBar(
            backgroundColor: Colors.deepPurpleAccent,
            elevation: 0,
            title: Text(
              GlobalVariable.appName,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            actions: [
              IconButton(
                color: Colors.black,
                onPressed: () {
                  //notification page
                },
                icon: SvgPicture.asset("assets/icons/notification.svg"),
              ),
            ],
          ),
          body: ListView(
            children: [JobCategories()],
          )),
>>>>>>> 8f4a6a9bfef43b52efacaa4a43f6128eb5004ea2
      theme: ThemeData(primarySwatch: Colors.grey),
    );
  }
}
