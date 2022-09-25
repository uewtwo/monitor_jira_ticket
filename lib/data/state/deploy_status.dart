class DeployStatus {
  static const String statusOpen = 'open';
  static const String statusBlock = 'block';
  static const String statusLoading = 'loading';
  static const String statusError = 'error';
  final bool _isLoading = true;
  late String _currentStatus;

  DeployStatus({String? status}) {
    _currentStatus = status ?? statusLoading;
  }

  void changeDeployStatus({String? status}) {
    if (status != null) {
      _currentStatus = status;
    } else if (_currentStatus == statusOpen) {
      _currentStatus = statusBlock;
    } else {
      _currentStatus = statusOpen;
    }
  }

  void setStatusOpen() {
    if (_currentStatus == statusBlock) {
      changeDeployStatus();
    }
  }

  void setStatusBlock() {
    if (_currentStatus == statusOpen) {
      changeDeployStatus();
    }
  }

  String getStatus() {
    return _currentStatus;
  }

  bool isOpen() {
    return _currentStatus == statusOpen;
  }

  bool isBlock() {
    return _currentStatus == statusBlock;
  }

  bool isLoading() {
    return _isLoading;
  }
}
