import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AboutAppListTiles extends StatelessWidget {
  const AboutAppListTiles({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        ListTile(
          leading: Icon(CupertinoIcons.square_grid_2x2),
          title: Text("About US"),
          trailing: CupertinoButton(onPressed: null, child: Icon(Icons.arrow_forward_ios_rounded)),
        ),
        ListTile(
          leading: Icon(CupertinoIcons.exclamationmark_circle),
          title: Text("Change Account Picture"),
          trailing: CupertinoButton(onPressed: null, child: Icon(Icons.arrow_forward_ios_rounded)),
        ),
        ListTile(
          leading: Icon(CupertinoIcons.bolt_fill),
          title: Text("Help & Feedback"),
          trailing: CupertinoButton(onPressed: null, child: Icon(Icons.arrow_forward_ios_rounded)),
        ),
        ListTile(
          leading: Icon(CupertinoIcons.hand_thumbsup),
          title: Text("Support US"),
          trailing: CupertinoButton(onPressed: null, child: Icon(Icons.arrow_forward_ios_rounded)),
        ),
      ],
    );
  }
}