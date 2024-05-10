// import 'package:firebasefamilt/page/update_page.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../controller/controller_page.dart';
// import 'add_family_page.dart';
// import 'package:flutter_simple_treeview/flutter_simple_treeview.dart';
//
// class HomePage extends StatelessWidget {
//   HomePage({Key? key}) : super(key: key);
//   final HomePageController _homePageController = Get.put(HomePageController());
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           'Family Tree',
//           style: TextStyle(color: Colors.white),
//         ),
//         centerTitle: true,
//         backgroundColor: Colors.blue,
//       ),
//       body: RefreshIndicator(
//         onRefresh: _homePageController.getData,
//         child: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: SingleChildScrollView(
//             child: Obx(
//                   () {
//                 return SizedBox(
//                   width: MediaQuery.of(context).size.width,
//                   child: TreeView(
//                     nodes: _buildTree(_homePageController.myData.values.toList(), context),
//                   ),
//                 );
//               },
//             ),
//           ),
//         ),
//       ),
//       floatingActionButton: FloatingActionButton.extended(
//         onPressed: (){
//           Get.to(const AddFamilyPage())?.then((_) {
//             _homePageController.getData();
//           });
//         },
//         label: const Icon(Icons.add),
//       ),
//     );
//   }
//
//   List<TreeNode> _buildTree(List<dynamic> data, BuildContext context) {
//     List<TreeNode> nodes = [];
//     if (data == null || data.isEmpty) {
//       nodes.add(TreeNode(
//         content: const Center(child: Text('No member added yet')),
//       ));
//     } else {
//       for (var title in data) {
//         List<TreeNode> familyNodes = [];
//         var familyTitle;
//         for (var family in (title as List<dynamic>)) {
//           familyTitle = family?.familyTitle;
//           familyNodes.add(TreeNode(
//             content: Card(
//               child: Container(
//                 padding: const EdgeInsets.only(left: 8, top: 3),
//                 width: MediaQuery.of(context).size.width * .67,
//                 child: ListTile(
//                   title: Text(family?.name ?? ''),
//                   subtitle: Text(family?.relationShip ?? ''),
//                   trailing: SizedBox(
//                     width: MediaQuery.of(context).size.width * 0.27,
//                     child: Row(
//                       children: [
//                         IconButton(
//                           onPressed: () {
//                             _homePageController.deleteFamilyData(family?.familyId);
//                           },
//                           icon: const Icon(Icons.delete, color: Colors.red,),
//                         ),
//                         IconButton(
//                           onPressed: () {
//                             Get.to(
//                               const UpdatePage(),
//                               arguments: {
//                                 'name': family?.name,
//                                 'age': family?.age,
//                                 'relationship': family?.relationShip,
//                                 'id': family?.familyId,
//                               },
//                             );
//                           },
//                           icon: const Icon(Icons.edit, color: Colors.green,),
//                         )
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ));
//         }
//         nodes.add(TreeNode(
//           content: Text(familyTitle ?? ''),
//           children: familyNodes,
//         ));
//       }
//     }
//
//     return nodes;
//   }
//
// }
