import 'package:flutter/material.dart';
import '../../models/client.dart';
import '../../services/client_service.dart';
import 'client_profile_screen.dart';
import 'client_form_screen.dart';

class ClientsScreen extends StatefulWidget {
  @override
  _ClientsScreenState createState() => _ClientsScreenState();
}

class _ClientsScreenState extends State<ClientsScreen> {
  final ClientService _clientService = ClientService();
  late List<Client> _clients;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _clients = _clientService.getAllClients();
  }

  void _showClientProfile(Client client) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ClientProfileScreen(
          client: client,
          clientService: _clientService,
        ),
      ),
    ).then((_) {
      setState(() {
        _clients = _clientService.getAllClients();
      });
    });
  }

  void _editClient(Client client) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ClientFormScreen(
          client: client,
          clientService: _clientService,
        ),
      ),
    ).then((_) {
      setState(() {
        _clients = _clientService.getAllClients();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Clients'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              itemCount: _clients.length,
              itemBuilder: (context, index) {
                final client = _clients[index];
                return Dismissible(
                  key: Key(client.id),
                  background: Container(
                    color: Colors.blueAccent,
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: const Icon(Icons.edit, color: Colors.white, size: 32),
                  ),
                  secondaryBackground: Container(
                    color: Colors.redAccent,
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: const Icon(Icons.delete, color: Colors.white, size: 32),
                  ),
                  confirmDismiss: (direction) async {
                    if (direction == DismissDirection.startToEnd) {
                      // No confirmation needed for edit action
                      _editClient(client);
                      return false;
                    }
                    if (direction == DismissDirection.endToStart) {
                      return await showDialog<bool>(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Confirmation', style: TextStyle(color: Colors.redAccent)),
                            content: const Text('Êtes-vous sûr de vouloir supprimer ce client ?'),
                            actions: [
                              TextButton(
                                child: const Text('Annuler', style: TextStyle(color: Colors.grey)),
                                onPressed: () => Navigator.of(context).pop(false),
                              ),
                              TextButton(
                                child: const Text('Supprimer', style: TextStyle(color: Colors.redAccent)),
                                onPressed: () => Navigator.of(context).pop(true),
                              ),
                            ],
                          );
                        },
                      );
                    }
                    return false;
                  },
                  onDismissed: (direction) {
                    if (direction == DismissDirection.startToEnd) {
                      _editClient(client);
                    } else if (direction == DismissDirection.endToStart) {
                      _clientService.deleteClient(client.id);
                      setState(() {
                        _clients = _clientService.getAllClients();
                      });
                    }
                  },
                  child: ListTile(
                    title: Text(client.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text(client.email),
                    onTap: () => _showClientProfile(client),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ClientFormScreen(
                client: Client(id: '', name: '', email: '', phone: ''),
                clientService: _clientService,
              ),
            ),
          ).then((_) {
            setState(() {
              _clients = _clientService.getAllClients();
            });
          });
        },
        backgroundColor: Colors.green,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
