import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:e_voting/Screens/Widgets/alert.dart';

class Internet {
  Future<bool> checkInternetConnection() async {
    var connectivity = Connectivity();
    var connectivityResult = await connectivity.checkConnectivity();

    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      // Your code when internet is connected
      return true;
    }
    MyAlert.showToast(0, 'No internet connection!');
    return false;
  }
}
