import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:system_tray/system_tray.dart';

import '../../../util/appWindow.dart';

class MenuMain {
  late List<MenuItem> menuList;

  // final MenuItemLabel menuShowLicenses;
  final MenuItemLabel menuQuit;

  MenuMain({
    // required this.menuShowLicenses,
    required this.menuQuit,
  }) {
    initMenuMain();
  }

  void initMenuMain() {
    menuList = [
      MenuItemLabel(
        label: 'Preference',
        onClicked: (_) => showAppWindow(),
      ),
      MenuSeparator(),
      MenuItemLabel(
        label: 'Check For Update(WIP)',
      ),
      MenuItemLabel(
        label: 'Bugs And Request(WIP)',
      ),
      // menuShowLicenses,
      MenuSeparator(),
      menuQuit,
      // MenuItemLabel(
      //   label: 'Quit',
      //   onClicked: (_) => appWindow.close(),
      // )
    ];
  }
}
