import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:car_club/core/Models/car_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchInitial());

  Future<List<CarModel>> searchCarsByName(String query) async {
    try {
      final snapshot =
          await FirebaseFirestore.instance.collection('Cars').get();

      List<CarModel> allCars =
          snapshot.docs.map((doc) => CarModel.fromDocument(doc)).toList();

      // Filter cars where the name contains the search query (case-insensitive)
      List<CarModel> filteredCars =
          allCars
              .where(
                (car) => car.name.toLowerCase().contains(query.toLowerCase()),
              )
              .toList();

      return filteredCars;
    } catch (e) {
      print('Error searching cars: $e');
      return [];
    }
  }
}
