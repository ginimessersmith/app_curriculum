import 'package:curriculum/config/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:curriculum/features/shared/shared.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  String last_namesUser = '';
  int cellphoneUser = 0;
  String addressUser = '';
  String professionUser = '';

  @override
  void initState() {
    this.getDataUser();
    super.initState();
  }

  void getDataUser() async {
    SharedPreferences user = await SharedPreferences.getInstance();
    String name = user.getString('names') ?? '';
    String email = user.getString('email') ?? '';
    String lastName = user.getString('last_names') ?? '';
    int cellphone = user.getInt('cellphone') ?? 0;
    String address = user.getString('address') ?? '';
    String profession = user.getString('profession') ?? '';
    // debugPrint('${name}');
    // debugPrint('${email}');
    // debugPrint('${lastName}');
    // debugPrint('${cellphone}');
    // debugPrint('${address}');

    setState(() {
      nameUser = name;
      emailUser = email;
      last_namesUser = lastName;
      cellphoneUser = cellphone;
      addressUser = address;
      professionUser = profession;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SideMenu(
        scaffoldKey: scaffoldKey,
        name: nameUser,
        email: emailUser,
      ),
      appBar: AppBar(
        title: const Text('Perfil'),
      ),
      body: _PerfilView(
        name: nameUser,
        email: emailUser,
        lastName: last_namesUser,
        cellphone: cellphoneUser,
        address: addressUser,
        profession: professionUser,
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => {appRouter.go('/campaign')},
        label: const Text('ver convocatorias'),
        icon: const Icon(Icons.search),
      ),
    );
  }
}

class _PerfilView extends StatelessWidget {
  final String name;
  final String email;
  final String lastName;
  final int cellphone;
  final String address;
  final String profession;

  const _PerfilView(
      {super.key,
      required this.name,
      required this.email,
      required this.lastName,
      required this.cellphone,
      required this.address,
      required this.profession});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Bienvenido',
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16.0),
          _buildInfoRow('Nombre:', '$name $lastName'),
          _buildInfoRow('Correo electrónico:', email),
          _buildInfoRow('Teléfono:', '$cellphone'),
          _buildInfoRow('Dirección:', address),
          _buildInfoRow('Profesión: ', profession),
        ],
      ),
    );
  }
}

Widget _buildInfoRow(String title, String value) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(width: 8.0),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(
              fontSize: 16.0,
            ),
          ),
        ),
      ],
    ),
  );
}
