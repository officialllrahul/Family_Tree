import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

class FamilyController extends GetxController {

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> insertFamilyTitle(String family_title) async{
    final uuid = Uuid().v1();
    await _firestore.collection('family-title').doc(uuid).set({
      'family_title' : family_title
    }).then((value) {
      Get.back();
      Get.snackbar('Family Title', 'Family Title insert successful..',snackPosition: SnackPosition.BOTTOM);
    });
  }

  Stream fetchFamilyTitle = FirebaseFirestore.instance.collection('family-title').snapshots();

  Future<void> insertGrandFatherDetails(String name,String age,String gender,String familyTree) async {
    String uuid = Uuid().v1();
    await _firestore.collection('grande').doc(uuid).set({
      'gf_familyTree' : familyTree,
      'gf_id' : uuid,
      'gf_name' : name,
      'gf_age' : age,
      'gf_gender' : gender
    }).then((value) {
      Get.back();
      Get.snackbar('Successfully', 'Grande Parent insert successfully..',snackPosition: SnackPosition.BOTTOM);
    });
  }

  Future<void> insertParentDetails(String gfId,String name,String age,String gender) async {
    String uuid = Uuid().v1();
    await _firestore.collection('grande').doc(gfId).collection('parent').doc(uuid).set({
      'gf_id' : gfId,
      'p_id' : uuid,
      'p_name' : name,
      'p_age' : age,
      'p_gender' : gender,
    }).then((value) {
      Get.back();
    Get.snackbar('Successfully', 'Parent insert successfully..',snackPosition: SnackPosition.BOTTOM);

    });
  }

  Future<void> insertChildDetails(String gf_id,String p_id,String name,String age,String gender) async{
    String uuid = Uuid().v1();
    await _firestore.collection('grande').doc(gf_id).collection('parent').doc(p_id).collection('child').doc(uuid).set({
      'c_id' : uuid,
      'gf_id' : gf_id,
      'p_id' : p_id,
      'c_name' : name,
      'c_age' : age,
      'c_gender' : gender,
    }).then((value) {
      Get.back();
      Get.snackbar('Successfully', 'Child insert successfully..',snackPosition: SnackPosition.BOTTOM);

    });
  }

}