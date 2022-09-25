import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../data/model/config/jira_config.dart';
import 'login_status_page.dart';
import '../system_tray_menu/menu_main.dart';
import '../../widget/title_bar.dart';
import '../../../util/deploy.dart';
import '../../../util/image.dart';
import 'package:system_tray/system_tray.dart';

import '../../../data/state/deploy_status.dart';
import '../../../util/local_notification.dart';

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
  final AppWindow _appWindow = AppWindow();
  final SystemTray _systemTray = SystemTray();
  final Menu _menuMain = Menu();

  final DeployStatus _deployStatus = DeployStatus();

  @override
  void initState() {
    super.initState();
    requestPermissions(widget.notificationPlugin);
    initializeNotifications(widget.notificationPlugin);
    initSystemTray();
    checkDeployStatus(
      _systemTray,
      _deployStatus,
      widget.notificationPlugin,
    );

    doWhenWindowReady(() {
      final win = appWindow;
      const initialSize = Size(600, 450);
      win.minSize = initialSize;
      win.size = initialSize;
      win.alignment = Alignment.center;
      win.title = "Jira Ticket Monitor";
      win.show();
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> initSystemTray() async {
    final mainMenuList = MenuMain(appWindow: _appWindow).menuList;

    // We first init the systray menu and then add the menu entries
    await _systemTray.initSystemTray(
        iconPath: getTrayIconPathFromStatus('loading'));
    _systemTray.setTitle("merge status");

    // handle system tray event
    _systemTray.registerSystemTrayEventHandler((eventName) {
      debugPrint("eventName: $eventName");
      if (eventName == kSystemTrayEventClick) {
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
      home: Scaffold(
        body: WindowBorder(
          color: const Color(0xFF805306),
          width: 1,
          child: Column(
            children: [
              const TitleBar(),
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
}
