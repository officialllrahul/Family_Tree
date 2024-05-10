import 'package:family_tree/controller/view_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';

class ViewHeraricy extends StatefulWidget {
  const ViewHeraricy({super.key});

  @override
  State<ViewHeraricy> createState() => _ViewHeraricyState();
}

class _ViewHeraricyState extends State<ViewHeraricy> {
  String? gfId;
  final ViewController _viewController = Get.put(ViewController());

  @override
  void initState() {
    super.initState();
    gfId = Get.arguments['gf_id'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column()
      ),
    );
  }
}
