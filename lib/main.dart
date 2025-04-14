import 'package:car_club/core/routes/app_routes.dart';
import 'package:car_club/core/utils/bloc_observer.dart';
import 'package:car_club/features/admin/presentation/manager/admin_cubit/admin_cubit.dart';
import 'package:car_club/features/auth/manager/auth_cubit/auth_cubit.dart';
import 'package:car_club/features/home/presentation/manager/all_products_cubit/all_products_cubit.dart';
import 'package:car_club/features/home/presentation/manager/search_cubit/search_cubit.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:dart_openai/dart_openai.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // Set your OpenAI API key here
  Bloc.observer = SimpleBlocObserever();
  // OpenAI.apiKey =
  //     "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";

  // await Supabase.initialize(
  //   url: 'https://crgwwfzifppleytrqcmh.supabase.co',
  //   anonKey:
  //       'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImNyZ3d3ZnppZnBwbGV5dHJxY21oIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzkyMjI0MzksImV4cCI6MjA1NDc5ODQzOX0.cjC38O9-YnZ916IaZDQXee4ONfdnV3Fy14ymnpOAZ4c',
  // );
 FirebaseMessaging messaging = FirebaseMessaging.instance;
   await messaging.requestPermission(
    alert: true,
    badge: true,
    sound: true,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthCubit(), lazy: true),
        BlocProvider(create: (context) => SearchCubit(), lazy: true),

        BlocProvider(create: (context) => AdminCubit(), lazy: true),
        BlocProvider(
          create: (context) => AllProductsCubit()..getAllProducts(),
          lazy: true,
        ),
      ],
      child: MaterialApp(
        initialRoute: AppRoutes.initialRoute,
        onGenerateRoute: AppRoutes.generateRoute,

        routes: AppRoutes.routes,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
