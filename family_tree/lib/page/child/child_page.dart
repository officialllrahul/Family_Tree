import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:family_tree/page/child/child_add_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChildPage extends StatefulWidget {
  const ChildPage({super.key});

  @override
  State<ChildPage> createState() => _ChildPageState();
}

class _ChildPageState extends State<ChildPage> {
  String? p_id;
  String? gf_id;

  @override
  void initState() {
    super.initState();
    p_id = Get.arguments['p_id'];
    gf_id = Get.arguments['gf_id'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Child Page',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('grande')
            .doc(gf_id)
            .collection('parent')
            .doc(p_id)
            .collection('child')
            .snapshots(),
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting){
            return Center(child: CircularProgressIndicator());
          }
          return ListView.builder(
            itemCount: snapshot.data?.docs.length,
            itemBuilder: (context, index) {
              var data = snapshot.data?.docs[index];
              return Card(
                child: ListTile(
                  title: Text(data?['c_name']),
                ),
              );
              },
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Get.to(ChildAddPage(), arguments: {'p_id': p_id, 'gf_id': gf_id});
          },
          label: Text('Add Child')),
    );
  }
}
