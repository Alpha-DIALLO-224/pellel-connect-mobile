// lib/models/client.dart

class Client {
  final String id;
  final String name;
  final String email;
  final String phone;

  Client({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
  });

  // Méthode pour créer un client à partir d'un Map
  factory Client.fromMap(Map<String, dynamic> map) {
    return Client(
      id: map['id'],
      name: map['name'],
      email: map['email'],
      phone: map['phone'],
    );
  }

  // Méthode pour convertir un client en Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
    };
  }
}
