import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:system_tray/system_tray.dart';

import '../../../data/model/config/jira_config.dart';
import '../../../data/state/deploy_status.dart';
import '../../../util/appWindow.dart';
import '../../../util/deploy.dart';
import '../../../util/image.dart';
import '../../../util/local_notification.dart';
import '../../widget/title_bar.dart';
import '../system_tray_menu/menu_main.dart';
import 'login_status_page.dart';

class StatefulSystemtray extends StatefulWidget {
  final TextEditingController subDomainController;
  final TextEditingController jqlController;
  final TextEditingController emailController;
  final TextEditingController apiTokenController;
  final FlutterLocalNotificationsPlugin notificationPlugin;
  final AsyncValue<JiraConfig> jiraConfig;

  const StatefulSystemtray({
    required this.subDomainController,
    required this.jqlController,
    required this.emailController,
    required this.apiTokenController,
    required this.notificationPlugin,
    required this.jiraConfig,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulSystemtray> createState() => _StatefulSystemtrayState();
}

class _StatefulSystemtrayState extends State<StatefulSystemtray> {
  final SystemTray _systemTray = SystemTray();
  final Menu _menuMain = Menu();

  final DeployStatus _deployStatus = DeployStatus();

  @override
  void initState() {
    super.initState();
    requestPermissions(widget.notificationPlugin);
    initializeNotifications(widget.notificationPlugin);

    checkDeployStatus(
      _systemTray,
      _deployStatus,
      widget.notificationPlugin,
    );

    doWhenWindowReady(() {
      initSystemTray();
      showAppWindow();
    });
  }

  Future<void> initSystemTray() async {
    final mainMenuList = MenuMain().menuList;

    // We first init the systray menu and then add the menu entries
    await _systemTray.initSystemTray(
        iconPath: getTrayIconPathFromStatus('loading'));
    _systemTray.setTitle("merge status");

    // handle system tray event
    _systemTray.registerSystemTrayEventHandler((eventName) {
      debugPrint("eventName: $eventName");
      if (eventName == kSystemTrayEventClick ||
          eventName == kSystemTrayEventRightClick) {
        _systemTray.popUpContextMenu();
      }
    });

    await _menuMain.buildFrom(mainMenuList);
    _systemTray.setContextMenu(_menuMain);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WindowBorder(
        color: const Color.fromARGB(255, 5, 118, 175),
        width: 1,
        child: Scaffold(
          body: Column(
            children: [
              TitleBar(hideOnClick: hideOnClick),
              LoginStatusPage(
                subDomainController: widget.subDomainController,
                jqlController: widget.jqlController,
                emailController: widget.emailController,
                apiTokenController: widget.apiTokenController,
                systemTray: _systemTray,
                menu: _menuMain,
              ),
            ],
          ),
        ),
      ),
    );
  }

  hideOnClick() {
    return () => appWindow.hide();
  }
}
