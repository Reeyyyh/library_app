import 'dart:io';
import 'package:dio/dio.dart';

// Fungsi untuk mengupload file ke Cloudinary
// dan mengembalikan URL file hasil upload
Future<String> uploadFileToCloudinary(File filePath) async {
  // Inisialisasi instance Dio untuk melakukan HTTP request
  final dio = Dio();

  // Membuat FormData untuk kebutuhan multipart upload
  final formData = FormData.fromMap({
    // File yang akan diupload ke Cloudinary
    'file': await MultipartFile.fromFile(filePath.path),

    // Upload preset yang sudah dikonfigurasi di Cloudinary
    'upload_preset': 'mountain',
  });

  try {
    // Melakukan request POST ke endpoint Cloudinary
    final response = await dio.post(
      'https://api.cloudinary.com/v1_1/dwxhicnns/upload',
      data: formData,
    );

    // Mengecek apakah request berhasil (status code 200)
    if (response.statusCode == 200) {
      // Mengambil URL aman (secure_url) dari response
      final String fileUrl = response.data['secure_url'];

      // Mengembalikan URL file hasil upload
      return fileUrl;
    } else {
      // Jika status code bukan 200, lempar exception
      throw Exception('Failed to upload file');
    }
  } catch (e) {
    // Menangani error jika terjadi kegagalan saat upload
    throw Exception('Error uploading file: $e');
  }
}
