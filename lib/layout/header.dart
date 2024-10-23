import 'package:flutter/material.dart';

class Header extends StatelessWidget implements PreferredSizeWidget {
  final String title; // Propriété pour le titre

  @override
  final Size preferredSize;

  Header({super.key, required this.title})
      : preferredSize = Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title, // Le texte principal à gauche
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: GestureDetector(
            onTap: () {
              // Action pour cliquer sur l'icône utilisateur
              print('User profile clicked');
            },
            child: CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://th.bing.com/th/id/OIP.RfyisiRVT0emxjQ_567idwHaKz?rs=1&pid=ImgDetMain'), // Remplacez par une URL d'image de profil
              radius: 20, // Ajustez la taille du cercle ici
              backgroundColor: Colors.grey
                  .shade200, // Couleur de fond au cas où l'image ne se chargerait pas
            ),
          ),
        ),
      ],
      backgroundColor: Colors.blueAccent,
      elevation: 4,
      centerTitle: false, // Pour aligner le titre à gauche
    );
  }
}
