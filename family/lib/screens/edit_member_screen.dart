import 'package:flutter/material.dart';
import '../DbHelper/DatabaseHelper.dart';
import '../DataModel/person_model.dart';

class EditMemberScreen extends StatefulWidget {
  final Person person;

  EditMemberScreen({required this.person});

  @override
  _EditMemberScreenState createState() => _EditMemberScreenState();
}

class _EditMemberScreenState extends State<EditMemberScreen> {
  late TextEditingController _nameController;
  late TextEditingController _ageController;
  late TextEditingController _familyTitleController;
  late String? _selectedValue;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.person.name);
    _familyTitleController =
        TextEditingController(text: widget.person.familyTitles);
    _ageController = TextEditingController(text: widget.person.age.toString());
    _selectedValue = widget.person.relationship;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit ${widget.person.name}"),
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
                  decoration: const InputDecoration(labelText: 'Relationship'),
                  value: _selectedValue,
                  onChanged: (String? value) {
                    setState(() {
                      _selectedValue = value;
                    });
                  },
                  items: ['Father', 'Mother', 'Son', 'Daughter']
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
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter family title';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _updateMember();
                    }
                  },
                  child: const Text('Save'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _updateMember() async {
    if (_formKey.currentState!.validate()) {
      String name = _nameController.text.trim();
      String? relationship = _selectedValue;
      int age = int.parse(_ageController.text.trim());
      String familyTitle = _familyTitleController.text.trim();

      Person updatedPerson = Person(
          id: widget.person.id,
          name: name,
          relationship: relationship,
          age: age,
          familyTitles: familyTitle);

      DatabaseHelper databaseHelper = DatabaseHelper();
      int result = await databaseHelper.updatePerson(updatedPerson);

      if (result != 0) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Member updated successfully')),
        );
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to update member')),
        );
      }
    }
  }
}
