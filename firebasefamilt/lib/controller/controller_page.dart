import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:uuid/uuid.dart';
import '../model/family_model.dart';

class HomePageController extends GetxController {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final RxList<String> _uniqueFamilyTitleList = <String>[].obs;
  final RxMap _myData = {}.obs;
  RxMap get myData => _myData;

  @override
  void onInit() {
    super.onInit();
    getData();
  }

  Future<void> getData() async {
    await getUniqueFamilyTitle();
    getFamily();
  }

  Future<void> insertFamilyData(
      String name,
      String age,
      String familyTitle,
      String relationShip,
      ) async {
    final uuid = Uuid().v1();
    final data = FamilyModel(
      familyId: uuid,
      name: name,
      age: age,
      familyTitle: _capitalizeFirstLetter(familyTitle),
      relationShip: relationShip,
    ).toMap();
    await _firebaseFirestore.collection('family').doc(uuid).set(data);
    Get.back();
    Get.snackbar(
      'Successful',
      'Inserted family data',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green,
    );
    getData();
  }

  String _capitalizeFirstLetter(String text) {
    if (text.isEmpty) return text;
    return text.substring(0, 1).toUpperCase() + text.substring(1).toLowerCase();
  }

  Stream<List<FamilyModel>> fetchFamilyData() {
    return _firebaseFirestore.collection('family').snapshots().map(
          (snapshot) => snapshot.docs
          .map((doc) => FamilyModel.fromJson(doc.data()))
          .toList(),
    );
  }

  Future<void> getUniqueFamilyTitle() async {
    final familyData = await _firebaseFirestore.collection('family').get();
    for (final doc in familyData.docs) {
      final familyModel = FamilyModel.fromJson(doc.data());
      if (!_uniqueFamilyTitleList.contains(familyModel.familyTitle)) {
        _uniqueFamilyTitleList.add(familyModel.familyTitle);
      }
    }
    print('Family Titles: $_uniqueFamilyTitleList');
  }

  Future<List<FamilyModel>> getFamilyByTitle(String title) async {
    final familyData = await _firebaseFirestore
        .collection('family')
        .where('familyTitle', isEqualTo: title)
        .get();
    return familyData.docs
        .map((doc) => FamilyModel.fromJson(doc.data()))
        .toList();
  }

  void getFamily() async {
    for (final title in _uniqueFamilyTitleList) {
      final familyList = await getFamilyByTitle(title);
      _myData[title] = familyList;
    }
  }

  Future<void> deleteFamilyData(String id) async {
    try {
      await _firebaseFirestore.collection('family').doc(id).delete();
      Get.snackbar(
        'Delete',
        'Family member is deleted.',
        snackPosition: SnackPosition.BOTTOM,
        colorText: Colors.white60,
        backgroundColor: Colors.red,
      );
      // Refresh data after deleting a family member
      getData();
    } catch (e) {
      print('Error deleting family member: $e');
      Get.snackbar(
        'Error',
        'Failed to delete family member.',
        snackPosition: SnackPosition.BOTTOM,
        colorText: Colors.white60,
        backgroundColor: Colors.red,
      );
    }
  }

  Future<void> updateFamilyData(
      String id,
      String name,
      String age,
      String relationship,
      ) async {
    final data = {
      'name': name,
      'age': age,
      'relationShip': relationship,
    };
    await _firebaseFirestore.collection('family').doc(id).update(data);
    Get.back();
    Get.snackbar(
      'Update',
      'Family member is updated.',
      snackPosition: SnackPosition.BOTTOM,
      colorText: Colors.white60,
      backgroundColor: Colors.green,
    );
    getData();
  }
}
