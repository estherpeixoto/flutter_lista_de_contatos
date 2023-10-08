import 'package:flutter/material.dart';
import 'package:lista_de_contatos/models/contacts_model.dart';
import 'package:lista_de_contatos/pages/add_contact.dart';
import 'package:lista_de_contatos/pages/edit_contact.dart';
import 'package:lista_de_contatos/repositories/contacts_repository.dart';

/*
 * @todo Listar contatos
 * @todo Cadastrar contato
 * @todo Editar contato
 * @todo Excluir contato
 * @todo Usar câmera/galeria, cortar a imagem e salvar o caminho dela no banco
 */
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _loading = false;
  var contactList = ContactsModel([]);
  var contactsRepository = ContactsRepository();

  @override
  void initState() {
    super.initState();
    fetchContacts();
  }

  void fetchContacts() async {
    setState(() => _loading = true);
    contactList = await contactsRepository.findAll();
    setState(() => _loading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Lista de contatos'),
      ),
      body: Container(
        margin: const EdgeInsets.all(16),
        child: Column(
          children: [
            _loading
                ? const Expanded(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
                : Expanded(
                    child: ListView.builder(
                      itemCount: contactList.contacts.length,
                      itemBuilder: (BuildContext bc, int index) {
                        var contact = contactList.contacts[index];

                        return Dismissible(
                          onDismissed:
                              (DismissDirection dismissDirection) async {
                            await contactsRepository.delete(contact.id);
                          },
                          direction: DismissDirection.startToEnd,
                          background: Container(
                            padding: const EdgeInsets.only(left: 20.0),
                            color: Colors.red,
                            child: const Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Excluir',
                                textAlign: TextAlign.left,
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                          key: Key(contact.id.toString()),
                          child: ListTile(
                            title: Text(contact.name),
                            subtitle: Text(contact.phone),
                            trailing: IconButton(
                              onPressed: () async {
                                await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => EditContact(contact),
                                  ),
                                );

                                fetchContacts();
                              },
                              icon: const Icon(Icons.edit),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddContact()),
          );

          fetchContacts();
        },
        tooltip: 'Adicionar contato',
        child: const Icon(Icons.add),
      ),
    );
  }
}
