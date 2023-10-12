import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gal/gal.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lista_de_contatos/models/contact_model.dart';
import 'package:lista_de_contatos/repositories/contacts_repository.dart';
import 'package:lista_de_contatos/services/avatar_service.dart';

class AddContact extends StatefulWidget {
  const AddContact({super.key});

  @override
  State<AddContact> createState() => _AddContactState();
}

class _AddContactState extends State<AddContact> {
  var contactsRepository = ContactsRepository();

  var nameController = TextEditingController(text: '');
  var phoneController = TextEditingController(text: '');
  XFile? photo;

  @override
  void initState() {
    super.initState();
  }

  handleCropImage(XFile imageFile) async {
    try {
      AvatarService avatarService = AvatarService();
      String path = await avatarService.cropImage(imageFile);

      if (path != '') {
        photo = XFile(path);
        setState(() {});
      }
    } on GalException catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.type.message),
          ),
        );
      }
    }
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
                  0,
                  nameController.text,
                  phoneController.text,
                  photo?.path ?? '',
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
            const SizedBox(height: 8),
            IconButton(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return Wrap(
                      children: [
                        ListTile(
                          leading: const Icon(Icons.camera_alt),
                          title: const Text('Câmera'),
                          onTap: () {},
                        ),
                        ListTile(
                          leading: const Icon(Icons.image),
                          title: const Text('Galeria'),
                          onTap: () async {
                            final ImagePicker _picker = ImagePicker();

                            photo = await _picker.pickImage(
                              source: ImageSource.gallery,
                            );

                            if (context.mounted) {
                              Navigator.pop(context);
                            }

                            handleCropImage(photo!);
                          },
                        ),
                        ListTile(
                          leading: const Icon(Icons.delete_forever),
                          title: const Text('Remover foto'),
                          onTap: () {
                            photo = null;

                            setState(() {});

                            if (context.mounted) {
                              Navigator.pop(context);
                            }
                          },
                          enabled: photo != null,
                        ),
                      ],
                    );
                  },
                );
              },
              icon: CircleAvatar(
                backgroundColor: Colors.blue.shade50,
                radius: 32,
                backgroundImage:
                    photo != null ? FileImage(File(photo!.path)) : null,
                child: photo == null ? const Icon(Icons.upload) : null,
              ),
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
          ],
        ),
      ),
    );
  }
}
