import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:eimi_buy_or_sell_app/utils/AppDataHelper.dart';
import 'package:eimi_buy_or_sell_app/utils/network/MyConectivity.dart';




ConnectivityResult? _source;
MyConnectivity _connectivity = MyConnectivity.instance;
bool internetConnection = false;
bool isInProgress = false;
bool isAllSynced = true;
Function(bool isOnline)? connectionCallback;

void registerCallBack(Function(bool isOnline) callback) {
  connectionCallback = callback;
}
Future<void> getInternetConnection() async {
  switch (_source) {
    case ConnectivityResult.none:
      internetConnection = false;
      isInProgress = false;
      break;
    case ConnectivityResult.mobile:
      internetConnection = true;
      //     await SyncHelper.getInstance().syncData();
      break;
    case ConnectivityResult.wifi:
      internetConnection = true;

      //   await SyncHelper.getInstance().syncData();
      break;
    case null:
      internetConnection = false;
      isInProgress = false;
    case ConnectivityResult.bluetooth:
      // TODO: Handle this case.
      throw UnimplementedError();
    case ConnectivityResult.ethernet:
      // TODO: Handle this case.
      throw UnimplementedError();
    case ConnectivityResult.vpn:
      // TODO: Handle this case.
      throw UnimplementedError();
    case ConnectivityResult.other:
      // TODO: Handle this case.
      throw UnimplementedError();
  }
  if(connectionCallback != null) {
    connectionCallback!(internetConnection);
  }
  if(internetConnection) {
    SyncHelper.getInstance().syncData();
  }
}

class SyncHelper {
  static SyncHelper? _instance;
  static Function? callBack;
  static SyncHelper getInstance() {
    _instance ??= SyncHelper();
    return _instance!;
  }
  static registerSync(Function val){
    callBack = val;
  }
  initConnectivity() {
    _connectivity.initialise((result) async {
      if(_source == null || (_source == ConnectivityResult.none && result != ConnectivityResult.none)
          || (_source != ConnectivityResult.none && result == ConnectivityResult.none)) {
        _source = result;
        await getInternetConnection();
      }
    });
  }

  Future<void> syncData() async {
    print("SyncData :  ${internetConnection}   ${isInProgress}");
    if(AppDataHelper.userId != null && AppDataHelper.userId!.isNotEmpty) {
      if (internetConnection && !isInProgress) {
        Map<String,dynamic> data = Map();
        data.putIfAbsent("DAta", () => "");

        //NOTIFICATION START
        isInProgress = true;
        try {

        } catch (e) {
          print(e.toString());
          throw Exception('Something went wrong');
        }
        isInProgress = false;
        // NOTIFICATION DISABLE

        if(callBack!=null){
          callBack!();
        }
      }
    }
  }

}