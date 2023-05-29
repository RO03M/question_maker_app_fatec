import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:question_maker_app/routes/routes.dart';
import 'package:random_avatar/random_avatar.dart';

enum PopupMenuOptions {
  signOut,
  signIn
}

class ProfileAvatarAction extends StatelessWidget {
  const ProfileAvatarAction({super.key});

  @override
  Widget build(BuildContext context) {
    return FirebaseAuth.instance.currentUser != null ? CircleAvatar(
      child: PopupMenuButton(
        position: PopupMenuPosition.under,
        child: RandomAvatar(FirebaseAuth.instance.currentUser!.displayName ?? FirebaseAuth.instance.currentUser!.email ?? FirebaseAuth.instance.currentUser!.uid),
        onSelected: (value) {
          switch (value) {
            case PopupMenuOptions.signOut:
            case PopupMenuOptions.signIn:
              FirebaseAuth.instance.signOut();
              Navigator.of(context).popAndPushNamed(RoutesManager.login);
              break;
          }
        },
        itemBuilder: (contenxt) {
          if (FirebaseAuth.instance.currentUser!.isAnonymous) {
            return <PopupMenuEntry<PopupMenuOptions>>[
              PopupMenuItem<PopupMenuOptions>(
                value: PopupMenuOptions.signIn,
                child: Text("Logar")
              )
            ];
          } else {
            return <PopupMenuEntry<PopupMenuOptions>>[
              PopupMenuItem<PopupMenuOptions>(
                value: PopupMenuOptions.signOut,
                child: Text("Sair")
              )
            ];
          }
        },
      )
    ) : Container();
  }
}