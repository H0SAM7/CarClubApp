import 'dart:developer';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:car_club/core/Models/car_model.dart';
import 'package:car_club/features/admin/data/admins_repo/admins_repo_impl.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
part 'admin_state.dart';

class AdminCubit extends Cubit<AdminState> {
  AdminCubit() : super(AdminInitial());

  Future<void> addProduct({required CarModel carModel}) async {
    emit(AdminLoading());
    try {
      await AdminsRepoImpl().addProduct(carModel: carModel);
      emit(AdminSuccess());
    } catch (e) {
      emit(AdminFailure(errMessage: e.toString()));
    }
  }



  Future<void> deleteProduct({required String parcode}) async {
    emit(AdminLoading());
    try {
      await AdminsRepoImpl().deleteProduct(parcode: parcode);
      emit(AdminSuccess());
    } catch (e) {
      emit(AdminFailure(errMessage: e.toString()));
    }
  }


  final ImagePicker _picker = ImagePicker();
  final SupabaseClient supabase = Supabase.instance.client;
  String? _imageLink                 ;
  String? get imageLink => _imageLink;

  Future<String> uploadImage({required XFile image}) async {
    try {
      // final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      // if (image == null) {
      //   throw Exception("لم يتم اختيار صورة");
      // }

      File file = File(image.path);
      String fileName = "images/${DateTime.now().millisecondsSinceEpoch}.jpg";
      await supabase.storage.from('images').upload(fileName, file);
      final String publicUrl =
          supabase.storage.from('images').getPublicUrl(fileName);
      _imageLink = publicUrl;
      log("✅ تم رفع الصورة وحفظ الرابط بنجاح!");
      return publicUrl;
    } catch (e) {
      log("❌ خطأ: $e");
      return ""; 
    }
  }


}
