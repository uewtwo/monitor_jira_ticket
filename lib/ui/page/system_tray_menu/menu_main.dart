import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:system_tray/system_tray.dart';

import '../../../util/appWindow.dart';

class MenuMain {
  late List<MenuItem> menuList;

  MenuMain() {
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
      MenuSeparator(),
      MenuItemLabel(
        label: 'Quit',
        onClicked: (_) => appWindow.close(),
      ),
    ];
  }
}
