import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../state/login_status.dart';

final loginStatusProvider =
    StateNotifierProvider<LoginStatus, String>((_) => LoginStatus());
