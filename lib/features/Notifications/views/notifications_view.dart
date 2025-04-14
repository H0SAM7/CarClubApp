
import 'package:car_club/features/Notifications/views/widgets/notifi_list_view.dart';
import 'package:flutter/material.dart';

class NotificationsView extends StatelessWidget {
  const NotificationsView({super.key});
  static String id = 'NotificationsView';
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 1,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Notifications'),
          elevation: 0,
          backgroundColor: Colors.white,
          bottom: TabBar(
            unselectedLabelStyle: const TextStyle(color: Color(0xffA5A7B9)),
            labelColor: Colors.blueAccent,
            indicatorColor: Colors.blueAccent,
            dividerColor:Colors.blueAccent,
            tabs: const <Widget>[
              Tab(
                text: 'Notifications',
              ),
              Tab(
                text: 'Messages',
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            const Expanded(child: NotifiListView(notificationsList: [],)),
             
            Container(),
          ],
        ),
      ),
    );
  }
}
