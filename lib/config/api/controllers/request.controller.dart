import 'package:curriculum/config/api/connections/api.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class RequestController {
  final Dio _dio = Dio();
  final String api = apiUrl;

  Future<void> sendCurriculum({
    required String campaignId,
    required String emailPostulant,
    required String namePostulant,
    PlatformFile? curriculumVitae,
  }) async {
    print(curriculumVitae);
    String? path = curriculumVitae?.path;
    String? fileName = curriculumVitae?.name;
    print(' file name : $fileName');
    print('path file: $path');

    if (path == null || fileName == null) {
      throw Exception('El archivo no es válido.');
    }

    // final FormData data = FormData.fromMap({
    //   'file': MultipartFile.fromFileSync(path, filename: fileName)
    // });

    final FormData formData = FormData.fromMap({
      'curriculumVitae': MultipartFile.fromFileSync(
        path,
        filename: fileName,
      ),
      'campaignId': campaignId,
      'emailPostulant': emailPostulant,
      'namePostulant': namePostulant,
    });
    try {
      final response = await _dio.post(
        '$api/curriculum/create-request',
        data: formData,
      );

      if (response.statusCode == 200) {
        print('Formulario enviado con éxito');
      } else {
        print('Error al enviar el formulario');
      }
    } catch (e) {
      print('ERROOOOOOORRRRRRRR:.........................');
      print('Error: $e');
    }
  }
}
