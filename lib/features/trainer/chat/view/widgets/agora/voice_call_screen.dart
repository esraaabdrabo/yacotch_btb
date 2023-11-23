import 'dart:async';
import 'dart:developer';
import 'package:agora_uikit/agora_uikit.dart';
import 'package:agora_uikit/controllers/rtc_buttons.dart';
import 'package:flutter/material.dart';
import 'package:trainee_restaurantapp/core/localization/language_helper.dart';
import 'package:trainee_restaurantapp/core/ui/toast.dart';
import 'package:trainee_restaurantapp/features/trainer/chat/view/widgets/agora/buttons/end_call.dart';
import 'package:trainee_restaurantapp/features/trainer/chat/view/widgets/agora/buttons/mute.dart';
import 'package:trainee_restaurantapp/features/trainer/chat/view/widgets/agora/disabled_video_widget.dart';
import 'agoraConfig.dart';

class VoiceCallScreen extends StatefulWidget {
  static const String routeName = "/VoiceScreen";

  final int? trainerId;
  final String channelName;
  final String remoteName;
  const VoiceCallScreen(this.trainerId, this.channelName,
      {required this.remoteName, Key? key})
      : super(key: key);

  @override
  State<VoiceCallScreen> createState() => _VoiceCallScreenState();
}

class _VoiceCallScreenState extends State<VoiceCallScreen> {
  AgoraClient? _client;

  @override
  void initState() {
    super.initState();
    _initAgora();
  }

  Future<void> _initAgora() async {
    _client = AgoraClient(
      agoraRtmChannelEventHandler:
          AgoraRtmChannelEventHandler(onMemberLeft: (_) {
        //show the user that the remote user left the group
        _handleMemberLeft();
      }),
      agoraConnectionData: AgoraConnectionData(
        rtmChannelName: widget.channelName,
        appId: AgoraConstants.appId,
        channelName: widget.channelName,
      ),
    );
    _client!.sessionController.createEvents(
        AgoraRtmChannelEventHandler(onMemberLeft: (_) {
      //show the user that the remote user left the group
      _handleMemberLeft();
    }), AgoraRtcEventHandlers());
    await _client?.initialize();
    await _client?.engine.disableVideo();
    //must call toggle camera to show the 'disabledVideoWidget'
    await toggleCamera(sessionController: _client!.sessionController);
  }

  void _handleMemberLeft() async {
    //show the user that the remote user left the group
    Toast.show(LanguageHelper.getTranslation(context)
        .the_member_left_the_call(widget.remoteName));
    await Future.delayed(const Duration(milliseconds: 500));
    context.mounted ? Navigator.pop(context) : null;
    _client?.release();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        _client!.release();
        return true;
      },
      child: Scaffold(
          body: Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          AgoraVideoViewer(
              client: _client!,
              showNumberOfUsers: true,
              layoutType: Layout.grid,
              disabledVideoWidget:
                  DisabledVideoWidget(_client!, remoteName: widget.remoteName)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              EndCallButton(_client!),
              MuteVoiceButton(client: _client),
            ],
          ),
        ],
      )),
    );
  }
}
