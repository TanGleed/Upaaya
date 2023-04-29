import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ErrorHandler {
  ErrorHandler({
    required BuildContext context,
    required http.Response response,
  }) {
    switch (response.statusCode) {
      case 200:
      // return showBottomSheet(context: context, builder: builder)
    }
  }
  // void error(){
  //   switch()
  // }
}
