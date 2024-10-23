import 'package:flutter/material.dart';
import '../../models/client.dart';
import '../../services/client_service.dart';

class ClientFormScreen extends StatefulWidget {
  final Client client;
  final ClientService clientService;

  ClientFormScreen({required this.client, required this.clientService});

  @override
  _ClientFormScreenState createState() => _ClientFormScreenState();
}

class _ClientFormScreenState extends State<ClientFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.client.name);
    _emailController = TextEditingController(text: widget.client.email);
    _phoneController = TextEditingController(text: widget.client.phone);
  }

  void _saveClient() {
    if (_formKey.currentState!.validate()) {
      final updatedClient = Client(
        id: widget.client.id.isEmpty ? UniqueKey().toString() : widget.client.id,
        name: _nameController.text,
        email: _emailController.text,
        phone: _phoneController.text,
      );

      if (widget.client.id.isEmpty) {
        widget.clientService.addClient(updatedClient);
      } else {
        widget.clientService.updateClient(widget.client.id, updatedClient);
      }
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.client.id.isEmpty ? 'Ajouter Client' : 'Modifier Client'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildTextField(
                _nameController,
                'Nom',
                'Entrez le nom',
                icon: Icons.person,
              ),
              SizedBox(height: 26),
              _buildTextField(
                _emailController,
                'Email',
                'Entrez l\'email',
                icon: Icons.email,
                isEmail: true,
              ),
              SizedBox(height: 26),
              _buildTextField(
                _phoneController,
                'Téléphone',
                'Entrez le numéro de téléphone',
                icon: Icons.phone,
                isPhoneNumber: true,
              ),
              SizedBox(height: 32),
              ElevatedButton(
                onPressed: _saveClient,
                child: Text('Sauvegarder', style: TextStyle(fontSize: 16)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  padding: EdgeInsets.symmetric(horizontal: 32, vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label, String hint, {IconData? icon, bool isEmail = false, bool isPhoneNumber = false}) {
    return TextFormField(
      controller: controller,
      keyboardType: isPhoneNumber ? TextInputType.phone : (isEmail ? TextInputType.emailAddress : TextInputType.text),
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: icon != null ? Icon(icon) : null,
        filled: true,
        fillColor: Colors.grey[200],
        contentPadding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide.none,
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Veuillez entrer $label';
        }
        if (isEmail && !RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
          return 'Veuillez entrer un email valide';
        }
        return null;
      },
    );
  }
}
