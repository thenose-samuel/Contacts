import 'package:contacts_service/contacts_service.dart';

class SearchContacts{

  static Future<List<Contact>> searchContact(String query, List<Contact> contactsList){
    List<Contact> results = [];
    contactsList.forEach((contact) {
      if(contact.displayName!.toLowerCase().startsWith(query.toLowerCase()) && !results.contains(contact)){
        results.add(contact);
      }
      if(contact.phones!.isNotEmpty && contact.phones!.first.value!.startsWith(query) && !results.contains(contact)){
        results.add(contact);
      }
    });
    return Future.value(results);
  }
}