import 'package:flutter/services.dart';

class SecurityCheck {
  static const platform = MethodChannel('security_check');

  static Future<bool> isRooted() async {
    try {
      return await platform.invokeMethod<bool>('isRooted') ?? false;
    } on PlatformException {
      return false;
    }
  }
}
