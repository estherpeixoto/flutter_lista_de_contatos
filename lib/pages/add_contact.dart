import 'package:flutter/material.dart';
import 'package:lista_de_contatos/models/contact_model.dart';
import 'package:lista_de_contatos/repositories/contacts_repository.dart';

class AddContact extends StatefulWidget {
  const AddContact({super.key});

  @override
  State<AddContact> createState() => _AddContactState();
}

class _AddContactState extends State<AddContact> {
  var contactsRepository = ContactsRepository();

  var idController = TextEditingController(text: '0');
  var nameController = TextEditingController(text: '');
  var phoneController = TextEditingController(text: '');
  var avatarController = TextEditingController(text: '');

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Adicionar contato'),
        actions: [
          TextButton(
            onPressed: () async {
              await contactsRepository.insert(
                ContactModel(
                  int.parse(idController.text),
                  nameController.text,
                  phoneController.text,
                  avatarController.text,
                ),
              );

              if (context.mounted) {
                Navigator.pop(context);
              }
            },
            child: const Text('Salvar'),
          )
        ],
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Column(
          children: <Widget>[
            // TextField(
            //   controller: idController,
            //   decoration: const InputDecoration(label: Text('ID')),
            //   enabled: false,
            // ),
            // const SizedBox(height: 8),
            TextField(
              controller: nameController,
              decoration: const InputDecoration(label: Text('Nome')),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: phoneController,
              decoration: const InputDecoration(label: Text('Telefone')),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: avatarController,
              decoration: const InputDecoration(label: Text('Avatar')),
            ),
          ],
        ),
      ),
    );
  }
}
