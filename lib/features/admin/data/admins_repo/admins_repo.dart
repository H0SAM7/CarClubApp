import 'package:car_club/core/Models/car_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:image_picker/image_picker.dart';
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  final ImagePicker picker = ImagePicker();
abstract class AdminsRepo {
  
  Future<void> addProduct({required CarModel carModel});
  Future<void> deleteProduct({required String parcode});
  Future<void> updateProduct({required CarModel carModel});

}


