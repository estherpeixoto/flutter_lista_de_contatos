import 'package:lista_de_contatos/models/contact_model.dart';

class ContactsModel {
  List<ContactModel> contacts = [];

  ContactsModel(contacts);

  void add(ContactModel contactModel) {
    contacts.add(contactModel);
  }
}
