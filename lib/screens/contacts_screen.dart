import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project/models/models.dart';
import 'package:project/services/firebase_services.dart';
import 'package:project/widgets/user_card.dart';
import 'package:project/widgets/widgets.dart';

class ContactsScreen extends StatelessWidget {
  const ContactsScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return CallInvitation(
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                TopBar(),
                Center(
                  child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseServices.buildViews,
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      final List<QueryDocumentSnapshot>? docs = snapshot.data?.docs;
                      if (docs == null || docs.isEmpty) {
                        return const Text('No data');
                      }
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: docs.length,
                        itemBuilder: (context, index) {
                          final model = UserModel.fromJson(
                            docs[index].data() as Map<String, dynamic>,
                          );
                          if (model.userName != FirebaseServices.currentUser.userName) {
                            return UserCard(userModel: model);
                          }
                          return const SizedBox.shrink();
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}