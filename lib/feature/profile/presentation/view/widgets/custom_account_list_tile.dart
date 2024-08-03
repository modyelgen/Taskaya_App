import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AccountListTiles extends StatelessWidget {
  const AccountListTiles({super.key,required this.showImageSheet,required this.showNameSheet});
  final Future<dynamic> Function() showImageSheet;
  final Future<dynamic> Function() showNameSheet;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading:const Icon(Icons.perm_identity_rounded),
          title: const Text("Change Account Name"),
          trailing: CupertinoButton(onPressed: showNameSheet, child: const Icon(Icons.arrow_forward_ios_rounded)),
        ),
        ListTile(
          leading: const Icon(CupertinoIcons.photo_fill),
          title: const Text("Change Account Picture"),
          trailing: CupertinoButton(onPressed: showImageSheet, child: const Icon(Icons.arrow_forward_ios_rounded)),
        ),
      ],
    );
  }
}