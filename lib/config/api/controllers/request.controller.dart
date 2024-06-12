import 'package:curriculum/config/api/connections/api.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';

class RequestController {
  final Dio _dio = Dio();
  final String api = apiUrl;

  Future<void> sendCurriculum({
    required String campaignId,
    required String emailPostulant,
    required String namePostulant,
    PlatformFile? curriculumVitae,
  }) async {
    FormData formData = FormData();

    formData.fields.addAll([
      MapEntry('campaignId', campaignId),
      MapEntry('emailPostulant', emailPostulant),
      MapEntry('namePostulant', namePostulant),
    ]);

    if (curriculumVitae != null) {
      formData.files.add(MapEntry(
        'curriculumVitae',
        await MultipartFile.fromFile(
          curriculumVitae.path!,
          filename: curriculumVitae.name,
        ),
      ));
    }

    // String fileName = formData.files['curriculumVitae']!.filename;
    // final formData = FormData.fromMap({
    //   'campaignId': campaignId,
    //   'emailPostulant': emailPostulant,
    //   'namePostulant': namePostulant,
    //   if (curriculumVitae != null)
    //     'curriculumVitae': await MultipartFile.fromFile(
    //       curriculumVitae.path!,
    //       filename: curriculumVitae.name,
    //     ),
    // });

    try {
      final response =
          await _dio.post('$api/curriculum/create-request', data: formData);
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
