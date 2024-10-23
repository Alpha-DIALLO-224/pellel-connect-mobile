import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class CreateCommandes extends StatefulWidget {
  @override
  _CreateCommandesState createState() => _CreateCommandesState();
}

class _CreateCommandesState extends State<CreateCommandes> {
  final TextEditingController productNameController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  final TextEditingController priceController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  List<Map<String, dynamic>> orders = [];
  bool isFormVisible = false;
  Map<String, dynamic>? editingOrder;
  int? editingIndex;

  void addOrder() {
    if (_formKey.currentState?.validate() ?? false) {
      final productName = productNameController.text;
      final quantity = int.parse(quantityController.text);
      final price = double.parse(priceController.text);

      setState(() {
        orders.add({
          'productName': productName,
          'quantity': quantity,
          'price': price,
        });

        productNameController.clear();
        quantityController.clear();
        priceController.clear();
        isFormVisible = false;
      });
    }
  }

  void editOrder() {
    if (_formKey.currentState?.validate() ?? false) {
      final productName = productNameController.text;
      final quantity = int.parse(quantityController.text);
      final price = double.parse(priceController.text);

      setState(() {
        orders[editingIndex!] = {
          'productName': productName,
          'quantity': quantity,
          'price': price,
        };

        productNameController.clear();
        quantityController.clear();
        priceController.clear();
        isFormVisible = false;
        editingOrder = null;
        editingIndex = null;
      });
    }
  }

  double get totalAmount {
    return orders.fold(0, (sum, order) => sum + (order['quantity'] * order['price']));
  }

  String formatCurrency(double amount) {
    return '${amount.toStringAsFixed(2)} GNF';
  }

  Future<void> _showDeleteConfirmation(int index) async {
    final bool? confirmed = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Confirmer la suppression'),
        content: Text('Êtes-vous sûr de vouloir supprimer cet article ?'),
        actions: <Widget>[
          TextButton(
            child: Text('Annuler'),
            onPressed: () => Navigator.of(context).pop(false),
          ),
          TextButton(
            child: Text('Supprimer'),
            onPressed: () => Navigator.of(context).pop(true),
          ),
        ],
      ),
    );
    if (confirmed ?? false) {
      setState(() {
        orders.removeAt(index);
      });
    }
  }

  void _prepareEdit(int index) {
    final order = orders[index];
    setState(() {
      productNameController.text = order['productName'];
      quantityController.text = order['quantity'].toString();
      priceController.text = order['price'].toString();
      editingOrder = order;
      editingIndex = index;
      isFormVisible = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Créer une Commande'),
        backgroundColor: Colors.teal,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
            child: Text(
              'Montant Total: ${formatCurrency(totalAmount)}',
              style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold, color: Colors.teal),
            ),
          ),
          if (isFormVisible) ...[
            _buildForm(),
          ] else ...[
            Expanded(
              child: _buildList(),
            ),
          ],
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            isFormVisible = !isFormVisible;
            if (!isFormVisible) {
              // Clear form fields when the form is hidden
              productNameController.clear();
              quantityController.clear();
              priceController.clear();
              editingOrder = null;
              editingIndex = null;
            }
          });
        },
        child: Icon(
          isFormVisible ? Icons.close : Icons.add,
          color: Colors.white,
        ),
        backgroundColor: isFormVisible ? Colors.redAccent : Colors.teal,
        tooltip: 'Ajouter une Commande',
      ),
    );
  }

  Widget _buildForm() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                editingOrder != null ? 'Éditer un produit' : 'Ajouter un produit',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10.0),
              _buildTextFormField(
                controller: productNameController,
                label: 'Nom du Produit',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer le nom du produit';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10.0),
              _buildTextFormField(
                controller: quantityController,
                label: 'Quantité',
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer la quantité';
                  }
                  final quantity = int.tryParse(value);
                  if (quantity == null || quantity <= 0) {
                    return 'La quantité doit être un nombre entier positif';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10.0),
              _buildTextFormField(
                controller: priceController,
                label: 'Prix',
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}'))],
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer le prix';
                  }
                  final price = double.tryParse(value);
                  if (price == null || price <= 0) {
                    return 'Le prix doit être un nombre positif';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10.0),
              Align(
                alignment: Alignment.centerLeft,
                child: ElevatedButton(
                  onPressed: editingOrder != null ? editOrder : addOrder,
                  child: Text(editingOrder != null ? 'Éditer' : 'Ajouter'),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.teal,
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    elevation: 8,
                  ),
                ),
              ),
              SizedBox(height: 10.0),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextFormField({
    required TextEditingController controller,
    required String label,
    TextInputType? keyboardType,
    List<TextInputFormatter>? inputFormatters,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        filled: true,
        fillColor: Colors.grey[200],
      ),
      style: TextStyle(fontSize: 14.0),
      validator: validator,
    );
  }

  Widget _buildList() {
    return ListView.builder(
      itemCount: orders.length,
      itemBuilder: (context, index) {
        final order = orders[index];
        return Slidable(
          key: ValueKey(order['productName']),
          startActionPane: ActionPane(
            motion: DrawerMotion(),
            children: [
              SlidableAction(
                onPressed: (_) => _showDeleteConfirmation(index),
                backgroundColor: Colors.redAccent,
                icon: Icons.delete,
                label: 'Supprimer',
              ),
            ],
          ),
          endActionPane: ActionPane(
            motion: DrawerMotion(),
            children: [
              SlidableAction(
                onPressed: (_) => _prepareEdit(index),
                backgroundColor: Colors.blueAccent,
                icon: Icons.edit,
                label: 'Éditer',
              ),
            ],
          ),
          child: Card(
            margin: EdgeInsets.symmetric(vertical: 5),
            elevation: 4,
            child: ListTile(
              contentPadding: EdgeInsets.all(16.0),
              title: Text(order['productName']),
              subtitle: Text('${order['quantity']} x ${order['price'].toStringAsFixed(2)} GNF'),
              trailing: Text('${(order['quantity'] * order['price']).toStringAsFixed(2)} GNF'),
            ),
          ),
        );
      },
    );
  }
}
