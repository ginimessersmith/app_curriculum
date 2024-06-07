import 'dart:convert';

import 'package:curriculum/config/api/connections/api.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class CampaignController {
  Future findAllCampaign() async {
    var response =
        await http.get(Uri.parse('$apiUrl/curriculum/find-all-campaign'));
    if (response.statusCode == 200) {
      try {
        var data = jsonDecode(response.body);
        List<Map<String, dynamic>> allCampaign = List.from(data);
        debugPrint('data find all campaign: $allCampaign');
        return allCampaign;
      } catch (e) {
        debugPrint('error al obtener todas las convocatorias: $e');
      }
    }
  }
}
