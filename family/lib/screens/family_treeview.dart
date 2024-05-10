import 'package:flutter/material.dart';
import 'package:flutter_treeview/flutter_treeview.dart';
import 'package:uuid/uuid.dart'; // Import the uuid package
import '../DataModel/person_model.dart';

class FamilyTreeView extends StatelessWidget {
  final List<Person> familyMembers;
  final Function(int) onDelete;
  final Function(Person) onEdit;

  const FamilyTreeView({
    required this.familyMembers,
    required this.onDelete,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return TreeView(
      controller: TreeViewController(
        children: familyMembers.map((member) {
          String nodeId = Uuid().v4(); // Generate a unique ID for each node
          return Node<dynamic>(
            key: nodeId, // Use the unique ID as the key
            label: ListTile(
              title: Text("${member.name ?? ""}"),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Relationship: ${member.relationship ?? ""}"),
                  Text("Age: ${member.age ?? ""}"),
                ],
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      onEdit(member);
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      onDelete(member.id!);
                    },
                  ),
                ],
              ),
            ).toString(), // Convert ListTile to string for label
          );
        }).toList(),
      ),
    );
  }
}
