import 'package:Hitchcake/ui/premium.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:Hitchcake/data/db/entity/app_user.dart';
import 'package:Hitchcake/data/provider/user_provider.dart';
import 'package:Hitchcake/ui/screens/chat_screen.dart';
import 'package:Hitchcake/ui/widgets/portrait.dart';
import 'package:Hitchcake/ui/widgets/rounded_button.dart';
import 'package:Hitchcake/ui/widgets/rounded_outlined_button.dart';
import 'package:Hitchcake/util/utils.dart';

class MatchedScreen extends StatelessWidget {
  static const String id = 'matched_screen';

  final String? myProfilePhotoPath;
  final String? myUserId;
  final String? otherUserProfilePhotoPath;
  final String? otherUserId;

  MatchedScreen(
      {this.myProfilePhotoPath,
      this.myUserId,
      this.otherUserProfilePhotoPath,
      this.otherUserId});

  void sendMessagePressed(BuildContext context) async {
    AppUser user = await Provider.of<UserProvider>(context, listen: false).user;
    final FirebaseAuth auth = FirebaseAuth.instance;
    final CollectionReference premiumCollection =
        FirebaseFirestore.instance.collection('chats');

    Future<bool> isDue() async {
      bool isDued = false;
      String currentUserID = auth.currentUser!.uid;

      FirebaseFirestore.instance
          .collection('chats')
          .where(FieldPath.documentId,
              isGreaterThanOrEqualTo: currentUserID,
              isLessThan: '${currentUserID}z')
          .get()
          .then((querySnapshot) {
        int count = 0;
        for (QueryDocumentSnapshot doc in querySnapshot.docs) {
          if (doc.id.contains(currentUserID)) {
            count++;
            if (count > 3) {
              // ignore: use_build_context_synchronously
              Navigator.push(
                context,
                MaterialPageRoute<void>(
                  builder: (BuildContext context) => Premium(),
                ),
              );
              print(currentUserID + ' sub is due');
              isDued = true;
            } else {
              //ignore: use_build_context_synchronously
              Navigator.pushNamedAndRemoveUntil(
                  context, ChatScreen.id, (route) => false,
                  arguments: {
                    "chat_id": compareAndCombineIds(myUserId!, otherUserId!),
                    "user_id": user.id,
                    "other_user_id": otherUserId
                  });
            }
          }
        }
      }).catchError((error) => print('Error getting documents: $error'));

      return isDued;
    }

    isDue();
    // ignore: use_build_context_synchronously
    // Navigator.push(
    //   context,
    //   MaterialPageRoute<void>(
    //     builder: (BuildContext context) => Premium(),
    //   ),
    // );
  }

  void keepSwipingPressed(BuildContext context) {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(
            vertical: 42.0,
            horizontal: 18.0,
          ),
          margin: EdgeInsets.only(bottom: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset('images/logo.png', width: 40),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Portrait(imageUrl: myProfilePhotoPath ?? ''),
                    Portrait(imageUrl: otherUserProfilePhotoPath ?? '')
                  ],
                ),
              ),
              Column(
                children: [
                  RoundedButton(
                      text: 'SEND MESSAGE',
                      color: Colors.white,
                      onPressed: () {
                        sendMessagePressed(context);
                      }),
                  SizedBox(height: 20),
                  RoundedOutlinedButton(
                      text: 'KEEP SWIPING',
                      onPressed: () {
                        keepSwipingPressed(context);
                      }),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
