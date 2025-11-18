import 'dart:io';
import 'package:dio/dio.dart';

Future<String> uploadFileToCloudinary(File filePath) async {
  final dio = Dio();
  final formData = FormData.fromMap({
    'file': await MultipartFile.fromFile(filePath.path),
    'upload_preset': 'mountain',
  });

  try {
    final response = await dio.post(
      'https://api.cloudinary.com/v1_1/dwxhicnns/upload',
      data: formData,
    );

    if (response.statusCode == 200) {
      final String fileUrl = response.data['secure_url'];
      return fileUrl;
    } else {
      throw Exception('Failed to upload file');
    }
  } catch (e) {
    throw Exception('Error uploading file: $e');
  }
}
