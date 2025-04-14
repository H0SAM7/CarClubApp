import 'dart:developer';
import 'package:car_club/core/Models/car_model.dart';
import 'package:car_club/core/error/firebase_failure.dart';
import 'package:car_club/features/home/data/home_repo/home_repo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';

class HomeRepoImp extends HomeRepo {

  @override
  Future<Either<Failure, List<CarModel>>> getAllProducts() async {
    try {
      QuerySnapshot querySnapshot =
          await firestore.collection('Cars').get();
      List<CarModel> products = querySnapshot.docs
          .map((doc) => CarModel.fromDocument(doc))
          .toList();
      return right(products);
    } catch (e) {
      log('Error getting products: $e');
      return left(FirebaseFailure.fromFirebaseException(e as Exception));
    }
  }



  
}
