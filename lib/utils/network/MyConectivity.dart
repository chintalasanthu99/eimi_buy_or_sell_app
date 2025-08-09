
import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';

class MyConnectivity {
  MyConnectivity._internal();
  static final MyConnectivity _singleton = MyConnectivity._internal();
  factory MyConnectivity() {
    return _singleton;
  }

  static MyConnectivity get instance => _singleton;

  Connectivity connectivity = Connectivity();

  StreamController controller = StreamController.broadcast();
  Stream get myStream => controller.stream;

  Function(ConnectivityResult result)? connectionCallback;

  void initialise(Function(ConnectivityResult result) callback) async {
    connectionCallback = callback;
    ConnectivityResult result = await connectivity.checkConnectivity();
    _checkStatus(result);
    connectivity.onConnectivityChanged.listen((result) {
      _checkStatus(result);
    });
  }

  void getStatus() async {
    ConnectivityResult result = await connectivity.checkConnectivity();
    _checkStatus(result);
  }

  void registerNetworkCallBack(Function(ConnectivityResult result) callback) {
    connectionCallback = callback;
  }

  void _checkStatus(ConnectivityResult result) async {
    bool isOnline = false;
    try {
      final result = await InternetAddress.lookup('orra.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        isOnline = true;
      } else
        isOnline = false;
    } on SocketException catch (_) {
      isOnline = false;
    }
    if(connectionCallback != null) {
      connectionCallback!(result);
    }
    controller.sink.add({result: isOnline});
  }

  void disposeStream() => controller.close();
}