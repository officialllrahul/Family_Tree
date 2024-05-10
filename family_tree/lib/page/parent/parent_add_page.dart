import 'package:family_tree/controller/family_controller.dart';
import 'package:family_tree/ui_helper/ui_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ParentAppPage extends StatefulWidget {
  const ParentAppPage({super.key});

  @override
  State<ParentAppPage> createState() => _ParentAppPageState();
}

class _ParentAppPageState extends State<ParentAppPage> {

  final FamilyController _controller = Get.put(FamilyController());

  var nameCtrl = TextEditingController();
  var ageCtrl = TextEditingController();

  String? gender;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Parent Add Page',style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.blue,
      ),
      body: Container(
        margin: EdgeInsets.all(11),
        child: Column(
          children: [
            Text('Parent Add here',style: TextStyle(color: Colors.black,fontSize: 22,fontWeight: FontWeight.w500),),
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
                    // subtitle: Text('Description of Option 1'),
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
              _controller.insertParentDetails(Get.arguments['gf_id'], nameCtrl.text, ageCtrl.text, gender.toString());
            }, Text('Add',style: TextStyle(color: Colors.white),), Colors.blue)
          ],
        ),
      ),
    );
  }
}
