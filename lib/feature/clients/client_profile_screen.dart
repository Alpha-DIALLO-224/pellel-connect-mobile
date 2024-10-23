import 'package:flutter/material.dart';
import '../../models/client.dart';
import '../../services/client_service.dart';
import 'client_form_screen.dart';

class ClientProfileScreen extends StatelessWidget {
  final Client client;
  final ClientService clientService;

  ClientProfileScreen({required this.client, required this.clientService});

  void _navigateToEditScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ClientFormScreen(
          client: client,
          clientService: clientService,
        ),
      ),
    ).then((_) {
      // Refresh the profile screen after returning from the edit screen
      Navigator.pop(context);
    });
  }

  void _deleteClient(BuildContext context) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirmation', style: TextStyle(color: Colors.blueAccent)),
          content: Text('Êtes-vous sûr de vouloir supprimer ce client ?'),
          actions: [
            TextButton(
              child: Text('Annuler', style: TextStyle(color: Colors.grey)),
              onPressed: () => Navigator.of(context).pop(false),
            ),
            TextButton(
              child: Text('Supprimer', style: TextStyle(color: Colors.red)),
              onPressed: () => Navigator.of(context).pop(true),
            ),
          ],
        );
      },
    );
    if (result == true) {
      clientService.deleteClient(client.id);
      Navigator.pop(context); // Go back to the previous screen
    }
  }

  @override
  Widget build(BuildContext context) {
    final isWideScreen = MediaQuery.of(context).size.width > 600;

    return Scaffold(
      appBar: AppBar(
        title: Text('Profil du Client', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blueAccent,
        elevation: 0,
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(isWideScreen ? 32.0 : 16.0),
          child: Card(
            elevation: 4.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    client.name,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueAccent,
                    ),
                  ),
                  SizedBox(height: 16),
                  _buildProfileDetail('Email', client.email),
                  SizedBox(height: 16),
                  _buildProfileDetail('Téléphone', client.phone),
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 16.0, right: 16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            FloatingActionButton(
              onPressed: () => _navigateToEditScreen(context),
              backgroundColor: Colors.blueAccent,
              child: const Icon(Icons.edit, color: Colors.white),
            ),
            const SizedBox(height: 16),
            FloatingActionButton(
              onPressed: () => _deleteClient(context),
              backgroundColor: Colors.redAccent,
              child: const Icon(Icons.delete, color: Colors.white),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildProfileDetail(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$label: ',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey[700],
            ),
            softWrap: true,
          ),
        ),
      ],
    );
  }
}
