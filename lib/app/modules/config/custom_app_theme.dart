import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// Kelas yang berisi tema kustom untuk aplikasi perpustakaan
class CustomAppTheme {
  // Warna utama aplikasi
  static const Color primaryColor = Color(0xFF009140);

  // Warna background aplikasi
  static const Color backgroundColor = Color(0xFFE8F5E9);

  // Heading terbesar (judul halaman)
  static TextStyle heading1 = GoogleFonts.montserrat(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );

  // Heading besar untuk subjudul penting
  static TextStyle heading2 = GoogleFonts.montserrat(
    fontSize: 28,
    fontWeight: FontWeight.w600,
    color: Colors.black87,
  );

  // Heading sedang untuk section/title konten
  static TextStyle heading3 = GoogleFonts.montserrat(
    fontSize: 24,
    fontWeight: FontWeight.w500,
    color: Colors.black,
  );

  // Heading kecil untuk elemen pendukung
  static TextStyle heading4 = GoogleFonts.montserrat(
    fontSize: 20,
    fontWeight: FontWeight.w500,
    color: Colors.black,
  );

  // Teks utama untuk paragraf / isi konten
  static TextStyle bodyText = GoogleFonts.montserrat(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: Colors.black,
  );

  // Subheading untuk informasi pendukung di bawah judul
  static TextStyle subheading = GoogleFonts.montserrat(
    fontSize: 18,
    fontWeight: FontWeight.w500,
    color: Colors.black54,
  );

  // Caption untuk teks kecil seperti label tambahan
  static TextStyle caption = GoogleFonts.montserrat(
    fontSize: 12,
    fontWeight: FontWeight.normal,
    color: Colors.grey,
  );

  // Style khusus untuk teks tombol
  static TextStyle buttonText = GoogleFonts.montserrat(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );

  // Teks kecil untuk catatan / info ringan
  static TextStyle smallText = GoogleFonts.montserrat(
    fontSize: 12,
    fontWeight: FontWeight.normal,
    color: Colors.black54,
  );

  // Teks redup untuk info minor atau placeholder
  static TextStyle mutedText = GoogleFonts.montserrat(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: Color(0xFF9E9E9E),
  );
}
