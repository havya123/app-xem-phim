import 'package:baitap08/config/size_config.dart';
import 'package:baitap08/screen/notification/widget/notification_widget.dart';
import 'package:flutter/material.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              const Center(
                  child: Text(
                'Notification',
                style: TextStyle(color: Colors.white, fontSize: 25),
              )),
              ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) => spaceHeight(context),
                  separatorBuilder: (context, index) {
                    return const NotificationWidget();
                  },
                  itemCount: 5)
            ],
          ),
        ),
      ),
    );
  }
}
