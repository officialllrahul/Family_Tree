import 'package:flutter/material.dart';
import '../DataModel/person_model.dart';
import '../DbHelper/DatabaseHelper.dart';
import 'add_member_screen.dart';
import 'edit_member_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
        centerTitle: true,
        title: const Text("Family Tree"),
      ),
      body: _isLoading
          ? const Center(
        child: CircularProgressIndicator(),
      )
          : _familyList.isEmpty
          ? const Center(
        child: Text("No family members added yet."),
      )
          : ListView.builder(
        itemCount: _familyList.length,
        itemBuilder: (context, index) {
          final family = _familyList[index];
          final familyMembers = _personsList
              .where((person) =>
          person.familyTitles == family.familyTitles)
              .toList();

          return ExpansionPanelList(
            expansionCallback: (int panelIndex, bool isExpanded) {
              setState(() {
                family.isExpanded = !isExpanded;
              });
            },
            children: [
              ExpansionPanel(
                headerBuilder:
                    (BuildContext context, bool isExpanded) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        family.isExpanded = !isExpanded;
                      });
                    },
                    child: ListTile(
                      title: Text(
                          "${family.familyTitles}'s family"),
                    ),
                  );
                },
                body: Column(
                  children: familyMembers
                      .map((member) => ListTile(
                    title: Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
                      children: [
                        Text("Name: ${member.name ?? ""}"),
                        Text(
                            "Relationship: ${member.relationship ?? ""}"),
                        Text("Age: ${member.age ?? ""}"),
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
                                builder: (context) =>
                                    EditMemberScreen(
                                        person: member),
                              ),
                            ).then((_) =>
                                _updatePersonList());
                          },
                        ),
                        IconButton(
                          icon:
                          const Icon(Icons.delete),
                          onPressed: () {
                            _deletePerson(
                                member.id!,
                                _personsList
                                    .indexOf(member));
                          },
                        ),
                      ],
                    ),
                  ))
                      .toList(),
                ),
                isExpanded: family.isExpanded,
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddMemberScreen()),
          ).then((_) => _updatePersonList());
        },
        child: const Icon(Icons.add),
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