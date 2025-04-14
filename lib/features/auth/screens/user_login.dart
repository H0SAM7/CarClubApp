import 'package:car_club/bottom_navv_bar.dart';
import 'package:car_club/core/utils/assets.dart';
import 'package:car_club/core/utils/constants.dart';
import 'package:car_club/core/widgets/custom_progress_hud.dart';
import 'package:car_club/core/widgets/show_custom_alert.dart';
import 'package:car_club/features/auth/manager/auth_cubit/auth_cubit.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import '../../admin/presentation/views/admin_login.dart';
import 'user_signup.dart';
import '../../profile/profile.dart';

class LoginScreen extends StatefulWidget {
  static String id = 'LoginScreen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool _isLoading = false;

  Future<void> _signIn() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter your email and password !')),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      final result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (result.user != null) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Login successful")));

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => Profile()),
        );
      }
    } on FirebaseAuthException catch (e) {
      String message = "Login failed";

      if (e.code == 'user-not-found') {
        message = " Email not found";
      } else if (e.code == 'wrong-password') {
        message = "The password is incorrect";
      } else {
        message = " ${e.message}";
      }

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(message)));
    } finally {
      setState(() => _isLoading = false);
    }
  }

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccess) {
          Navigator.pushReplacementNamed(context, BottomNavigator.id);
        } else if (state is AuthFailure) {
          showCustomAlert(
            context: context,
            type: AlertType.error,
            title: 'Error',
            description: state.errMessage,
            onPressed: () {
              Navigator.pushReplacementNamed(context, LoginScreen.id);
            },
            actionTitle: 'Ok',
          );
        }
      },
      builder: (context, state) {
        return CustomProgressHUD(
          inAsyncCall: state is AuthLoading,

          child: AbsorbPointer(
            absorbing: state is AuthLoading,

            child: Scaffold(
              backgroundColor: const Color.fromARGB(250, 241, 231, 231),
              body: Form(
                key: formKey,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SingleChildScrollView(
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
                                'User Login',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 5),
                              const Text(
                                'Please enter your email and password to continue',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                ),
                              ),
                              const SizedBox(height: 20),
                              const Text(
                                'Email',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
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
                              const Text(
                                'Password',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
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
                              Row(
                                children: [
                                  const Text('You have no account? '),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder:
                                              (context) => UserSignupScreen(),
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
                                      await BlocProvider.of<AuthCubit>(
                                        context,
                                      ).login(
                                        email: emailController.text,
                                        password: passwordController.text,
                                      );
                                            await FirebaseMessaging.instance
                                  .subscribeToTopic(notifiGroup);
                                    }
                                  },
                                  child: const Text(
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
              ),
            ),
          ),
        );
      },
    );
  }
}
