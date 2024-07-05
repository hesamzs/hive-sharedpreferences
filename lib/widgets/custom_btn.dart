import 'package:flutter/material.dart';

import 'custom_textstyle.dart';

class CustomBtn {
  Widget CBTN1(String text, VoidCallback callback) {
    return GestureDetector(
      onTap: callback,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.blueAccent,
          ),
          height: 35,
          child: Center(
            child: Text(
              text,
              style: CustomTextStyle().style2(),
            ),
          ),
        ),
      ),
    );
  }
}
