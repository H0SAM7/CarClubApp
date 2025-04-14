import 'package:car_club/bottom_navv_bar.dart';
import 'package:car_club/features/general/edit_profile.dart';
import 'package:car_club/features/Notifications/services/send_notifications_view.dart';
import 'package:car_club/features/Notifications/views/notifi_view.dart';
import 'package:car_club/features/home/presentation/views/car_details.dart';
import 'package:car_club/core/Models/car_model.dart';
import 'package:car_club/features/admin/presentation/views/add_car_view.dart';
import 'package:car_club/features/admin/presentation/views/admin_settings.dart';
import 'package:car_club/features/admin/presentation/views/booking_view.dart';
import 'package:car_club/features/admin/presentation/views/reviews_view.dart';
import 'package:car_club/features/admin/presentation/views/admin_login.dart';
import 'package:car_club/features/admin/presentation/views/admin_profile.dart';
import 'package:car_club/features/auth/screens/user_login.dart';
import 'package:car_club/features/auth/screens/user_signup.dart';
import 'package:car_club/features/chat/views/chat_view.dart';
import 'package:car_club/features/chat/views/contacts_view.dart';
import 'package:car_club/features/home/presentation/views/home_view.dart';
import 'package:car_club/features/home/presentation/views/search_view.dart';
import 'package:car_club/features/profile/booking_history.dart';
import 'package:car_club/features/profile/purchase_history.dart';
import 'package:car_club/features/profile/profile.dart';
import 'package:flutter/material.dart';
import '../../features/admin/presentation/views/delete_view.dart';

abstract class AppRoutes {
  static String? initialRoute = AdminSettings.id;
  static Map<String, Widget Function(BuildContext)> routes = {
    BottomNavigator.id: (context) => const BottomNavigator(),
    //navigation bar #########
    AdminLoginScreen.id: (context) => AdminLoginScreen(),
    AdminProfileScreen.id: (context) => AdminProfileScreen(),
    UserSignupScreen.id: (context) => UserSignupScreen(),
    LoginScreen.id: (context) => LoginScreen(),
    Profile.id: (context) => Profile(),
    HomeView.id: (context) => HomeView(),
    AddCarsView.id: (context) => AddCarsView(),
    // ChatView.id: (context) => ChatView(contactEmail: ,),
    AdminSettings.id: (context) => AdminSettings(),
    DeleteCarssView.id: (context) => DeleteCarssView(),
    ViewBookingsScreen.id: (context) => ViewBookingsScreen(),
    ReviewsScreen.id: (context) => ReviewsScreen(),
    ContactsScreen.id: (context) => ContactsScreen(),
    SearchPage.id: (context) => SearchPage(),
    EditProfileScreen.id: (context) => EditProfileScreen(),
    PurchaseHistory.id: (context) => PurchaseHistory(),
    BookingHistory.id: (context) => BookingHistory(),
    SendNotifactionsSendView.id: (context) => SendNotifactionsSendView(),
    NotifiView.id: (context) => NotifiView(),
  };
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case CarPage.id:
        final car = settings.arguments as CarModel;
        return MaterialPageRoute(builder: (context) => CarPage(carModel: car));
      case ChatView.id:
        final contactEmail = settings.arguments as String;
        return MaterialPageRoute(
          builder: (context) => ChatView(contactEmail: contactEmail),
        );
      default:
        return MaterialPageRoute(
          builder:
              (context) =>
                  const Scaffold(body: Center(child: Text('Page Not Found'))),
        );
    }
  }
}
