import 'package:connectivity/connectivity.dart';
import 'package:flutter/foundation.dart';

class ConnectionProvider extends ChangeNotifier {
  String _sConnection="";
  Map source;

  ConnectionProvider({required this.source}){
    complete(source);
  }

  String get sConnection => _sConnection;

  Map get source2 => source;

  void complete(Map _source) {
    source=_source;
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
    print("source2 $source = $_source = $_sConnection");
    notifyListeners();
  }
}