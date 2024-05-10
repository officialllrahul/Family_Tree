import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:family_tree/model/child_model.dart';
import 'package:family_tree/model/grand_parent_model.dart';
import 'package:family_tree/model/parent_child_combine_model.dart';
import 'package:family_tree/model/parent_model.dart';
import 'package:get/get.dart';

class ViewController extends GetxController {

 final FirebaseFirestore _firestore = FirebaseFirestore.instance;

 Stream fetchGrandeParent() {
  return  _firestore.collection('grande').snapshots();
 }

 Stream fetchParent(String gfId) {
  return _firestore.collection('grande').doc(gfId).collection('parent').snapshots();
 }

 Stream fetchChild(String gfId,String pId) {
  return _firestore.collection('grande').doc(gfId).collection('parent').doc(pId).collection('child').snapshots();
 }


 Future<GrandParentModel?> findGrandParent(String gfId) async {
 var data = await _firestore.collection('grande').doc(gfId).get();
  GrandParentModel? grandParentModel;
 data.data()?.forEach((key, value) {
    grandParentModel = GrandParentModel.fromJson(value);
  });
   return grandParentModel;
 }


 Future<List<GrandParentModel>> getGrandeParent()async {
  var grandParents =await  _firestore.collection('grande').get();
  return grandParents.docs.map((e) => GrandParentModel.fromJson(e.data())).toList();

 }

 Future<List<ParentModel>> getParent(String gfId)async {
  var parentsResult = await _firestore.collection('grande').doc(gfId).collection('parent').get();
  var parents = parentsResult.docs.map((e) => ParentModel.fromJson(e.data())).toList();

  return parents;

 }
 Future<ParentChildCombineModel> getFamilyTreeData(String gfId)async{
  var parents =await getParent(gfId);
  var children = <ChildModel>[];
  for (var parent in parents) {
   var result = await getChild(gfId, parent.pId ??"");
   children.addAll(result);
  }
  return ParentChildCombineModel(parents, children);
 }
 Future<List<ChildModel>> getChild(String gfId,String pId)async {
  var children = await _firestore.collection('grande').doc(gfId).collection('parent').doc(pId).collection('child').get();

 return children.docs.map((e) => ChildModel.fromJson(e.data())).toList();
 }



}