import 'package:flutter/material.dart';
import 'package:pellel_connect/feature/clients/clients_screen.dart';
import 'package:pellel_connect/feature/commandes/commandes_home.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  static const TextStyle headerStyle = TextStyle(
    fontSize: 26,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  static const TextStyle subHeaderStyle = TextStyle(
    fontSize: 18,
    color: Colors.white70,
  );

  static const TextStyle sectionTitleStyle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: Colors.black87,
  );

  static const List<String> catNames = [
    "Clients",
    "Marchandise",
    "Fournisseur",
    "Commandes",
    "Magasins",
    "Comptabilité",
  ];

  static const List<Color> catColors = [
    Color(0xFFFFCF2F), // Jaune
    Color(0xFF0158FD), // Bleu
    Color(0xFFFD5E53), // Rouge
    Color(0xFF28A745), // Vert
    Color(0xFFFFA500), // Orange
    Color(0xFF800080), // Violet
  ];

  static const List<Icon> catIcons = [
    Icon(Icons.person, color: Colors.white, size: 30), // Clients
    Icon(Icons.add_shopping_cart_sharp, color: Colors.white, size: 30), // Entrer marchandise
    Icon(Icons.business, color: Colors.white, size: 30), // Fournisseur
    Icon(Icons.work, color: Colors.white, size: 30), // Préparation des commandes
    Icon(Icons.store, color: Colors.white, size: 30), // Magasins
    Icon(Icons.account_balance, color: Colors.white, size: 30), // Comptabilité
  ];

  void _onMenuTap(BuildContext context, String categoryName) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CategoryDetailScreen(categoryName: categoryName),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // Ajouter un titre et un sous-titre avec un style moderne
          Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blueAccent, Colors.purpleAccent],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 5,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Bienvenue sur l\'Application de Gestion',
                  style: headerStyle,
                ),
                const SizedBox(height: 8),
                Text(
                  'Gérez vos clients, marchandises, fournisseurs, et bien plus encore en toute simplicité.',
                  style: subHeaderStyle,
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Titre pour les cartes de synthèse de stock
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              'Aperçu des Stocks',
              style: sectionTitleStyle,
            ),
          ),
          const SizedBox(height: 10),

          // Cartes de synthèse de stock avec style moderne
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              StockOverviewCard(
                title: 'Total Items',
                count: '1,234',
                color: Colors.blueAccent,
              ),
              StockOverviewCard(
                title: 'Low Stock Alerts',
                count: '12',
                color: Colors.redAccent,
              ),
              StockOverviewCard(
                title: 'New Arrivals',
                count: '56',
                color: Colors.greenAccent,
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Titre pour la grille de catégories
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              'Catégories',
              style: sectionTitleStyle,
            ),
          ),
          const SizedBox(height: 10),

          // Grille de catégories
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: GridView.builder(
              itemCount: catNames.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 1.1,
              ),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () => _onMenuTap(context, catNames[index]),
                  child: Column(
                    children: [
                      Container(
                        height: 70,
                        width: 70,
                        decoration: BoxDecoration(
                          color: catColors[index],
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 5,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Center(
                          child: catIcons[index],
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        catNames[index],
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.black.withOpacity(0.7),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class StockOverviewCard extends StatelessWidget {
  final String title;
  final String count;
  final Color color;

  const StockOverviewCard({
    required this.title,
    required this.count,
    required this.color,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        elevation: 5,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                title,
                style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Colors.white),
              ),
              const SizedBox(height: 10),
              Text(
                count,
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class CategoryDetailScreen extends StatelessWidget {
  final String categoryName;

  const CategoryDetailScreen({super.key, required this.categoryName});

  @override
  Widget build(BuildContext context) {
    Widget screen;

    switch (categoryName) {
      case 'Clients':
        screen = ClientsScreen();
        break;
      case 'Marchandise':
        throw Exception('Écran de Marchandise non implémenté');
      case 'Fournisseur':
        throw Exception('Écran de Fournisseur non implémenté');
      case 'Commandes':
        screen = CommandesHome();
      case 'Magasins':
        throw Exception('Écran de Magasins non implémenté');
      case 'Comptabilité':
        throw Exception('Écran de Comptabilité non implémenté');
      default:
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Navigator.of(context).popUntil((route) => route.isFirst);
        });
        screen = const Home(); // Redirection vers l'écran d'accueil
    }

    return Expanded(
      child: Container(
        child: screen,
      ),
    );
  }
}
