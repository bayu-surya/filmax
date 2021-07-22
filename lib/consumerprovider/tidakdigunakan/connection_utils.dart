import 'package:connectivity/connectivity.dart';

class ConnectionUtils {

  String check(Map _source){
    String _sConnection="";
    switch (_source.keys.toList()[0]) {
      case ConnectivityResult.none:
        _sConnection = "Offline";
        break;
      case ConnectivityResult.mobile:
        _sConnection = "Mobile: Online";
        break;
      case ConnectivityResult.wifi:
        _sConnection = "WiFi: Online";
    }
    return _sConnection;
  }
}