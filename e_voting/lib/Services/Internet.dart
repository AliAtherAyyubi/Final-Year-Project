import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:e_voting/Screens/Widgets/alert.dart';

class Internet {
  Future<void> checkInternetConnection() async {
    var connectivity = Connectivity();
    var connectivityResult = await connectivity.checkConnectivity();

    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      print('Connected to internet');
      // Your code when internet is connected
    } else {
      print('No internet connection');
      MyAlert.showToast(0, 'No internet connection!');
    }
  }
}
