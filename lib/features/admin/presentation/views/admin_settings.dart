import 'package:car_club/bottom_navv_bar.dart';
import 'package:car_club/core/utils/assets.dart';
import 'package:car_club/features/Notifications/services/send_notifications_view.dart';
import 'package:car_club/features/admin/presentation/views/add_car_view.dart';
import 'package:car_club/features/admin/presentation/views/booking_view.dart';
import 'package:car_club/features/admin/presentation/views/delete_view.dart';
import 'package:car_club/features/admin/presentation/views/reviews_view.dart';
import 'package:car_club/features/admin/presentation/views/admin_profile.dart';
import 'package:car_club/features/auth/screens/user_login.dart';
import 'package:car_club/features/chat/views/chat_view.dart';
import 'package:car_club/features/chat/views/contacts_view.dart';
import 'package:flutter/material.dart';

class AdminSettings extends StatelessWidget {
  static String id = 'AdminSettings';
  const AdminSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink[300],
        title: Text('Admin Mode'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(

          child: Column(
            children: [
              SizedBox(height: 15),
          
              ItemSetting(
                leading: Icon(Icons.person_2_outlined, color: Colors.blueAccent),
                title: 'Admin Profile',
                onTap: () {
                  Navigator.pushNamed(context, AdminProfileScreen.id);
                },
              ),
              Divider(thickness: .2),
          
              SizedBox(height: 5),
              ItemSetting(
                leading: Icon(Icons.add, color: Colors.blueAccent),
                title: 'Add Car',
                onTap: () {
                  Navigator.pushNamed(context, AddCarsView.id);
                },
              ),
              SizedBox(height: 5),
          
              ItemSetting(
                leading: Icon(Icons.remove, color: Colors.blueAccent),
                title: 'Delete Car',
                onTap: () {
                  Navigator.pushNamed(context, DeleteCarssView.id);
                },
              ),
              Divider(thickness: .2),
              SizedBox(height: 5),
          
              ItemSetting(
                leading: Icon(Icons.chat, color: Colors.blueAccent),
                title: 'Chats',
                onTap: () {
                  Navigator.pushNamed(context, ContactsScreen.id);
                },
              ),
              SizedBox(height: 5),
          
              ItemSetting(
                leading: Icon(Icons.reviews, color: Colors.blueAccent),
                title: 'Reviews',
                onTap: () {
                  Navigator.pushNamed(context, ReviewsScreen.id);
                },
              ),
              SizedBox(height: 5),
          
              ItemSetting(
                leading: Icon(
                  Icons.book_online_outlined,
                  color: Colors.blueAccent,
                ),
                title: 'Booking',
                onTap: () {
                  Navigator.pushNamed(context, ViewBookingsScreen.id);
                },
              ),
              Divider(thickness: .2),
                    SizedBox(height: 5),
          
              ItemSetting(
                leading: Icon(
                  Icons.notification_add,
                  color: Colors.blueAccent,
                ),
                title: 'Send Notification',
                onTap: () {
                  Navigator.pushNamed(context, SendNotifactionsSendView.id);
                },
              ),
              Divider(thickness: .2),
          
              SizedBox(height: 20),
              ItemSetting(
                leading: Icon(Icons.home_filled, color: Colors.blueAccent),
                title: 'Home',
                onTap: () {
                  Navigator.pushNamed(context, BottomNavigator.id);
                },
              ),
              SizedBox(height: 20),
              Divider(thickness: .2),
          
              ItemSetting(
                leading: Icon(Icons.logout, color: Colors.blueAccent),
                title: 'Logout',
                onTap: () {
                  Navigator.pushReplacementNamed(context, LoginScreen.id);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ItemSetting extends StatelessWidget {
  const ItemSetting({super.key, required this.title, this.leading, this.onTap});
  final String title;
  final Widget? leading;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ListTile(
        leading: leading,
        title: Text(title),
        trailing: Image.asset(Assets.imagesChevronRight),
      ),
    );
  }
}
