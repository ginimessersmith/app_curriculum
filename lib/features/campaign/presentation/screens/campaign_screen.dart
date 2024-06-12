import 'package:curriculum/config/api/controllers/campaign.controller.dart';
import 'package:curriculum/config/router/app_router.dart';
import 'package:curriculum/features/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Campaign extends StatefulWidget {
  const Campaign({super.key});

  @override
  State<Campaign> createState() => _CampaignState();
}

class _CampaignState extends State<Campaign> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  List<dynamic> allCampaignApi = [];
  String nameUser = '';
  String emailUser = '';
  String last_namesUser = '';
  int cellphoneUser = 0;
  String addressUser = '';
  String professionUser = '';

  @override
  void initState() {
    // all campaign
    getDataUser();
    CampaignController().findAllCampaign().then((value) {
      setState(() {
        allCampaignApi = value;
      });
    });
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
        name: '',
        email: '',
      ),
      body: CampaignView(
        allCampaign: allCampaignApi,
      ),
      appBar: AppBar(
        title: const Text('Convocatorias'),
      ),
    );
  }
}

class CampaignView extends StatelessWidget {
  const CampaignView({Key? key, required this.allCampaign});
  final List<dynamic> allCampaign;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: allCampaign.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          margin: const EdgeInsets.all(10),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: Colors.amber,
              boxShadow: const [
                BoxShadow(
                    color: Colors.black, blurRadius: 5, offset: Offset(0, 5))
              ],
              borderRadius: BorderRadius.circular(20)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Empresa: ${allCampaign[index]['nameEnterprise']}'),
              const Divider(color: Colors.black),
              Text('Convocatoria: ${allCampaign[index]['name']}'),
              const Divider(color: Colors.black),
              Text('Descripcion: ${allCampaign[index]['description']}'),
              const Divider(color: Colors.black),
              Text('Requisitos: ${allCampaign[index]['parameters']}'),
              Row(
                children: [
                  const Spacer(),
                  ElevatedButton(
                      onPressed: () => context.push('/send-curriculum',
                          extra: allCampaign[index]['id'] as String),
                      child: const Text('Ir'))
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
