// Mengunggah file ke Cloudinary dan mengembalikan URL file yang berhasil di-upload.
// Parameter: filePath = objek File yang akan diunggah.
// Menggunakan Dio untuk melakukan HTTP POST dengan FormData.
// Jika berhasil (status 200), fungsi mengembalikan 'secure_url' dari response Cloudinary.
// Jika gagal, melempar Exception dengan pesan error.
Future<String> uploadFileToCloudinary(File filePath) async {
  final dio = Dio();
  final formData = FormData.fromMap({
    'file': await MultipartFile.fromFile(filePath.path), // Konversi file ke Multipart
    'upload_preset': 'mountain', // Upload preset Cloudinary
  });

  try {
    final response = await dio.post(
      'https://api.cloudinary.com/v1_1/dwxhicnns/upload', // Endpoint Cloudinary
      data: formData,
    );

    if (response.statusCode == 200) {
      final String fileUrl = response.data['secure_url']; // URL file hasil upload
      return fileUrl;
    } else {
      throw Exception('Failed to upload file'); // Error jika status bukan 200
    }
  } catch (e) {
    throw Exception('Error uploading file: $e'); // Error jika request gagal
  }
}
