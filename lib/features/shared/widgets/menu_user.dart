import 'package:flutter/material.dart';

class MenuUser {
  final String label;
  final String link;
  final IconData icon;

  MenuUser({required this.label, required this.link, required this.icon});
}

final List<MenuUser> appMenuUser = [
  MenuUser(label: 'Mi Perfil', link: '/perfil', icon: Icons.home_outlined),
  MenuUser(label: 'Convocatoria', link: '/campaign', icon: Icons.search),
];
