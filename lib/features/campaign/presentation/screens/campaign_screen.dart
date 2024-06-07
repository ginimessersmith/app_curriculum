import 'package:curriculum/config/api/controllers/campaign.controller.dart';
import 'package:curriculum/config/router/app_router.dart';
import 'package:curriculum/features/shared/shared.dart';
import 'package:flutter/material.dart';

class Campaign extends StatefulWidget {
  const Campaign({super.key});

  @override
  State<Campaign> createState() => _CampaignState();
}

class _CampaignState extends State<Campaign> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  List<dynamic> allCampaignApi = [];
  String nameUser = 'Gino';
  String emailUser = 'ginobaptista@gmail.com';

  @override
  void initState() {
    // all campaign
    CampaignController().findAllCampaign().then((value) {
      setState(() {
        allCampaignApi = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SideMenu(
        scaffoldKey: scaffoldKey,
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
                  ElevatedButton(onPressed: () => {
                    appRouter.go('/send-curriculum')
                  }, child: const Text('Ir'))
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
