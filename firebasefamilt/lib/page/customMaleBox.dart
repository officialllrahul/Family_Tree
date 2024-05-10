import 'package:flutter/material.dart';

class MaleBox extends StatelessWidget {
  final IconData icon;
  final String name;
  final String relationship;

  MaleBox(
      {required this.icon, required this.name, required this.relationship});

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;
    final iconSize = mq.width * 0.2 * 0.5;

    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
        width: mq.width*0.25,
        height: mq.height*0.15,
        decoration: BoxDecoration(
          color: Colors.white70,
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(color: Colors.black54),
        ),
        padding: const EdgeInsets.all(5.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.lightBlue[100],
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: iconSize,
                color: Colors.white,
              ), // Icon
              const SizedBox(width: 16.0),
              Text(
                name,
                style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
              ), // Name
              Text(
                relationship,
                style: const TextStyle(fontSize: 14.0),
              ), // Relationship
            ],
          ),
        ),
      ),
    );
  }
}
