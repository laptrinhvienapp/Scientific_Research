import 'package:flutter/material.dart';
import 'package:project/services/firebase_services.dart';
import 'package:project/utils/utils.dart';

class TopBar extends StatelessWidget {
  const TopBar({super.key});

  @override
  Widget build(BuildContext context) {
    final String userName = FirebaseServices.currentUser.userName;
    final String firstLetter = userName.isNotEmpty ? userName[0].toUpperCase() : '?';

    return Card(
      elevation: 1,
      color: Colors.grey.shade50,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.zero,
      ),
      child: Padding(
        padding: AppSpacings.allSmall,
        child: Row(
          children: [
            CircleAvatar(
              radius: 25,
              backgroundColor: Colors.green,
              child: Text(
                firstLetter,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}