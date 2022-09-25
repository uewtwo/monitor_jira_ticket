import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';

import 'window_buttons.dart';

class TitleBar extends StatelessWidget {
  final VoidCallback hideOnClick;

  const TitleBar({Key? key, required this.hideOnClick}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WindowTitleBarBox(
      child: Container(
        decoration: const BoxDecoration(color: Colors.blue),
        child: Row(
          children: [
            WindowButtons(hideOnClick: hideOnClick),
            Expanded(
              child: MoveWindow(),
            ),
          ],
        ),
      ),
    );
  }
}
