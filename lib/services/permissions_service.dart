import 'package:permission_handler/permission_handler.dart';

class PermissionService {
  static Future<void> checkPermissions() async {
    await _checkMicrophonePermission();
    await checkStoragePermission();
  }

  static Future<void> _checkMicrophonePermission() async {
    if (!await Permission.microphone.isGranted) {
      await Permission.microphone.request();
    }
  }

  static Future<void> checkStoragePermission() async {
    if (!await Permission.manageExternalStorage.isGranted) {
      await Permission.manageExternalStorage.request();
    }

    if (!await Permission.storage.isGranted) {
      await Permission.storage.request();
    }
  }
}
