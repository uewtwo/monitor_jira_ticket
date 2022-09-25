import 'package:system_tray/system_tray.dart';

class MenuMain {
  late AppWindow appWindow;
  late List<MenuItem> menuList;

  MenuMain({required this.appWindow}) {
    initMenuMain(appWindow);
  }

  void initMenuMain(AppWindow app) {
    menuList = [
      MenuItemLabel(
        label: 'Login Status(WIP)',
      ),
      MenuSeparator(),
      MenuItemLabel(
        label: 'Preference(WIP)',
      ),
      MenuItemLabel(
        label: 'Check For Update(WIP)',
      ),
      MenuItemLabel(
        label: 'Bugs And Request(WIP)',
      ),
      MenuSeparator(),
      MenuItemLabel(label: 'Quit', onClicked: (_) => app.close()),
    ];
  }
}
