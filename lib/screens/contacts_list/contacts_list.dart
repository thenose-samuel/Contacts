import 'package:contacts_book/services/retrieve_contacts.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';

class ContactsList extends StatefulWidget {
  ContactsList({Key? key}) : super(key: key);
  bool _retrieved = true;
  List<Contact> contacts = [];
  @override
  State<ContactsList> createState() => _ContactsListState();
}

class _ContactsListState extends State<ContactsList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: (widget._retrieved)?
      TextButton(
        onPressed: () async {
          widget.contacts = await RetrieveContacts.getContactsFromDevice();
          print(widget.contacts[66].displayName);
          setState(() {
            widget._retrieved = false;
          });
        },
        child: const Text('Allow Access'),
      ): ListView.builder(
      scrollDirection: Axis.vertical,
      itemCount: widget.contacts.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text('${(widget.contacts[index].phones!.isNotEmpty)?widget.contacts[index].phones!.first.value:'N/A'}'),
          subtitle: Text('${widget.contacts[index].displayName}'),
        );
      },
      ),
    );
  }
}
