import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/controller_page.dart';
import '../ui_helper.dart';

class UpdatePage extends StatefulWidget {
  final String familyId;
  final String name;
  final String age;
  final String relationship;

  const UpdatePage({
    required this.familyId,
    required this.name,
    required this.age,
    required this.relationship,
  });

  @override
  State<UpdatePage> createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage> {
  var updateNameCtrl = TextEditingController();
  var updateAgeCtrl = TextEditingController();
  HomePageController _homePageController = Get.put(HomePageController());

  @override
  void initState() {
    super.initState();
    updateNameCtrl.text = widget.name;
    updateAgeCtrl.text = widget.age;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Page',style: TextStyle(color: Colors.white),),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Container(
        margin: const EdgeInsets.all(19),
        child: Column(
          children: [
            UiHelper.customeTextFiled(updateNameCtrl, 'Enter name',TextInputType.text),
            SizedBox(height: MediaQuery.of(context).size.height * .008,),
            UiHelper.customeTextFiled(updateAgeCtrl, 'Enter age',TextInputType.number),
            SizedBox(height: MediaQuery.of(context).size.height * .008,),
            DropdownButtonFormField(
              decoration: InputDecoration(
                labelText: widget.relationship,
              ),
              items: ['Father', 'Mother', 'Son', 'Daughter'].map((items) {
                return DropdownMenuItem(
                  value: items,
                  child: Text(items),
                );
              }).toList(),
              onChanged: (value) {},
            ),
            SizedBox(height: MediaQuery.of(context).size.height * .008,),
            UiHelper.customeElevatedButton(() {
              _homePageController.updateFamilyData(
                widget.familyId,
                updateNameCtrl.text,
                updateAgeCtrl.text,
                widget.relationship,
              );
            }, 'Update')
          ],
        ),
      ),
    );
  }
}
