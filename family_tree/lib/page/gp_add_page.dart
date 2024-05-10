import 'package:family_tree/controller/family_controller.dart';
import 'package:family_tree/ui_helper/ui_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GpAddPage extends StatefulWidget {
  const GpAddPage({super.key});

  @override
  State<GpAddPage> createState() => _GpAddPageState();
}

class _GpAddPageState extends State<GpAddPage> {

  final FamilyController _controller= Get.put(FamilyController());

  var nameCtrl = TextEditingController();
  var ageCtrl = TextEditingController();

  String? gender;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Grande Parent Add',style: TextStyle(color: Colors.white),),
        centerTitle: true,
          backgroundColor: Colors.blue,
      ),
      body: Container(
        margin: EdgeInsets.all(11),
        child: Column(
          children: [
            const Text('Add grande parent details',style: TextStyle(color: Colors.black,fontWeight: FontWeight.w500,fontSize: 22),),
            SizedBox(height: MediaQuery.sizeOf(context).height * .008,),
            UiHelper.customeTextField(nameCtrl, TextInputType.text, 'Name'),
            SizedBox(height: MediaQuery.sizeOf(context).height * .008,),
            UiHelper.customeTextField(ageCtrl, TextInputType.number, 'Age'),
            SizedBox(height: MediaQuery.sizeOf(context).height * .008,),
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: RadioListTile<String>(
                    title: Text('Male'),
                    value: 'Male',
                    groupValue: gender,
                    onChanged: (String? value) {
                      setState(() {
                        gender = value!;
                      });
                    },
                  ),
                ),
                Expanded(
                  child: RadioListTile<String>(
                    title: Text('Female'),
                    value: 'Female',
                    groupValue: gender,
                    onChanged: (String? value) {
                      setState(() {
                        gender = value!;
                      });
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: MediaQuery.sizeOf(context).height * .008,),
            UiHelper.customeElevatedButton(() { 
              _controller.insertGrandFatherDetails(nameCtrl.text, ageCtrl.text, gender.toString(), Get.arguments['ft']);
            }, Text('Add',style: TextStyle(color: Colors.white),), Colors.blue)
          ],
        ),
      ),
    );
  }
}
