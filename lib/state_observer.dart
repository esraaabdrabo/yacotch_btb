import 'package:flutter/material.dart';
import 'package:trainee_restaurantapp/core/datasources/shared_preference.dart';
import 'package:trainee_restaurantapp/features/trainer/chat/view/widgets/agora/functions.dart';

class MyAppStateObserver extends WidgetsBindingObserver {
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    //if the application latest state is detached then it's terminated
    //will be used in background handler for fcm
    (await SpUtil.instance).putString("state", "$state");
    // Handle state changes (resumed, inactive, paused, etc.)
    if (state == AppLifecycleState.resumed) {
      //if this condition is true then it's indticates that the app has come from background

      // App is in the foreground from background
      AgoraFunctions.handleNavigatingToAgora();
    } else if (state == AppLifecycleState.inactive) {
      // App is in an inactive state
    } else if (state == AppLifecycleState.paused) {
      // App is in the background
    } else if (state == AppLifecycleState.detached) {
      // App is terminated
    }
  }
}
