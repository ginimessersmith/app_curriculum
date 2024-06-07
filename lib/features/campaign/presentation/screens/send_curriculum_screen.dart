import 'package:curriculum/features/shared/shared.dart';
import 'package:flutter/material.dart';

class SendCurriculumScreen extends StatefulWidget {
  const SendCurriculumScreen({super.key});

  @override
  State<SendCurriculumScreen> createState() => _SendCurriculumScreenState();
}

class _SendCurriculumScreenState extends State<SendCurriculumScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SideMenu(scaffoldKey: scaffoldKey) ,
      appBar: AppBar(
        title: Text('Enviar'),
      ),
      body: SendCurriculumView(),
    );
  }
}

class SendCurriculumView extends StatelessWidget {
  const SendCurriculumView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
