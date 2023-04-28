import 'package:client_app/features/homepage/screens/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../constants/globalVariable.dart';

String cdata = DateFormat("yyyy-MM-dd").format(DateTime.now());
String tdata = DateFormat("HH:mm:ss").format(DateTime.now());

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class RequestPage extends StatelessWidget {
  const RequestPage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: GlobalVariable.backgroundcolor,
        appBar: AppBar(
          title: const Text('Requests'),
          centerTitle: true,
          backgroundColor: GlobalVariable.buttonsColors,
        ),
        body: listView(),
      );

  Widget listView() {
    return ListView.separated(
        itemBuilder: (context, index) {
          return listViewItem(index);
        },
        separatorBuilder: (context, index) {
          return Divider(height: 0);
        },
        itemCount: 10);
  }

  Widget listViewItem(int index) {
    return InkWell(
      onTap: () => ProfilePage(name: 'name', image: ''),
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 13, vertical: 10),
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 13, vertical: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              photo(),
              Expanded(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      namePrice(index),
                      SizedBox(
                        width: 20,
                      ),
                      Column(
                        children: [
                          Text(cdata,
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w300,
                              )),
                          Text(tdata,
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w300,
                              ))
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget photo() {
    return Container(
      height: 40,
      width: 40,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.grey.shade300,
      ),
      child: Icon(Icons.person, size: 20, color: Colors.grey.shade700),
    );
  }

  Widget namePrice(index) {
    return RichText(
        maxLines: 3,
        overflow: TextOverflow.ellipsis,
        text: const TextSpan(
            text: 'Name Surname',
            style: TextStyle(
              fontSize: 17,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
            children: [
              WidgetSpan(
                  child: SizedBox(
                width: 20,
              )),
              TextSpan(
                  text: 'Price',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  )),
            ]));
  }
}
