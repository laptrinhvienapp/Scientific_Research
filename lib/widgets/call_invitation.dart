import 'package:flutter/material.dart';
import 'package:project/screens/layout_gui.dart';
import 'package:project/services/firebase_services.dart';
import 'package:project/utils/utils.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'package:zego_uikit_signaling_plugin/zego_uikit_signaling_plugin.dart';

class CallInvitation extends StatefulWidget {
  const CallInvitation({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  State<CallInvitation> createState() => _CallInvitationState();
}

class _CallInvitationState extends State<CallInvitation> {
  final currentUser = FirebaseServices.currentUser;
  String? _currentCallID;

  @override
  void initState() {
    super.initState();

    ZegoUIKitPrebuiltCallInvitationService().init(
      appID: AppSecrets.appID,
      appSign: AppSecrets.appSign,
      userID: currentUser.userID,
      userName: currentUser.userName,
      plugins: [
        ZegoUIKitSignalingPlugin(),
      ],
      requireConfig: (ZegoCallInvitationData data) {
        _currentCallID = data.callID;
        return ZegoUIKitPrebuiltCallConfig();
      },
      events: ZegoUIKitPrebuiltCallEvents(
        user: ZegoCallUserEvents(
          onEnter: (ZegoUIKitUser user) {
            if (_currentCallID != null) {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => LayoutGui(
                    callID: _currentCallID!,
                    appID: AppSecrets.appID,
                    appSign: AppSecrets.appSign,
                    userID: currentUser.userID,
                    userName: currentUser.userName,
                    config: ZegoUIKitPrebuiltCallConfig(
                      layout: ZegoLayoutPictureInPictureConfig(
                        smallViewSize: Size.zero,
                      ),
                    ),
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    ZegoUIKitPrebuiltCallInvitationService().uninit();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}