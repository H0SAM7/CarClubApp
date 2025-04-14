import 'dart:developer';
import 'package:car_club/core/Models/car_model.dart';
import 'package:car_club/features/admin/data/admins_repo/admins_repo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AdminsRepoImpl extends AdminsRepo {

  @override
  Future<void> addProduct({required CarModel carModel}) async {
    try {
      await firestore.collection('Cars').add(carModel.toMap());
      log('adding done');
    } catch (e) {
      log('Error adding product: $e');
    }
  }

  @override
  Future<void> deleteProduct({required String parcode}) async {
    try {
      QuerySnapshot querySnapshot = await firestore
          .collection('Cars')
          .where('code', isEqualTo: parcode)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        // Get the document ID of the first matching document
        String docId = querySnapshot.docs.first.id;

        // Delete the document with the matching ID
        await firestore.collection('Cars').doc(docId).delete();
        log('Product with parcode $parcode deleted successfully.');
      } else {
        log('No product found with parcode $parcode');
      }
    } catch (e) {
      log('Error deleting product: $e');
    }
  }

  @override
  Future<void> updateProduct({required CarModel carModel}) {
    // TODO: implement updateProduct
    throw UnimplementedError();
  }
}


// 1- admin car image 
// 2- upload image on fire storge 
// 3 - fire storeage function upload image and return image url
// 4 - store image url on fire base store
