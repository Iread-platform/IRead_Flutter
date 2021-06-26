import 'package:permission_handler/permission_handler.dart';

class PermissionService {
  static Future<void> checkPermissions() async {
    await _checkMicrophonePermission();
    await _checkStoragePermission();
  }

  static Future<void> _checkMicrophonePermission() async {
    if (!await Permission.microphone.isGranted) {
      Permission.microphone.request();
    }
  }

  static Future<void> _checkStoragePermission() async {
    if (!await Permission.manageExternalStorage.isGranted) {
      Permission.manageExternalStorage.request();
    }
  }
}
