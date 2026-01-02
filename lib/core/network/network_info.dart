import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

/// Abstract class for checking network connectivity.
abstract class NetworkInfo {
  Future<bool> get isConnected;
}

/// Implementation of [NetworkInfo] using InternetConnectionCheckerPlus.
class NetworkInfoImpl implements NetworkInfo {
  NetworkInfoImpl(this._connectionChecker);

  final InternetConnection _connectionChecker;

  @override
  Future<bool> get isConnected => _connectionChecker.hasInternetAccess;
}
