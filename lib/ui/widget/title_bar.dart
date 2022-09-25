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
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [backgroundStartColor, backgroundEndColor],
              stops: [0.0, 1.0]),
        ),
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

const backgroundStartColor = Color.fromARGB(255, 55, 231, 244);
const backgroundEndColor = Color.fromARGB(255, 39, 116, 211);
