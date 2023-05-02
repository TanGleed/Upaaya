import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  final TextEditingController textController;
  final String hintText;
  final IconData icon;
  final int maxLines;
  late final bool isObscure;

  AppTextField({
    Key? key,
    required this.textController,
    required this.hintText,
    required this.icon,
    this.maxLines = 1,
    this.isObscure = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            offset: const Offset(0, 2),
            blurRadius: 4,
          ),
        ],
      ),
      child: TextField(
        maxLines: maxLines,
        obscureText: isObscure,
        controller: textController,
        style: const TextStyle(fontSize: 16),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(
            fontSize: 16,
            color: Colors.grey,
            fontWeight: FontWeight.w500,
          ),
          prefixIcon: Icon(
            icon,
            color: const Color.fromARGB(255, 30, 85, 153),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(12),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(12),
          ),
          filled: true,
          fillColor: Colors.grey[300],
          contentPadding:
              const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
          suffixIcon: isObscure
              ? IconButton(
                  icon: Icon(
                    Icons.visibility,
                    color: Colors.grey[700],
                  ),
                  onPressed: () {
                    // Toggle password visibility
                    textController.selection = TextSelection.fromPosition(
                        TextPosition(offset: textController.text.length));
                    if (isObscure) {
                      textController.selection =
                          const TextSelection.collapsed(offset: 0);
                    }
                    isObscure = !isObscure;
                  },
                )
              : null,
        ),
      ),
    );
  }
}
