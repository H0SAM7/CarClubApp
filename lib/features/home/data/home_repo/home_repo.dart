import 'package:car_club/core/Models/car_model.dart';
import 'package:car_club/core/error/firebase_failure.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';

final FirebaseFirestore firestore = FirebaseFirestore.instance;


abstract class HomeRepo {

  Future<Either<Failure, List<CarModel>>> getAllProducts();

  

}


