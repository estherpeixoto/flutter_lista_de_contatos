import 'package:lista_de_contatos/models/contact_model.dart';
import 'package:lista_de_contatos/models/contacts_model.dart';
import 'package:lista_de_contatos/repositories/sqlite_database.dart';

class ContactsRepository {
  Future<ContactsModel> findAll() async {
    ContactsModel contactsModel = ContactsModel([]);

    var db = await SQLiteDatabase().getDatabase();
    var result = await db.rawQuery(
      'SELECT id, name, phone, avatar FROM contacts',
    );

    for (var element in result) {
      contactsModel.add(ContactModel(
        int.parse(element['id'].toString()),
        element['phone'].toString(),
        element['name'].toString(),
        element['avatar'].toString(),
      ));
    }

    return contactsModel;
  }

  Future<void> insert(ContactModel contactModel) async {
    var db = await SQLiteDatabase().getDatabase();
    await db.rawInsert(
      'INSERT INTO contacts (name, phone, avatar) VALUES (?, ?, ?)',
      [contactModel.name, contactModel.phone, contactModel.avatar],
    );
  }

  Future<void> update(ContactModel contactModel) async {
    var db = await SQLiteDatabase().getDatabase();
    await db.rawInsert(
      'UPDATE contacts SET name = ?, phone = ?, avatar = ? WHERE id = ?',
      [
        contactModel.name,
        contactModel.phone,
        contactModel.avatar,
        contactModel.id,
      ],
    );
  }

  Future<void> remover(int id) async {
    var db = await SQLiteDatabase().getDatabase();
    await db.rawInsert('DELETE FROM contacts WHERE id = ?', [id]);
  }
}
