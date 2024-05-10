import 'package:flutter/material.dart';
import '../DbHelper/DatabaseHelper.dart';
import '../DataModel/person_model.dart';

class AddMemberScreen extends StatefulWidget {
  const AddMemberScreen({super.key});

  @override
  State<AddMemberScreen> createState() => _AddMemberScreenState();
}

class _AddMemberScreenState extends State<AddMemberScreen> {
  final List<String> items = [
    'Father',
    'Mother',
    'Son',
    'Daughter',
  ];
  String? selectedValue;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _familyTitleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Add Member"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(labelText: 'Name'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a name';
                    }
                    return null;
                  },
                ),
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(
                    labelText: 'Relationship',
                  ),
                  value: selectedValue,
                  onChanged: (String? value) {
                    setState(() {
                      selectedValue = value;
                    });
                  },
                  items: items
                      .map((String item) => DropdownMenuItem<String>(
                    value: item,
                    child: Text(item),
                  ))
                      .toList(),
                  validator: (value) {
                    if (value == null) {
                      return 'Please select a relationship';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _ageController,
                  decoration: const InputDecoration(labelText: 'Age'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter age';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _familyTitleController,
                  decoration: const InputDecoration(labelText: 'Family Title'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a family title';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _addMember();
                    }
                  },
                  child: const Text('Add Member'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _addMember() async {
    if (_formKey.currentState!.validate()) {
      print("Form is valid. Adding member...");
      String name = _nameController.text.trim();
      String? relationship = selectedValue;
      int age = int.parse(_ageController.text.trim());
      String familyTitle = _capitalizeFirstLetter(_familyTitleController.text.trim());

      Person newPerson = Person(name: name, relationship: relationship, age: age, familyTitles: familyTitle);

      DatabaseHelper databaseHelper = DatabaseHelper();
      int result = await databaseHelper.insertPerson(newPerson);

      if (result != 0) {
        _showSnackBar('Member added successfully');
        _nameController.clear();
        _ageController.clear();
        _familyTitleController.clear();
        Navigator.pop(context);
        setState(() {
          selectedValue = null;
        });
      } else {
        // Error
        _showSnackBar('Failed to add member');
      }
    } else {
      print("Form validation failed.");
    }
  }

  String _capitalizeFirstLetter(String text) {
    if (text.isEmpty) return text;
    return text.substring(0, 1).toUpperCase() + text.substring(1).toLowerCase();
  }

  void _showSnackBar(String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

}

