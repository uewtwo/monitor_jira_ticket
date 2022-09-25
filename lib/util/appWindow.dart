import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';

// void showAppWindow(AppWindow app) {
void showAppWindow() {
  const initialSize = Size(600, 450);
  appWindow.minSize = initialSize;
  appWindow.size = initialSize;
  appWindow.alignment = Alignment.center;
  appWindow.title = "Jira Ticket Monitor";
  // app.show();
  appWindow.show();
}
