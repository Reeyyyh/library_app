import 'dart:io';
import 'package:supabase_flutter/supabase_flutter.dart';

// Service untuk menangani interaksi dengan Supabase Storage
class SupabaseService {
  // Instance client Supabase
  final supabase = Supabase.instance.client;

  // Fungsi untuk meng-upload file ke Supabase Storage
  // Mengembalikan URL publik file jika berhasil, null jika gagal
  Future<String?> uploadFile(File file, String fileName) async {
    try {
      // Proses upload file ke bucket "pdf-storage"
      // File disimpan di folder "uploads/" dengan nama fileName
      final response = await supabase.storage.from('pdf-storage').upload(
            'uploads/$fileName',
            file,
          );

      // Log response upload (debugging)
      print('Upload response: $response');

      // Mendapatkan URL publik dari file yang telah di-upload
      final publicUrl = supabase.storage
          .from('pdf-storage')
          .getPublicUrl('uploads/$fileName');

      // Log URL publik (debugging)
      print('Public URL: $publicUrl');

      // Mengembalikan URL publik file
      return publicUrl;
    } catch (e) {
      // Menangani error jika upload gagal
      print('Error uploading file: $e');
      return null;
    }
  }
}
