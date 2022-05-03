import 'package:contacts_book/services/search_contacts.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  List<Contact> contactsList;
  SearchScreen({Key? key, required this.contactsList}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();

  
}

class _SearchScreenState extends State<SearchScreen> {
  
  List<Contact> originalContacts = [];
  @override
  void initState(){
    super.initState();
    originalContacts  = widget.contactsList; 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(
            height: 50,
          ),
          TextField(
            onChanged: (query) async {
              List<Contact> results = await SearchContacts.searchContact(
                  query, originalContacts);
              setState(() {
                widget.contactsList = results;
              });
            },
          ),
          SingleChildScrollView(
            child: Container(
              width: 300,
              height: 300,
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: widget.contactsList.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                        '${(widget.contactsList[index].phones!.isNotEmpty) ? widget.contactsList[index].phones!.first.value : 'N/A'}'),
                    subtitle: Text('${widget.contactsList[index].displayName}'),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
