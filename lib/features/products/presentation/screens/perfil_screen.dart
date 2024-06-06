import 'package:flutter/material.dart';
import 'package:curriculum/features/shared/shared.dart';

class PerfilScreen extends StatelessWidget {
  const PerfilScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      drawer: SideMenu( scaffoldKey: scaffoldKey ),
      appBar: AppBar(
        title: const Text('Perfil'),
        actions: [
          IconButton(
            onPressed: (){}, 
            icon: const Icon( Icons.search_rounded)
          )
        ],
      ),
      body: const _PerfilView(),
      floatingActionButton: FloatingActionButton.extended(
        label: const Text('Opciones'),
        icon: const Icon( Icons.add ),
        onPressed: () {},
      ),
    );
  }
}


class _PerfilView extends StatelessWidget {
  const _PerfilView();

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Editar'));
  }
}