import 'package:family_tree/controller/family_controller.dart';
import 'package:family_tree/ui_helper/ui_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FamilyTitleScreen extends StatefulWidget {
  const FamilyTitleScreen({super.key});

  @override
  State<FamilyTitleScreen> createState() => _FamilyTitleScreenState();
}

class _FamilyTitleScreenState extends State<FamilyTitleScreen> {

  final familyTitleController = TextEditingController();
  final FamilyController _controller = Get.put(FamilyController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Family Title',style: TextStyle(color: Colors.white),),
        centerTitle: true,
        backgroundColor: Colors.red,
      ),
      body: Center(
        child: Container(
          child: ElevatedButton(onPressed: (){
            showAlertDialog(context);
          }, child: Text('START AN EMPTY TREE',style: TextStyle(color: Colors.white),),style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange,
              shape: ContinuousRectangleBorder(
                  borderRadius: BorderRadius.circular(11)
              )
          ),),
        ),
      ),
    );
  }

  void showAlertDialog(BuildContext context) {
    Widget cancelButton = TextButton(
      child: Text("Cancel"),
      onPressed:  () {
        Get.back();
      },
    );
    Widget continueButton = TextButton(
      child: Text("Create"),
      onPressed:  () {
        if(familyTitleController.text.isNotEmpty){
          _controller.insertFamilyTitle(familyTitleController.text);
        }
        else{
          Get.snackbar('Fill it', 'Please fill this family tree..',
              snackPosition: SnackPosition.BOTTOM,
              colorText: Colors.white,
              backgroundColor: Colors.red);
        }
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Family Title"),
      content: Container(
        height: MediaQuery.sizeOf(context).height * .1,
        child: Column(
          children: [
            UiHelper.customeTextField(familyTitleController, TextInputType.text, 'Title of family')
          ],
        ),
      ),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );

  }
}
