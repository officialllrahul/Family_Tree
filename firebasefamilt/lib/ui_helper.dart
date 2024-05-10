import 'package:flutter/material.dart';

class UiHelper{

  static Widget customeTextFiled(TextEditingController controller,String hintText,TextInputType? inputType) {
    return TextField(
      keyboardType: inputType,
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(11)
        )
      ),
    );
  }

  static Widget customeElevatedButton(VoidCallback onPressed,String buttonTitle){
    return ElevatedButton(onPressed: onPressed, child: Text(buttonTitle,style: TextStyle(color: Colors.white),),style: ElevatedButton.styleFrom(
      shape: ContinuousRectangleBorder(
        borderRadius: BorderRadius.circular(11)
      ),
      backgroundColor: Colors.blue
    ),);
  }

}