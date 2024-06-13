import 'dart:html';

import 'package:curriculum/config/api/connections/api.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

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

    final FormData formData = FormData.fromMap({
      'curriculumVitae':await MultipartFile.fromFileSync(
        path,
        filename: fileName,
        contentType: MediaType('application', 'pdf'),
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
    } on DioException catch (e) {
      if (e.response != null) {
        print('headers: ${e.response!.headers}');
        print('requestOptions: ${e.response!.requestOptions}');
        print('data: ${e.response!.data}');
      }
    }
  }
}
