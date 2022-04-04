import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class RetrieveContacts extends StatefulWidget {
  const RetrieveContacts({Key? key}) : super(key: key);

  @override
  State<RetrieveContacts> createState() => _RetrieveContactsState();
}

class _RetrieveContactsState extends State<RetrieveContacts> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: (){},
      ),
      body: Center(
        child: TextButton(
          onPressed: ()async {
            final PermissionStatus permissionStatus = await _getPermission();
            if (permissionStatus == PermissionStatus.granted) {
              //print('Yay!'); //We can now access our contacts here
              List<Contact> contacts = await ContactsService.getContacts(withThumbnails: false);
              print(contacts[66].displayName);
            } else {
              _getPermission();
              //print('Nay');
            }
          },
          child: const Text('Allow Access'),
        ),
      ),
    );
  }
  Future<PermissionStatus> _getPermission() async {
    //print('Getting permission...');
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

