import 'package:flutter/material.dart';
import 'package:hive_sharedpref_gnav_tabbar/widgets/custom_textstyle.dart';

class CustomTextField {
  Widget CTField1(String text, TextEditingController _controller) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: SizedBox(
          height: 40,
          child: TextField(
            controller: _controller,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              labelText: text,
              // hintText: 'Enter Password',
            ),
          ),
        ),
      ),
    );
  }
  Widget CTField2(String text, TextEditingController _controller) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0),
        child: SizedBox(
          height: 40,
          child: TextField(
            controller: _controller,
            style: CustomTextStyle().style5(),
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              labelText: text,
              // hintText: 'Enter Password',
            ),
          ),
        ),
      ),
    );
  }
}
