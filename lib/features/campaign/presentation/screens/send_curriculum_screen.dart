import 'package:curriculum/config/api/controllers/request.controller.dart';
import 'package:curriculum/features/shared/shared.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SendCurriculumScreen extends StatefulWidget {
  final String campaignId;
  const SendCurriculumScreen({super.key,required this.campaignId});

  @override
  State<SendCurriculumScreen> createState() => _SendCurriculumScreenState();
}

class _SendCurriculumScreenState extends State<SendCurriculumScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  String nameUser = '';
  String emailUser = '';
  String last_namesUser = '';
  int cellphoneUser = 0;
  String addressUser = '';
  String professionUser = '';

  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _nameController = TextEditingController();
  PlatformFile? _pickedFile;
  final RequestController _requestController = RequestController();

  Future<void> _pickFile() async {
    final result = await FilePicker.platform.pickFiles();
    if (result != null && result.files.isNotEmpty) {
      setState(() {
        _pickedFile = result.files.first;
      });
    }
  }

  Future<void> _sendForm() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    await _requestController.sendCurriculum(
      campaignId: widget.campaignId,
      emailPostulant: _emailController.text,
      namePostulant: _nameController.text,
      curriculumVitae: _pickedFile,
    );

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Formulario enviado con éxito')),
    );
  }

  @override
  void initState() {
    getDataUser();
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
      appBar: AppBar(
        title: Text('Enviar Curriculum'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              
              SizedBox(height: 16),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Correo electrónico'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese su correo electrónico';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Nombre completo'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese su nombre completo';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: _pickFile,
                child: Text('Seleccionar archivo'),
              ),
              SizedBox(height: 8),
              if (_pickedFile != null) Text('Archivo seleccionado: ${_pickedFile!.name}'),
              Spacer(),
              ElevatedButton(
                onPressed: _sendForm,
                child: Text('Enviar'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _nameController.dispose();
    super.dispose();
  }

}


// class SendCurriculumView extends StatelessWidget {
//   final String campaignId;
//   const SendCurriculumView({super.key, required this.campaignId});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Text(' $campaignId'),
//     );
//   }
// }
