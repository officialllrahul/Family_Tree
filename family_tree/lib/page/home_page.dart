import 'package:family_tree/controller/family_controller.dart';
import 'package:family_tree/page/family_title_screen.dart';
import 'package:family_tree/page/gp_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FamilyController _familyController = Get.put(FamilyController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Home Page',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: StreamBuilder(
        stream: _familyController.fetchFamilyTitle,
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting){
            return Center(child: CircularProgressIndicator(),);
          }
          else if(!snapshot.hasData){
            return Center(child: Text('No data avilable'),);
          }

          return ListView.builder(
            itemCount: snapshot.data!.docs!.length,
            itemBuilder: (context, index) {
              var data = snapshot.data.docs[index];
              return Card(
                child: Container(
                  padding:EdgeInsets.all(11),
                  child: ListTile(
                    title: Text(data['family_title']),
                    trailing: FittedBox(
                      child: Row(
                        children: [
                          IconButton(onPressed: (){
                            Get.to(GpPage(),arguments: {'ft' : data['family_title']});
                          }, icon: Icon(Icons.add,color: Colors.green,)),
                          // IconButton(onPressed: (){
                          //   Get.to(ViewPage(),arguments: {'ft' : data['family_title']});
                          // }, icon: Icon(Icons.remove_red_eye,color: Colors.grey,)),
                        ],
                      ),
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
            Get.to(FamilyTitleScreen());
          },
          label: Text('Add Family')),
    );
  }
}
