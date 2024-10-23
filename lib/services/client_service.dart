// lib/services/client_service.dart

import 'package:collection/collection.dart'; // Assurez-vous d'importer correctement
import 'package:faker/faker.dart';
import '../models/client.dart';

class ClientService {
  final List<Client> _clients = [];
  final Faker _faker = Faker();

  ClientService() {
    // Générer quelques clients fictifs au démarrage
    for (int i = 0; i < 10; i++) {
      _clients.add(Client(
        id: _faker.guid.guid(),
        name: _faker.person.name(),
        email: _faker.internet.email(),
        phone: _faker.phoneNumber.us(),
      ));
    }
  }

  List<Client> getAllClients() {
    return List.from(_clients);
  }

  Client? getClientById(String id) {
    return _clients.firstWhereOrNull(
          (client) => client.id == id,
    );
  }

  void addClient(Client client) {
    _clients.add(client);
  }

  void updateClient(String id, Client updatedClient) {
    final index = _clients.indexWhere((client) => client.id == id);
    if (index != -1) {
      _clients[index] = updatedClient;
    }
  }

  void deleteClient(String id) {
    _clients.removeWhere((client) => client.id == id);
  }
}


/*
import 'dart:math';
import 'package:faker/faker.dart';
import '../models/client.dart';

class ClientService {
  final List<Client> _clients = [];
  final Faker _faker = Faker();

  ClientService() {
    // Générer quelques clients fictifs au démarrage
    for (int i = 0; i < 10; i++) {
      _clients.add(Client(
        id: _faker.guid.guid(),
        name: _faker.person.name(),
        email: _faker.internet.email(),
        phone: _faker.phoneNumber.us(),
      ));
    }
  }

  List<Client> getAllClients() {
    return List.from(_clients);
  }

  Client? getClientById(String id) {
    return _clients.firstWhereOrNull((client) => client.id == id);
  }

  void addClient(Client client) {
    _clients.add(client);
  }

  void updateClient(String id, Client updatedClient) {
    final index = _clients.indexWhere((client) => client.id == id);
    if (index != -1) {
      _clients[index] = updatedClient;
    }
  }

  void deleteClient(String id) {
    _clients.removeWhere((client) => client.id == id);
  }
}

 */

/*
import 'package:http/http.dart' as http;
import 'dart:convert';

class ClientService {
  final String _baseUrl = 'http://your-spring-boot-api-url/clients';

  Future<List<Client>> getAllClients() async {
    final response = await http.get(Uri.parse(_baseUrl));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => Client.fromMap(json)).toList();
    } else {
      throw Exception('Failed to load clients');
    }
  }

  // Ajoutez ici d'autres méthodes pour POST, PUT, DELETE en utilisant http.
}

 */
