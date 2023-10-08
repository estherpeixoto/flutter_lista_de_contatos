import 'package:flutter/material.dart';
import 'package:lista_de_contatos/models/contact_model.dart';

class EditContact extends StatefulWidget {
  ContactModel contact = ContactModel.empty();

  EditContact(this.contact, {super.key});

  @override
  State<EditContact> createState() => _EditContactState();
}

class _EditContactState extends State<EditContact> {
  var idController = TextEditingController(text: '');
  var nameController = TextEditingController(text: '');
  var phoneController = TextEditingController(text: '');
  var avatarController = TextEditingController(text: '');

  @override
  void initState() {
    super.initState();

    idController.text = widget.contact.id.toString();
    nameController.text = widget.contact.name;
    phoneController.text = widget.contact.phone;
    avatarController.text = widget.contact.avatar;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Editar contato'),
        actions: [
          TextButton(
            onPressed: () async {
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
            TextField(
              controller: idController,
              decoration: const InputDecoration(label: Text('ID')),
              enabled: false,
            ),
            const SizedBox(height: 8),
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
