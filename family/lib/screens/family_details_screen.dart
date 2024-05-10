import 'package:flutter/material.dart';
import '../DataModel/person_model.dart';
import '../DbHelper/DatabaseHelper.dart';
import 'edit_member_screen.dart';

class FamilyDetailScreen extends StatefulWidget {
  final String familyTitle;
  final List<Person> familyMembers;

  const FamilyDetailScreen({
    required this.familyTitle,
    required this.familyMembers,
  });

  @override
  _FamilyDetailScreenState createState() => _FamilyDetailScreenState();
}

class _FamilyDetailScreenState extends State<FamilyDetailScreen> {
  late List<Person> _personsList;
  late List<Person> _familyList;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _updatePersonList();
  }

  Future<void> _updatePersonList() async {
    DatabaseHelper databaseHelper = DatabaseHelper();
    _personsList = await databaseHelper.getPersonList();
    List<Person> uniqueData = getUniqueFamilyNames(_personsList);
    _familyList = uniqueData;
    setState(() {
      _isLoading = false;
    });
  }

  List<Person> getUniqueFamilyNames(List<Person> data) {
    Set<String> uniqueFamilyNames = Set();

    List<Person> uniqueData = [];

    for (var entry in data) {
      if (!uniqueFamilyNames.contains(entry.familyTitles)) {
        uniqueFamilyNames.add(entry.familyTitles);
        uniqueData.add(entry);
      }
    }

    return uniqueData;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.familyTitle} Family'),
      ),
      body: _isLoading
          ? Center(
        child: CircularProgressIndicator(),
      )
          : ListView.builder(
        itemCount: widget.familyMembers.length,
        itemBuilder: (context, index) {
          final member = widget.familyMembers[index];
          return ListTile(
            title: Text("Name: ${member.name ?? ''}"),
            subtitle: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Relationship: ${member.relationship ?? ''}"),
                Text("Age: ${member.age ?? ''}"),
              ],
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditMemberScreen(
                          person: member,
                        ),
                      ),
                    ).then((_) => _updatePersonList());
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    _deletePerson(
                      member.id!,
                      _personsList.indexOf(member),
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Future<void> _deletePerson(int id, int index) async {
    DatabaseHelper databaseHelper = DatabaseHelper();
    await databaseHelper.deletePerson(id);
    setState(() {
      _personsList.removeAt(index);
    });
    _updatePersonList();
  }
}
