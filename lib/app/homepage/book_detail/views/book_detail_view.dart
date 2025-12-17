import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:library_app/app/constants/theme.dart';
import 'package:library_app/app/widgets/build_rating.dart';
import 'package:library_app/app/widgets/custom_appbar.dart';
import 'package:library_app/app/widgets/custom_button.dart';
import 'package:library_app/app/widgets/dateformat.dart';
import '../controllers/book_detail_controller.dart';

class BookDetailView extends GetView<BookDetailController> {
  const BookDetailView({super.key});

  // Reusable decoration untuk container putih dengan shadow
  BoxDecoration get _cardDecoration => BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3)),
        ],
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Detail Buku'),
      body: Obx(() => ListView(
            padding: const EdgeInsets.fromLTRB(16, 20, 16, 40),
            children: [
              _buildImage(),
              const SizedBox(height: 22),
              Text(controller.data['judul'],
                  style: AppTheme.heading1
                      .copyWith(color: Colors.black, fontSize: 24)),
              const SizedBox(height: 8),
              _sectionTitle('Informasi'),
              _buildInfoTable(),
              _sectionTitle('Deskripsi'),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: _cardDecoration,
                child: Text(controller.data['deskripsi'],
                    style: AppTheme.bodyText),
              ),
              _sectionTitle('Testimoni'),
              _buildTestimonialStream(),
              const SizedBox(height: 20),
              _buildActionButton(),
            ],
          )),
    );
  }

  Widget _sectionTitle(String title) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Text(title, style: AppTheme.heading2.copyWith(fontSize: 16)),
      );

  Widget _buildImage() {
    return Hero(
      tag: controller.data['imageUrl'],
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: CachedNetworkImage(
          imageUrl: controller.data['imageUrl'],
          width: Get.width,
          fit: BoxFit.cover,
          placeholder: (_, __) =>
              const Center(child: CircularProgressIndicator()),
          errorWidget: (_, __, ___) => const Icon(Icons.error),
        ),
      ),
    );
  }

  Widget _buildInfoTable() {
    final isDigital = controller.data['isDigital'] == true;
    return Container(
      decoration: _cardDecoration,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Table(
          columnWidths: const {0: FlexColumnWidth(2), 1: FlexColumnWidth(4)},
          children: [
            _row('Penulis', controller.data['penulis'], 0),
            _row('Penerbit', controller.data['penerbit'], 1),
            _row('Tahun', controller.data['tahun'], 2),
            if (!isDigital) _row('Stok', '${controller.data['stok']}', 3),
            _row('Status', controller.data['status'], isDigital ? 3 : 4),
            _row('Kategori', controller.category['name'], isDigital ? 4 : 5),
          ],
        ),
      ),
    );
  }

  TableRow _row(String label, String value, int idx) {
    return TableRow(
      decoration: BoxDecoration(
          color: idx.isEven ? Colors.white : const Color(0xffF6F6F6)),
      children: [
        Padding(padding: const EdgeInsets.all(8.0), child: Text(label)),
        Padding(padding: const EdgeInsets.all(8.0), child: Text(value)),
      ],
    );
  }

  Widget _buildTestimonialStream() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('testimoni')
          .where('book_id', isEqualTo: controller.data['id'])
          .orderBy('created_at', descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting)
          return const Center(child: CircularProgressIndicator());
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty)
          return const Text('Belum ada ulasan.');

        return ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: snapshot.data!.docs.length,
          separatorBuilder: (_, __) => const SizedBox(height: 8),
          itemBuilder: (_, i) => _TestimonialItem(
            data: snapshot.data!.docs[i].data() as Map<String, dynamic>,
            decoration: _cardDecoration,
          ),
        );
      },
    );
  }

  Widget _buildActionButton() {
    final isDigital = controller.data['isDigital'] == true;
    return CustomButton(
      text: isDigital ? 'Baca Sekarang' : 'Pinjam Buku',
      onPressed: () {
        if (isDigital) {
          Get.toNamed('/pdf-reader',
              arguments: controller.data['digitalBookUrl']);
        } else if (controller.data['stok'] == 0) {
          Get.snackbar('Gagal', 'Stok habis',
              backgroundColor: Colors.red, colorText: Colors.white);
        } else {
          Get.toNamed('/sewa-buku', arguments: {
            'bookData': controller.data,
            'category': controller.category,
          });
        }
      },
    );
  }
}

// Widget Terpisah untuk Item Testimoni agar kode utama lebih bersih
class _TestimonialItem extends StatelessWidget {
  final Map<String, dynamic> data;
  final BoxDecoration decoration;

  const _TestimonialItem({required this.data, required this.decoration});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
      future: FirebaseFirestore.instance
          .collection('users')
          .doc(data['user_email'])
          .get(),
      builder: (context, snapshot) {
        if (!snapshot.hasData)
          return const SizedBox(); // Loading silent atau skeleton
        final user = snapshot.data!.data() as Map<String, dynamic>;

        return Container(
          decoration: decoration,
          child: ListTile(
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _textRow('Nama', user['name']),
                const SizedBox(height: 4),
                _textRow('Email', user['email']),
                const SizedBox(height: 4),
                Text('Testimoni: ${data['testimoni']}',
                    style: AppTheme.heading2.copyWith(fontSize: 14)),
                buildRating(rating: data['rating']),
                const SizedBox(height: 4),
                Text(dateFormatFromDateTime(data['created_at']),
                    style: const TextStyle(color: Colors.grey, fontSize: 12)),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _textRow(String label, String value) => RichText(
        text: TextSpan(
          style: const TextStyle(color: Colors.black, fontSize: 14),
          children: [
            TextSpan(
                text: '$label : ', style: const TextStyle(color: Colors.grey)),
            TextSpan(text: value, style: AppTheme.heading2),
          ],
        ),
      );
}
