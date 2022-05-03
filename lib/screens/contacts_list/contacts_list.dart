import 'package:contacts_book/constants/colors.dart';
import 'package:contacts_book/screens/contacts_list/search_screen.dart';
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
      floatingActionButton: FloatingActionButton(onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => SearchScreen(contactsList: widget.contacts,)));
      },
      child: const Icon(Icons.search),),
      body: (widget._retrieved)
          ? Center(
              child: TextButton(
                onPressed: () async {
                  widget.contacts =
                      await RetrieveContacts.getContactsFromDevice();
                  setState(() {
                    widget._retrieved = false;
                  });
                },
                child: const Text('Allow Access'),
              ),
            )
          : Container(
              color: AppColors.whiteBackgroundOverlay,
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: widget.contacts.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                        '${(widget.contacts[index].phones!.isNotEmpty) ? widget.contacts[index].phones!.first.value : 'N/A'}'),
                    subtitle: Text('${widget.contacts[index].displayName}'),
                  );
                },
              ),
            ),
    );
  }
}
