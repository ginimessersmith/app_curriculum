import 'package:curriculum/config/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:curriculum/features/shared/shared.dart';

class Perfil extends StatefulWidget {
  const Perfil({super.key});

  @override
  State<Perfil> createState() => _PerfilState();
}

class _PerfilState extends State<Perfil> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  List<dynamic> perfilInvitado = [];
  String nameUser = '';
  String emailUser = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SideMenu(scaffoldKey: scaffoldKey),
      appBar: AppBar(
        title: const Text('Perfil'),
      ),
      body: _PerfilView(),
      floatingActionButton:
          FloatingActionButton.extended(
            onPressed: () => {
              appRouter.go('/campaign')
            }, 
            label: const Text('ver convocatorias'),
            icon: const Icon(Icons.search),
            ),
    );
  }
}

class _PerfilView extends StatelessWidget {
  const _PerfilView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
