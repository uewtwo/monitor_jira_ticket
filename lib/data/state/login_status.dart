import 'package:hooks_riverpod/hooks_riverpod.dart';

class LoginStatus extends StateNotifier<String> {
  LoginStatus() : super('loading');

  void setState(String status) => state = status;

  String getState() => state;
}
