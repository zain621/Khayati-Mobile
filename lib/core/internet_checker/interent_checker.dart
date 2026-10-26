import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

abstract class NetworkInfo {
  Future<bool> get isConnected;
}

class NetworkInfoImp implements NetworkInfo {
  NetworkInfoImp(InternetConnectionCheckerPlus _);

  /// Always allow the request. Connectivity pings were a false "no internet"
  /// on every screen; Dio reports a real failure if the API is unreachable.
  @override
  Future<bool> get isConnected async => true;
}
