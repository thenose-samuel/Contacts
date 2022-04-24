import 'dart:developer';
import 'package:contacts_book/services/permission_handler.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:permission_handler/permission_handler.dart';

class RetrieveContacts{
  static Future<List<Contact>> getContactsFromDevice() async{
    final PermissionStatus permissionStatus = await PermissionHandler.getPermission();
    if (permissionStatus == PermissionStatus.granted) {
      log('Contacts can be accessed',name: 'RetrieveContacts class');
      List<Contact> contacts = await ContactsService.getContacts(withThumbnails: false);
      return contacts;
    } else {
      log('Getting contacts access permission',name: 'RetrieveContacts class');
      await PermissionHandler.getPermission();
    }
    return [];
  }
}