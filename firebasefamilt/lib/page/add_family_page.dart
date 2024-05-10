import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/controller_page.dart';
import '../ui_helper.dart';

class AddFamilyPage extends StatefulWidget {
  const AddFamilyPage({Key? key}) : super(key: key);

  @override
  State<AddFamilyPage> createState() => _AddFamilyPageState();
}

class _AddFamilyPageState extends State<AddFamilyPage> {
  var nameController = TextEditingController();
  var ageController = TextEditingController();
  var familyTitleController = TextEditingController();
  HomePageController homePageController = Get.put(HomePageController());

  String? selectedValue;
  List<String> familyRelation = [
    'Father',
    'Mother',
    'Son',
    'Daughter'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Family'),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Container(
        margin: const EdgeInsets.all(11),
        child: SingleChildScrollView(
          child: Column(
            children: [
              UiHelper.customeTextFiled(nameController, 'Name', TextInputType.text),
              SizedBox(height: MediaQuery.of(context).size.height * .008,),
              DropdownButtonFormField(
                decoration: const InputDecoration(
                  labelText: 'Relationship',
                ),
                items: familyRelation.map((items){
                  return DropdownMenuItem(
                    value: items,
                    child: Text(items),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedValue = value;
                  });
                },
              ),
              SizedBox(height: MediaQuery.of(context).size.height * .008,),
              UiHelper.customeTextFiled(ageController, 'Age',TextInputType.number),
              SizedBox(height: MediaQuery.of(context).size.height * .008,),
              UiHelper.customeTextFiled(familyTitleController, 'Family Title',TextInputType.text),
              SizedBox(height: MediaQuery.of(context).size.height * .008,),
              UiHelper.customeElevatedButton(() {
                if(nameController.text.isEmpty || ageController.text.isEmpty || familyTitleController.text.isEmpty || selectedValue == null){
                  Get.snackbar('Info', 'Invalid field');
                }
                else{
                  homePageController.insertFamilyData(nameController.text, ageController.text, familyTitleController.text, selectedValue!);
                }
              }, 'Submit'),
            ],
          ),
        ),
      ),
    );
  }
}
