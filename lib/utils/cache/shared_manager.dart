// At the beginning I decided to use Shared Preferences because there was no free api for wallet as muach as I know, but then I changed my mind.

// If you want to integrate it, you can integrate it here easily :)
class GlobalStateManager {
  static final GlobalStateManager _instance = GlobalStateManager._internal();

  bool _check = false;

  GlobalStateManager._internal();

  static GlobalStateManager get instance => _instance;

  bool get check => _check;

  setCheck(bool value, {int delayInSeconds = 60}) {
  _check = value;
  print("Set _check to $value");
  if (value == true) {
    Future.delayed(Duration(seconds: delayInSeconds), () {
      _check = false;
      print("Reset _check to false after delay");
    });
  }
}
}