import 'package:bloc/bloc.dart';
import 'package:car_club/core/Models/car_model.dart';
import 'package:car_club/features/home/data/home_repo/home_repo_impl.dart';

import 'package:meta/meta.dart';

part 'all_products_state.dart';

class AllProductsCubit extends Cubit<AllProductsState> {
  AllProductsCubit() : super(AllProductsInitial());

  Future<void> getAllProducts() async {
    emit(AllProductLoading());
    var result = await HomeRepoImp().getAllProducts();
    result.fold(
      (failure) => emit(AllProductsFailure(errMessage: failure.errMessage!)),
      (products) => emit(AllProductsSuccess(products: products)),
    );
  }
}
