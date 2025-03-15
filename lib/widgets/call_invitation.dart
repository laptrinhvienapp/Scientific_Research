import 'package:flutter/material.dart';
import 'package:project/services/firebase_services.dart';
import 'package:project/utils/app_secrets.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'package:zego_uikit_signaling_plugin/zego_uikit_signaling_plugin.dart';

class CallInvitation extends StatelessWidget {
  const CallInvitation({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    /// Lấy thông tin người dùng hiện tại
    final currentUser = FirebaseServices.currentUser;

    /// 4/5. Khởi tạo ZegoUIKitPrebuiltCallInvitationService khi tài khoản được đăng nhập hoặc đăng nhập lại
    ZegoUIKitPrebuiltCallInvitationService().init(
      appID: AppSecrets.appID,
      appSign: AppSecrets.appSign,
      userID: currentUser.userID,
      userName: currentUser.userName,
      plugins: [
        ZegoUIKitSignalingPlugin(),
      ],
    );
    return child;
  }
}