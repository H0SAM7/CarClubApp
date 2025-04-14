import 'package:car_club/core/Models/my_user.dart';
import 'package:car_club/core/utils/assets.dart';
import 'package:car_club/core/utils/constants.dart';
import 'package:car_club/core/widgets/custom_progress_hud.dart';
import 'package:car_club/core/widgets/show_custom_alert.dart';
import 'package:car_club/features/auth/manager/auth_cubit/auth_cubit.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../admin/presentation/views/admin_login.dart';
import 'user_login.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class UserSignupScreen extends StatefulWidget {
  const UserSignupScreen({super.key});
  static String id = 'UserSignupScreen';
  @override
  State<UserSignupScreen> createState() => _UserSignupScreenState();
}

class _UserSignupScreenState extends State<UserSignupScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _isLoading = false;

  // void _signUp() async {
  // final name = nameController.text.trim();
  // final email = emailController.text.trim();
  // final password = passwordController.text.trim();
  // final phone = phoneController.text.trim();

  //   if (name.isEmpty || email.isEmpty || password.isEmpty || phone.isEmpty) {
  //     ScaffoldMessenger.of(
  //       context,
  //     ).showSnackBar(SnackBar(content: Text("All fields are required !")));
  //     return;
  //   }

  //   setState(() => _isLoading = true);

  //   try {
  //     UserCredential result = await _auth.createUserWithEmailAndPassword(
  //       email: email,
  //       password: password,
  //     );

  //     User? user = result.user;

  //     if (user != null) {
  //       await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
  //         'uid': user.uid,
  //         'name': name,
  //         'email': email,
  //         'phone': phone,
  //         'role': 'client',
  //         'createdAt': Timestamp.now(),
  //       });

  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(content: Text(" Account created successfully")),
  //       );

  //       // Navigate to login screen
  //       Navigator.pushReplacement(
  //         context,
  //         MaterialPageRoute(builder: (_) => LoginScreen()),
  //       );
  //     }
  //   } on FirebaseAuthException catch (e) {
  //     String errorMessage = 'Registration failed  ';

  //     if (e.code == 'email-already-in-use') {
  //       errorMessage = 'Email has been used';
  //     } else if (e.code == 'weak-password') {
  //       errorMessage = 'password must be at least 6 charactes';
  //     }

  //     ScaffoldMessenger.of(
  //       context,
  //     ).showSnackBar(SnackBar(content: Text(errorMessage)));
  //   } catch (e) {
  //     ScaffoldMessenger.of(
  //       context,
  //     ).showSnackBar(SnackBar(content: Text(" Erroe : ${e.toString()}")));
  //   } finally {
  //     setState(() => _isLoading = false);
  //   }
  // }

//state 

// state mangment
// bloc as bloc -- cubit 
// email 
// bloc 

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool _isDialogShowing = false; // Prevent multiple alerts

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccess) {
          Navigator.pushReplacementNamed(context, UserSignupScreen.id);
        } else if (state is AuthSendVerification) {
          showCustomAlert(
            context: context,
            type: AlertType.info,
            title: 'Check  your email',
            description:
                'Please  check your email to verify your account, and you can Login ',
            onPressed: () {
              Navigator.pushNamed(context, LoginScreen.id);
            },
            actionTitle: 'Ok',
          );
        } else if (state is AuthVerificationFailure) {
          showCustomAlert(
            context: context,
            type: AlertType.warning,
            title: 'Time out',
            description: state.errMessage,
            onPressed: () {
              Navigator.pushReplacementNamed(context, UserSignupScreen.id);
            },
            actionTitle: 'Ok',
          );
        } else if (state is AuthFailure) {
          if (!_isDialogShowing) {
            _isDialogShowing = true; // Set flag to true before showing dialog

            showCustomAlert(
              context: context,
              type: AlertType.error,
              title: 'Error',
              description: state.errMessage,
              onPressed: () {
                _isDialogShowing = false; // Reset flag after dismissing

                Navigator.pushReplacementNamed(context, UserSignupScreen.id);
              },
              actionTitle: 'Ok',
            );
          }
        }
      },
      builder: (context, state) {
        return CustomProgressHUD(
          inAsyncCall: state is AuthLoading,
          child: Scaffold(
            backgroundColor: const Color.fromARGB(250, 241, 231, 231),
            body: Form(
              key: formKey,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 80),
                      Image.asset(Assets.imagesLogo, height: 100),
                      const SizedBox(height: 20),
                      Container(
                        padding: const EdgeInsets.all(16),
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
                            const Text(
                              'User Signup',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 10),
                            TextField(
                              controller: nameController,
                              decoration: InputDecoration(
                                hintText: 'Name',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide.none,
                                ),
                                fillColor: Colors.grey[200],
                                filled: true,
                              ),
                            ),
                            const SizedBox(height: 10),
                            TextField(
                              controller: emailController,
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                hintText: 'Email',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide.none,
                                ),
                                fillColor: Colors.grey[200],
                                filled: true,
                              ),
                            ),
                            const SizedBox(height: 10),
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
                            const SizedBox(height: 10),
                            TextField(
                              controller: phoneController,
                              keyboardType: TextInputType.phone,
                              decoration: InputDecoration(
                                hintText: 'Phone Number',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide.none,
                                ),
                                fillColor: Colors.grey[200],
                                filled: true,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                const Text('You have an account? '),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => LoginScreen(),
                                      ),
                                    );
                                  },
                                  child: const Text(
                                    'Click here',
                                    style: TextStyle(
                                      color: Colors.blue,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                const Text('Are you the administrator? '),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder:
                                            (context) => AdminLoginScreen(),
                                      ),
                                    );
                                  },
                                  child: const Text(
                                    'Click here',
                                    style: TextStyle(
                                      color: Colors.blue,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.pink[300],
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 14,
                                  ),
                                ),
                                onPressed: () async {
                                  if (formKey.currentState!.validate()) {
                                    MyUser user = MyUser(
                                      emailController.text,
                                      phoneController.text,
                                      passwordController.text,
                                      name: nameController.text,
                                    );
                                    await BlocProvider.of<AuthCubit>(
                                      context,
                                    ).register(userModel: user);
                                          await FirebaseMessaging.instance
                                  .subscribeToTopic(notifiGroup);
                                  }
                                },
                                child:
                                    _isLoading
                                        ? const CircularProgressIndicator(
                                          color: Colors.white,
                                        )
                                        : const Text(
                                          'Sign up',
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
            ),
          ),
        );
      },
    );
  }
}
