import 'package:car_club/core/utils/assets.dart';
import 'package:car_club/core/utils/constants.dart';
import 'package:car_club/features/admin/admin_account.dart';
import 'package:car_club/features/admin/presentation/views/admin_settings.dart';
import 'package:car_club/features/auth/manager/auth_cubit/auth_cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdminLoginScreen extends StatelessWidget {
  static String id = 'AdminLoginScreen';
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void _login(BuildContext context) async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    if (email == AdminAccount.email && password == AdminAccount.password) {
      // await BlocProvider.of<AuthCubit>(
      //   context,
      // ).login(email: AdminAccount.email, password: AdminAccount.password);
       await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      await FirebaseMessaging.instance.subscribeToTopic(notifiGroup);
      Navigator.pushNamed(context, AdminSettings.id);
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Invalid login credentials")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: const Color.fromARGB(250, 241, 231, 231),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 80),
              Image.asset(Assets.imagesLogo, height: 100),
              SizedBox(height: 20),
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withAlpha((0.3 * 255).toInt()),
                      blurRadius: 5,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Administrator Login',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 5),
                    TextField(
                      controller: emailController,
                      decoration: InputDecoration(
                        hintText: 'Admin Email',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none,
                        ),
                        fillColor: Colors.grey[200],
                        filled: true,
                      ),
                    ),
                    SizedBox(height: 10),
                    TextField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: 'Password',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none,
                        ),
                        fillColor: Colors.grey[200],
                        filled: true,
                      ),
                    ),
                    SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.pink[300],
                          padding: EdgeInsets.symmetric(vertical: 14),
                        ),
                        onPressed: () => _login(context),
                        child: Text(
                          'Sign in',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
