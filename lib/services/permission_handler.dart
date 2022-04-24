import 'package:permission_handler/permission_handler.dart';

class PermissionHandler{
  static Future<PermissionStatus> getPermission() async {
    final PermissionStatus permission = await Permission.contacts.request();
    if (permission != PermissionStatus.granted &&
        permission != PermissionStatus.denied) {
      final Map<Permission, PermissionStatus> permissionStatus =
      await [Permission.contacts].request();
      return permissionStatus[Permission.contacts] ??
          PermissionStatus.limited;
    } else {
      return permission;
    }
  }
}