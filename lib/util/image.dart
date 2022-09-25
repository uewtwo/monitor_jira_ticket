import 'dart:io';

import 'package:flutter/material.dart';

import '../data/state/deploy_status.dart';

String getImagePath(String imageName) {
  return 'assets/images/common/$imageName.png';
}

String getDeployStatusIconPath(String imageName) {
  return Platform.isWindows
      ? 'assets/images/deploy/$imageName.ico'
      : 'assets/images/deploy/$imageName.png';
}

String getTrayIconPathFromStatus(String status) {
  if (status == DeployStatus.statusOpen) {
    return getDeployStatusIconPath('circle');
  } else if (status == DeployStatus.statusBlock) {
    return getDeployStatusIconPath('batten');
  } else if (status == DeployStatus.statusError) {
    return getDeployStatusIconPath('error');
  } else {
    return getDeployStatusIconPath('loading');
  }
}

String getLoginStatusImagePath(String imageName) {
  // debugPrint('getLoginStatusImagePath $imageName');
  return 'assets/images/login/$imageName.png';
}
