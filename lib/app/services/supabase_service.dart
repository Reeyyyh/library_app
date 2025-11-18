import 'dart:io';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  final supabase = Supabase.instance.client;

  Future<String?> uploadFile(File file, String fileName) async {
    try {
      // Upload ke Supabase
      final response = await supabase.storage.from('pdf-storage').upload(
            'uploads/$fileName', // Path dalam bucket
            file,
          );
      print('Upload response: $response');
      final publicUrl = supabase.storage
          .from('pdf-storage')
          .getPublicUrl('uploads/$fileName');
      print('Public URL: $publicUrl');
      return publicUrl; // URL file
      // if (response.isEmpty) {
      //   // Upload berhasil, dapatkan URL publik
      //   print('File uploaded: $publicUrl');
      // } else {
      //   // Upload gagal
      //   print('Error: Upload response is not empty');
      //   return null;
      // }
    } catch (e) {
      // Tangani exception
      print('Error uploading file: $e');
      return null;
    }
  }
}
