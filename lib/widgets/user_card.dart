import 'package:flutter/material.dart';
import 'package:project/models/user_model.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'package:project/utils/utils.dart';

class UserCard extends StatelessWidget {
  final UserModel userModel;

  const UserCard({
    super.key,
    required this.userModel,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 80.0,
      child: Card.outlined(
        child: Padding(
          padding: AppSpacings.allSmall,
          child: Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundColor: Colors.green.shade100,
                child: Center(
                  child: Text(
                    // Lấy chữ cái đầu tiên của tên người dùng và viết hoa
                    userModel.userName.substring(0, 1).toUpperCase(),
                  ),
                ),
              ),
              AppSpacings.widthMedium,
              Text(
                userModel.userName,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleMedium,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
              Spacer(),
              ZegoSendCallInvitationButton(
                buttonSize: Size(40, 40),
                iconSize: Size(40, 40),
                isVideoCall: true,
                resourceID: "zegouikit_call",
                invitees: [
                  ZegoUIKitUser(
                    id: userModel.userID,
                    name: userModel.userName,
                  ),
                ],
              ),
              AppSpacings.widthMedium,
              ZegoSendCallInvitationButton(
                buttonSize: Size(40, 40),
                iconSize: Size(40, 40),
                isVideoCall: false,
                resourceID: "zegouikit_call",
                invitees: [
                  ZegoUIKitUser(
                    id: userModel.userID,
                    name: userModel.userName,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}