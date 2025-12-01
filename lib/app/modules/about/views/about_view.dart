import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:library_app/app/constants/theme.dart';
import 'package:library_app/app/widgets/custom_appbar.dart';

import '../controllers/about_controller.dart';

class AboutView extends GetView<AboutController> {
  const AboutView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Tentang Aplikasi'),
      body: ListView(
        padding: EdgeInsets.symmetric(
          vertical: 20,
          horizontal: 16,
        ),
        children: [
          buildTitle('About Library App'),
          Container(
            margin: EdgeInsets.only(
              bottom: 16,
              top: 10,
            ),
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Text(
              'Library App adalah solusi modern untuk mengelola kebutuhan perpustakaan sekolah secara digital. Aplikasi ini dirancang untuk mempermudah siswa dalam mengakses koleksi buku sekolah, baik buku fisik maupun digital, sekaligus menciptakan pengalaman perpustakaan yang lebih interaktif dan ramah pengguna. Dengan teknologi yang intuitif, aplikasi ini menghadirkan fitur-fitur yang mendukung pembelajaran dan aktivitas literasi siswa, serta mempermudah pihak sekolah dalam mengelola transaksi peminjaman dan kebutuhan perpustakaan lainnya.  ',
              style: AppTheme.bodyText.copyWith(
                fontSize: 14,
              ),
              textAlign: TextAlign.justify,
            ),
          ),
          buildTitle('Kenapa Menggunakan Library App?'),
          Container(
            margin: EdgeInsets.only(
              bottom: 16,
              top: 10,
            ),
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Text(
              'Dalam era digital seperti sekarang, akses terhadap informasi dan literasi menjadi kebutuhan utama. Library App hadir untuk menjawab tantangan tersebut dengan memberikan kemudahan, kenyamanan, dan efisiensi, baik bagi siswa maupun pihak perpustakaan.',
              style: AppTheme.bodyText.copyWith(
                fontSize: 14,
              ),
              textAlign: TextAlign.justify,
            ),
          ),
          buildTitle('Fitur-fitur Utama'),
          Container(
            margin: EdgeInsets.only(
              bottom: 16,
              top: 10,
            ),
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              children: <Widget>[
                buildList(
                  '1. Peminjaman Buku Fisik dan Digital',
                  ' Dengan Library App, siswa dapat memesan buku fisik langsung melalui aplikasi, tanpa perlu repot mengantre di perpustakaan. Selain itu, koleksi buku digital dapat diakses kapan saja dan di mana saja, memungkinkan siswa membaca buku favorit mereka langsung melalui perangkat mereka.',
                ),
                buildList(
                  '2. Manajemen Transaksi yang Mudah',
                  'Semua transaksi peminjaman buku tercatat secara otomatis dalam sistem, sehingga memudahkan pengelolaan data peminjaman. Baik siswa maupun pihak perpustakaan dapat memantau status buku yang sedang dipinjam, kapan harus dikembalikan, dan riwayat peminjaman dengan transparansi penuh.',
                ),
                buildList(
                  '3. Fitur Kritik dan Saran',
                  'Library App tidak hanya sekadar aplikasi perpustakaan, tetapi juga menjadi platform komunikasi antara siswa dan pihak sekolah. Melalui fitur kritik dan saran, siswa dapat memberikan masukan yang konstruktif untuk meningkatkan layanan perpustakaan, menjadikan pengalaman belajar lebih menyenangkan dan mendukung kebutuhan mereka.',
                ),
                buildList(
                  '4. Pengajuan Buku Baru',
                  ' Apakah buku yang diinginkan belum tersedia? Dengan Library App, siswa dapat mengajukan permintaan buku tertentu untuk ditambahkan ke koleksi perpustakaan. Permintaan ini dapat mencakup buku fisik untuk dipinjam atau buku digital untuk diakses secara online, memastikan setiap siswa mendapatkan akses literasi yang mereka butuhkan.  ',
                ),
                buildList(
                  '5. Peningkatan Literasi Digital',
                  'Selain menyediakan buku fisik, Library App mendorong penggunaan teknologi untuk membaca dan belajar. Dengan koleksi buku digital yang terus berkembang, aplikasi ini mendukung siswa untuk meningkatkan kemampuan literasi digital mereka, yang sangat penting di era teknologi seperti sekarang. ',
                ),
              ],
            ),
          ),
          buildTitle('Manfaat Library App'),
          Container(
            margin: EdgeInsets.only(
              bottom: 16,
              top: 10,
            ),
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              children: <Widget>[
                buildList(
                  '1. Kemudahan Akses',
                  'Semua layanan perpustakaan dapat diakses hanya dengan beberapa klik, baik untuk meminjam, membaca, memberikan saran, maupun mengajukan buku baru.',
                ),
                buildList(
                  '2. Interaksi Lebih Baik',
                  'Dengan fitur kritik dan saran, siswa memiliki saluran langsung untuk menyampaikan kebutuhan mereka, sehingga perpustakaan dapat berkembang sesuai dengan keinginan siswa. ',
                ),
                buildList(
                  '3. Efisiensi Pengelolaan',
                  'Sistem otomatisasi dalam aplikasi ini mengurangi beban administrasi, memungkinkan pustakawan fokus pada hal-hal yang lebih penting, seperti pengelolaan koleksi dan pelayanan siswa. ',
                ),
                buildList(
                  '4. Mendukung Literasi Siswa',
                  'Dengan koleksi buku digital yang dapat diakses kapan saja, siswa dapat memperluas pengetahuan mereka tanpa batasan waktu dan tempat.  ',
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              bottom: 16,
              top: 10,
            ),
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Text(
              'Library App bukan hanya alat untuk mengelola perpustakaan, tetapi juga sarana untuk membangun budaya literasi di sekolah. Dengan memanfaatkan teknologi modern, aplikasi ini menciptakan lingkungan belajar yang lebih inklusif, efisien, dan interaktif, mendukung siswa untuk mencapai potensi terbaik mereka. ',
              style: AppTheme.bodyText.copyWith(
                fontSize: 14,
              ),
              textAlign: TextAlign.justify,
            ),
          ),
        ],
      ),
    );
  }

  Column buildList(String title, String description) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          title,
          style: AppTheme.heading1.copyWith(
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          description,
          style: AppTheme.bodyText.copyWith(
            fontSize: 12,
          ),
          textAlign: TextAlign.justify,
        ),
        const SizedBox(height: 12),
      ],
    );
  }

  Text buildTitle(String title) {
    return Text(
      title,
      style: AppTheme.heading1.copyWith(
        fontSize: 20,
      ),
    );
  }
}
