import 'dart:convert';

import 'package:curriculum/config/api/connections/api-springBoot.dart';
import 'package:curriculum/config/router/app_router.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class AuthController {
  void login(
    TextEditingController email,
    TextEditingController pass,
  ) async {
    debugPrint('login execute');
    if (email.text.isNotEmpty && pass.text.isNotEmpty) {
      SharedPreferences user = await SharedPreferences.getInstance();
      var response = await http.post(
          Uri.parse('${apiUrlSpringBoot}/users/authenticate'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({'email': email.text, 'pass': pass.text}));
      // debugPrint('response ${response}');
      debugPrint('email ${email.text}');
      debugPrint('password ${pass.text}');
      print({response});
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        await user.setString('token', data['token']);
        await user.setString('email', email.text);
        await user.setString('id', data['id']);
        await user.setString('names', data['employee']['names']);
        await user.setString('last_names', data['employee']['last_names']);
        await user.setInt('cellphone', data['employee']['cellphone']);
        await user.setString('address', data['employee']['address']);
        await user.setString(
            'profession', data['employee']['profession']['profession']);

        appRouter.go('/perfil');
      } else {
        debugPrint('error status code not 200');
      }
    } else {
      debugPrint('login error, is empty');
    }
  }
}
