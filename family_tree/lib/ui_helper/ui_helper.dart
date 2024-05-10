import 'package:flutter/material.dart';

class UiHelper {
  
  static customeTextField(TextEditingController controller,TextInputType textInputType,String lableText) {
    return TextField(
      controller: controller,
      keyboardType: textInputType,
      decoration: InputDecoration(
        labelText: lableText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(11),
        )
      ),
    );
  }
  
  static customeElevatedButton(VoidCallback voidCallback, Widget widget,Color colors){
    return ElevatedButton(onPressed: voidCallback, child: widget,style: ElevatedButton.styleFrom(
      backgroundColor: colors,
      shape: ContinuousRectangleBorder(
        borderRadius: BorderRadius.circular(11)
      )
    ),);
  }
  
}