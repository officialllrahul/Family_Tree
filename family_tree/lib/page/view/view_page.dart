import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:family_tree/page/view/view_heraricy.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ViewPage extends StatefulWidget {
  const ViewPage({super.key});

  @override
  State<ViewPage> createState() => _ViewPageState();
}

class _ViewPageState extends State<ViewPage> {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: StreamBuilder(stream: FirebaseFirestore.instance.collection('grande').where('gf_familyTree',isEqualTo: Get.arguments['ft']).snapshots(), builder: (context, snapshot) {
            if(snapshot.connectionState == ConnectionState.waiting){
              return Center(child: CircularProgressIndicator(),);
            }
            return ListView.builder(
              itemCount: snapshot.data?.docs.length,
              itemBuilder: (BuildContext context, int index) { 
                var data = snapshot.data?.docs[index];
                return Card(child: ListTile(
                  title: Text(data?['gf_name']),
                  subtitle: Text(data?['gf_age']),
                  trailing: FittedBox(
                    child: InkWell(
                        onTap: (){
                          Get.to(ViewHeraricy(),arguments: {'gf_id' : data?['gf_id']});
                        },
                        child: Icon(CupertinoIcons.eye)
                    ),
                  ),
                ));
              },
            );
          },),
        ),
    );
  }
}
