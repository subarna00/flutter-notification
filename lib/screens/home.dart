import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:notification/screens/second_screen.dart';
import 'package:notification/services/local_notification_service.dart';

class MyHome extends StatefulWidget {
  const MyHome({super.key});

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  late final LocalNotificationService service;

  @override
  void initState() {
    service = LocalNotificationService();
    service.initlize();
    listenToNotification();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notification"),
        centerTitle: true,
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(24),
        child: Center(
          child: SizedBox(
            height: 300,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Text("Notification Test guys"),
                ElevatedButton(
                    onPressed: () async {
                      await service.showNotification(
                          id: 0,
                          title: "title",
                          body: "Notification first",
                          payload: "Asdasdasd");
                    },
                    child: const Text("Show Local Notificaiton")),
                ElevatedButton(
                    onPressed: () async {
                      await service.showScheduleNotification(
                          id: 0,
                          title: "title",
                          body: "Notification first",
                          seconds: 5);
                    },
                    child: const Text("Show Scheduled Notificaiton")),
                ElevatedButton(
                    onPressed: () async {
                      await service.showNotificationWithPayload(
                          id: 0,
                          title: "title",
                          body: "Notification first",
                          payload: "Payload Navigation");
                    },
                    child: const Text("Show  Notificaiton with payload")),
              ],
            ),
          ),
        ),
      )),
    );
  }

  void listenToNotification() =>
      service.onNotificationClick.stream.listen(onNotificationListenter);

  void onNotificationListenter(String? payload) {
    if (payload != null && payload.isNotEmpty) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => SecondScreen(payload: payload)));
    }
  }
}
