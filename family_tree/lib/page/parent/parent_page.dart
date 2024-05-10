import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:family_tree/page/child/child_page.dart';
import 'package:family_tree/page/parent/parent_add_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ParentPage extends StatefulWidget {
  const ParentPage({super.key});

  @override
  State<ParentPage> createState() => _ParentPageState();
}

class _ParentPageState extends State<ParentPage> {
  String? gfId;

  @override
  void initState() {
    super.initState();
    gfId = Get.arguments['gf_id'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Parent Page',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('grande')
            .doc(gfId)
            .collection('parent')
            .snapshots(),
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting){
            return Center(child: CircularProgressIndicator(),);
          }
          else if(!snapshot.hasData){
            return Center(child: Text('No aviable data'),);
          }
          return ListView.builder(
              itemCount: snapshot.data?.docs.length,
              itemBuilder: (context, index){
                var data = snapshot.data?.docs[index];
                return Card(
                  child: ListTile(
                    title: Text(data?['p_name']),
                    subtitle: Text(data?['p_age']),
                    trailing: FittedBox(
                      child: Row(
                        children: [
                          IconButton(onPressed: (){
                            Get.to(ChildPage(),arguments: {'p_id': data?['p_id'],'gf_id' : data?['gf_id']});
                          }, icon: Icon(Icons.add,color: Colors.green,))
                        ],
                      ),
                    ),
                  ),
                );
              });
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Get.to(ParentAppPage(), arguments: {'gf_id': gfId});
          },
          label: Text('Prent Add')),
    );
  }
}
