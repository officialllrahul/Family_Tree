import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebasefamilt/page/customFemaleBox.dart';
import 'package:firebasefamilt/page/customMaleBox.dart';
import 'package:flutter/widgets.dart';

class FamilyTree extends StatefulWidget {
  const FamilyTree({Key? key}) : super(key: key);

  @override
  State<FamilyTree> createState() => _FamilyTreeState();
}

class _FamilyTreeState extends State<FamilyTree> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blue,
        title: const Text(
          "Family Tree",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MaleBox(
                    icon: Icons.person, name: "Raj", relationship: "Father"),
                FemaleBox(
                    icon: Icons.person, name: "Neha", relationship: "Mother"),
              ],
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  MaleBox(
                      icon: Icons.person, name: "Raj", relationship: "Father"),
                  FemaleBox(
                      icon: Icons.person, name: "Neha", relationship: "Mother"),
                  MaleBox(
                      icon: Icons.person, name: "Raj", relationship: "Father"),
                  FemaleBox(
                      icon: Icons.person, name: "Neha", relationship: "Mother"),
                ],
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MaleBox(
                      icon: Icons.person, name: "Raj", relationship: "Father"),
                  FemaleBox(
                      icon: Icons.person, name: "Neha", relationship: "Mother"),
                  MaleBox(
                      icon: Icons.person, name: "Raj", relationship: "Father"),
                  FemaleBox(
                      icon: Icons.person, name: "Neha", relationship: "Mother"),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
