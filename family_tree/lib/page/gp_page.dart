import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:family_tree/page/gp_add_page.dart';
import 'package:family_tree/page/parent/parent_page.dart';
import 'package:family_tree/page/view/TreeViewPage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GpPage extends StatefulWidget {
  const GpPage({super.key});

  @override
  State<GpPage> createState() => _GpPageState();
}

class _GpPageState extends State<GpPage> {
  String? familyTree;

  @override
  void initState() {
    super.initState();
    familyTree = Get.arguments['ft'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Grand Parent',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('grande')
            .where('gf_familyTree', isEqualTo: familyTree)
            .snapshots(),
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting){
            return Center(child: CircularProgressIndicator(),);
          }
          return ListView.builder(
            itemCount: snapshot.data?.docs.length,
            itemBuilder: (context, index) {
              var data = snapshot.data?.docs[index];
              return Card(
                child: ListTile(
                  title: Text(data!['gf_name'].toString()),
                  subtitle: Text(data['gf_age']),
                  trailing: FittedBox(
                    child: Row(
                      children: [
                        IconButton(onPressed: (){
                          Get.to(ParentPage(),arguments: {'gf_id' : data['gf_id']});
                        }, icon: Icon(Icons.add,color: Colors.green,)),
                    
                        IconButton(onPressed: (){
                          Get.to(TreeViewPage(),arguments: {
                            'gf_id': data['gf_id'],
                            'gf_name' : data['gf_name']
                          }
                          );
                        }, icon: Icon(Icons.remove_red_eye,color: Colors.grey,)),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Get.to(GpAddPage(), arguments: {'ft': familyTree});
          },
          label: Text('Grand Parent')),
    );
  }
}
