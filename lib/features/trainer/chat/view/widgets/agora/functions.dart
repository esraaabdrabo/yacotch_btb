import 'package:agora_uikit/agora_uikit.dart';
import 'package:flutter/material.dart';
import 'package:trainee_restaurantapp/core/datasources/shared_preference.dart';
import 'package:trainee_restaurantapp/core/dioHelper/dio_helper.dart';
import 'package:trainee_restaurantapp/core/navigation/helper.dart';
import 'package:trainee_restaurantapp/core/notifications/calls/payload_extractor.dart';
import 'package:trainee_restaurantapp/features/trainer/chat/view/widgets/agora/video_call_screen.dart';
import 'package:trainee_restaurantapp/features/trainer/chat/view/widgets/agora/voice_call_screen.dart';
import 'package:trainee_restaurantapp/main.dart';

abstract class AgoraFunctions {
  static bool isInitLoading(AsyncSnapshot<void> snapShot) =>
      snapShot.connectionState == ConnectionState.waiting;

  static Future<String> getToken(String channelName) async {
    var url =
        "https://api.yacotch.com/api/services/app/Agora/GetToken?Channel=$channelName";
    return (await DioHelper.get(url)
        .then((value) => value.data['result']['token']));
  }

  static bool isLocalDisabledVideo(AgoraClient client) =>
      client.sessionController.value.isLocalVideoDisabled;

  static bool isLocalMuteVoice(AgoraClient client) =>
      client.sessionController.value.isLocalUserMuted;
  //the process of navigating to voice/video screen from trminated or backgroung

  /// from shared pref get the cached screen name (voice-video-null)
  static Future<String?> getAgoraScreen() async =>
      (await SpUtil.instance).getString("navigate_to");

  ///if we found a screen name then we will need the payload to navigate
  static Future<String?> getAgoraPayload() async =>
      (await SpUtil.instance).getString("payload");

  ///do we have cached agora screen name ? (voice-video)
  static bool isAppOpenedForAgora(String? screenName) => screenName != null;

  ///check if the app is coming from background to make voice-video call
  ///or the user just open the app as normal
  static Future<void> handleNavigatingToAgora() async {
    String? agoraScreen = await getAgoraScreen();
    String? payload = await getAgoraPayload();
    if (isAppOpenedForAgora(agoraScreen)) {
      //clear the key we will not need it any more
      (await SpUtil.instance)
        ..remove("navigate_to")
        ..remove("payload");

      NavigationHelper.goto(
          screen: agoraScreen == "video"
              ? VideoCallScreen(PayLoadDataExtractor.getSenderId(payload),
                  PayLoadDataExtractor.getChannelName(payload),
                  remoteName: PayLoadDataExtractor.getSenderName(payload!))
              : VoiceCallScreen(PayLoadDataExtractor.getSenderId(payload),
                  PayLoadDataExtractor.getChannelName(payload),
                  remoteName: PayLoadDataExtractor.getSenderName(payload!)),
          context: navigatorKey.currentContext!);
    }
  }
}
