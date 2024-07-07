import 'package:connectivity_plus/connectivity_plus.dart';

import '../../utils/enums/enums.dart';

abstract class IAppInternetConnection {
  Future<AppConnectivityResult> checkAppConnectivity();
}

class AppInternetConnection implements IAppInternetConnection {
  @override
  Future<AppConnectivityResult> checkAppConnectivity() async {
    Connectivity connectivity = Connectivity();
    ConnectivityResult connecivity = await connectivity.checkConnectivity();

    var connectingType =
        AppConnectivityResult.values.firstWhere((element) => element.name.toString() == connecivity.name.toString());

    return connectingType;
  }
}
