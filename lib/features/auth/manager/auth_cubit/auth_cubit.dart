import 'dart:developer';
import 'package:car_club/core/Models/my_user.dart';
import 'package:car_club/core/error/firebase_failure.dart';
import 'package:car_club/core/utils/functions/auth_helper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  Future<void> register({required MyUser userModel}) async {
    emit(AuthLoading());
    try {
      final userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: userModel.email,
            password: userModel.password,
          );
      User? user = userCredential.user;
      if (user != null) {
        if (!user.emailVerified) {
          await user.sendEmailVerification();
          emit(AuthSendVerification());
          log('Verification email sent. Please check your inbox.');
        }
        bool eVerified = await waitForEmailVerification(user);
        await checkEmailVerification(user);

        if (eVerified) {
          await FirebaseFirestore.instance
              .collection('users')
              .doc(user.uid)
              .set({
                'email': userModel.email,
                'name': userModel.name,
                'phone': userModel.phone,
              });

          emit(AuthSuccess());

          log('User account created successfully.');
        } else {
          await user.delete();
          emit(AuthVerificationFailure());
        }
      }
    } catch (e) {
      emit(
        AuthFailure(
          errMessage:
              FirebaseFailure.fromFirebaseException(
                e as Exception,
              ).errMessage.toString(),
        ),
      );
    }
  }

  Future<void> login({required String email, required String password}) async {
    emit(AuthLoading());
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (!credential.user!.emailVerified) {
        emit(AuthVerificationFailure());
        return;
      }
      emit(AuthSuccess());
    } catch (e) {
      emit(
        AuthFailure(
          errMessage:
              FirebaseFailure.fromFirebaseException(
                e as Exception,
              ).errMessage.toString(),
        ),
      );
    }
  }

  Future<void> resetPassword(String email) async {
    emit(AuthLoading());
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      emit(AuthSuccess());
    } catch (e) {
      emit(
        AuthFailure(
          errMessage:
              FirebaseFailure.fromFirebaseException(
                e as Exception,
              ).errMessage.toString(),
        ),
      );
    }
  }
  
}
