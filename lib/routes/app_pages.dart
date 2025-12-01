import 'package:get/get.dart';

import '../modules/about/bindings/about_binding.dart';
import '../modules/about/views/about_view.dart';
import '../modules/admin/books/create_book/bindings/create_book_binding.dart';
import '../modules/admin/books/create_book/views/create_book_view.dart';
import '../modules/admin/books/list_book/bindings/list_book_binding.dart';
import '../modules/admin/books/list_book/views/list_book_view.dart';
import '../modules/admin/books/update_book/bindings/update_book_binding.dart';
import '../modules/admin/books/update_book/views/update_book_view.dart';
import '../modules/admin/categories/create_category/bindings/create_category_binding.dart';
import '../modules/admin/categories/create_category/views/create_category_view.dart';
import '../modules/admin/categories/list_categories/bindings/list_categories_binding.dart';
import '../modules/admin/categories/list_categories/views/list_categories_view.dart';
import '../modules/admin/categories/update_category/bindings/update_category_binding.dart';
import '../modules/admin/categories/update_category/views/update_category_view.dart';
import '../modules/admin/dashboard/bindings/dashboard_binding.dart';
import '../modules/admin/dashboard/views/dashboard_view.dart';
import '../modules/admin/faq/create_faq/bindings/create_faq_binding.dart';
import '../modules/admin/faq/create_faq/views/create_faq_view.dart';
import '../modules/admin/faq/list_faq/bindings/list_faq_binding.dart';
import '../modules/admin/faq/list_faq/views/list_faq_view.dart';
import '../modules/admin/faq/update_faq/bindings/update_faq_binding.dart';
import '../modules/admin/faq/update_faq/views/update_faq_view.dart';
import '../modules/admin/history/detail_history/bindings/detail_history_binding.dart';
import '../modules/admin/history/detail_history/views/detail_history_view.dart';
import '../modules/admin/history/list_history/bindings/list_history_binding.dart';
import '../modules/admin/history/list_history/views/list_history_view.dart';
import '../modules/admin/kritik_saran_admin/bindings/kritik_saran_admin_binding.dart';
import '../modules/admin/kritik_saran_admin/views/kritik_saran_admin_view.dart';
import '../modules/admin/lainnya/bindings/lainnya_binding.dart';
import '../modules/admin/lainnya/views/lainnya_view.dart';
import '../modules/admin/pengajuan_buku_admin/bindings/pengajuan_buku_admin_binding.dart';
import '../modules/admin/pengajuan_buku_admin/views/pengajuan_buku_admin_view.dart';
import '../modules/admin/users/list_user/bindings/list_user_binding.dart';
import '../modules/admin/users/list_user/views/list_user_view.dart';
import '../modules/admin/users/update_user/bindings/update_user_binding.dart';
import '../modules/admin/users/update_user/views/update_user_view.dart';
import '../modules/auth/login/bindings/login_binding.dart';
import '../modules/auth/login/views/login_view.dart';
import '../modules/auth/register/bindings/register_binding.dart';
import '../modules/auth/register/views/register_view.dart';
import '../modules/edit_profile/bindings/edit_profile_binding.dart';
import '../modules/edit_profile/views/edit_profile_view.dart';
import '../modules/homepage/book_detail/bindings/book_detail_binding.dart';
import '../modules/homepage/book_detail/views/book_detail_view.dart';
import '../modules/homepage/create_kritik_saran/bindings/create_kritik_saran_binding.dart';
import '../modules/homepage/create_kritik_saran/views/create_kritik_saran_view.dart';
import '../modules/homepage/faq/bindings/faq_binding.dart';
import '../modules/homepage/faq/views/faq_view.dart';
import '../modules/homepage/home/bindings/home_binding.dart';
import '../modules/homepage/home/views/home_view.dart';
import '../modules/homepage/kategori/bindings/kategori_binding.dart';
import '../modules/homepage/kategori/views/kategori_view.dart';
import '../modules/homepage/koleksi/bindings/koleksi_binding.dart';
import '../modules/homepage/koleksi/views/koleksi_view.dart';
import '../modules/homepage/kritik_saran/bindings/kritik_saran_binding.dart';
import '../modules/homepage/kritik_saran/views/kritik_saran_view.dart';
import '../modules/homepage/layanan/bindings/layanan_binding.dart';
import '../modules/homepage/layanan/views/layanan_view.dart';
import '../modules/homepage/pdf_reader/bindings/pdf_reader_binding.dart';
import '../modules/homepage/pdf_reader/views/pdf_reader_view.dart';
import '../modules/homepage/pengajuan_buku/bindings/pengajuan_buku_binding.dart';
import '../modules/homepage/pengajuan_buku/views/pengajuan_buku_view.dart';
import '../modules/homepage/pengajuan_buku_create/bindings/pengajuan_buku_create_binding.dart';
import '../modules/homepage/pengajuan_buku_create/views/pengajuan_buku_create_view.dart';
import '../modules/homepage/pengajuan_buku_update/bindings/pengajuan_buku_update_binding.dart';
import '../modules/homepage/pengajuan_buku_update/views/pengajuan_buku_update_view.dart';
import '../modules/homepage/profile/bindings/profile_binding.dart';
import '../modules/homepage/profile/views/profile_view.dart';
import '../modules/homepage/riwayat/bindings/riwayat_binding.dart';
import '../modules/homepage/riwayat/views/riwayat_view.dart';
import '../modules/homepage/sewa/sewa_buku/bindings/sewa_buku_binding.dart';
import '../modules/homepage/sewa/sewa_buku/views/sewa_buku_view.dart';
import '../modules/homepage/sewa/sewa_detail/bindings/sewa_detail_binding.dart';
import '../modules/homepage/sewa/sewa_detail/views/sewa_detail_view.dart';
import '../modules/homepage/sewa/sewa_sukses/bindings/sewa_sukses_binding.dart';
import '../modules/homepage/sewa/sewa_sukses/views/sewa_sukses_view.dart';
import '../modules/layout/bindings/layout_binding.dart';
import '../modules/layout/views/layout_view.dart';
import '../modules/admin/testimoni/list_testimoni/bindings/list_testimoni_binding.dart';
import '../modules/admin/testimoni/list_testimoni/views/list_testimoni_view.dart';
import '../modules/onboard/splash/bindings/splash_binding.dart';
import '../modules/onboard/splash/views/splash_view.dart';
import '../modules/onboard/welcome/bindings/welcome_binding.dart';
import '../modules/onboard/welcome/views/welcome_view.dart';
import '../modules/setting/bindings/setting_binding.dart';
import '../modules/setting/views/setting_view.dart';
import '../modules/setting_admin/bindings/setting_admin_binding.dart';
import '../modules/setting_admin/views/setting_admin_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.SPLASH,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.WELCOME,
      page: () => const WelcomeView(),
      binding: WelcomeBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.REGISTER,
      page: () => const RegisterView(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: _Paths.LAYOUT,
      page: () => const LayoutView(),
      binding: LayoutBinding(),
    ),
    GetPage(
      name: _Paths.KOLEKSI,
      page: () => const KoleksiView(),
      binding: KoleksiBinding(),
    ),
    GetPage(
      name: _Paths.RIWAYAT,
      page: () => const RiwayatView(),
      binding: RiwayatBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => const ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.DASHBOARD,
      page: () => const DashboardView(),
      binding: DashboardBinding(),
    ),
    GetPage(
      name: _Paths.LIST_BOOK,
      page: () => const ListBookView(),
      binding: ListBookBinding(),
    ),
    GetPage(
      name: _Paths.CREATE_BOOK,
      page: () => const CreateBookView(),
      binding: CreateBookBinding(),
    ),
    GetPage(
      name: _Paths.UPDATE_BOOK,
      page: () => const UpdateBookView(),
      binding: UpdateBookBinding(),
    ),
    GetPage(
      name: _Paths.LIST_CATEGORIES,
      page: () => const ListCategoriesView(),
      binding: ListCategoriesBinding(),
    ),
    GetPage(
      name: _Paths.UPDATE_CATEGORY,
      page: () => const UpdateCategoryView(),
      binding: UpdateCategoryBinding(),
    ),
    GetPage(
      name: _Paths.CREATE_CATEGORY,
      page: () => const CreateCategoryView(),
      binding: CreateCategoryBinding(),
    ),
    GetPage(
      name: _Paths.LIST_HISTORY,
      page: () => const ListHistoryView(),
      binding: ListHistoryBinding(),
    ),
    GetPage(
      name: _Paths.LIST_USER,
      page: () => const ListUserView(),
      binding: ListUserBinding(),
    ),
    GetPage(
      name: _Paths.KATEGORI,
      page: () => const KategoriView(),
      binding: KategoriBinding(),
    ),
    GetPage(
      name: _Paths.BOOK_DETAIL,
      page: () => const BookDetailView(),
      binding: BookDetailBinding(),
    ),
    GetPage(
      name: _Paths.PDF_READER,
      page: () => const PdfReaderView(),
      binding: PdfReaderBinding(),
    ),
    GetPage(
      name: _Paths.LAYANAN,
      page: () => const LayananView(),
      binding: LayananBinding(),
    ),
    GetPage(
      name: _Paths.KRITIK_SARAN,
      page: () => const KritikSaranView(),
      binding: KritikSaranBinding(),
    ),
    GetPage(
      name: _Paths.PENGAJUAN_BUKU,
      page: () => const PengajuanBukuView(),
      binding: PengajuanBukuBinding(),
    ),
    GetPage(
      name: _Paths.FAQ,
      page: () => const FaqView(),
      binding: FaqBinding(),
    ),
    GetPage(
      name: _Paths.CREATE_KRITIK_SARAN,
      page: () => const CreateKritikSaranView(),
      binding: CreateKritikSaranBinding(),
    ),
    GetPage(
      name: _Paths.EDIT_PROFILE,
      page: () => const EditProfileView(),
      binding: EditProfileBinding(),
    ),
    GetPage(
      name: _Paths.LAINNYA,
      page: () => const LainnyaView(),
      binding: LainnyaBinding(),
    ),
    GetPage(
      name: _Paths.KRITIK_SARAN_ADMIN,
      page: () => const KritikSaranAdminView(),
      binding: KritikSaranAdminBinding(),
    ),
    GetPage(
      name: _Paths.PENGAJUAN_BUKU_ADMIN,
      page: () => const PengajuanBukuAdminView(),
      binding: PengajuanBukuAdminBinding(),
    ),
    GetPage(
      name: _Paths.LIST_FAQ,
      page: () => const ListFaqView(),
      binding: ListFaqBinding(),
    ),
    GetPage(
      name: _Paths.CREATE_FAQ,
      page: () => const CreateFaqView(),
      binding: CreateFaqBinding(),
    ),
    GetPage(
      name: _Paths.UPDATE_FAQ,
      page: () => const UpdateFaqView(),
      binding: UpdateFaqBinding(),
    ),
    GetPage(
      name: _Paths.UPDATE_USER,
      page: () => const UpdateUserView(),
      binding: UpdateUserBinding(),
    ),
    GetPage(
      name: _Paths.SEWA_BUKU,
      page: () => const SewaBukuView(),
      binding: SewaBukuBinding(),
    ),
    GetPage(
      name: _Paths.SEWA_SUKSES,
      page: () => const SewaSuksesView(),
      binding: SewaSuksesBinding(),
    ),
    GetPage(
      name: _Paths.SEWA_DETAIL,
      page: () => const SewaDetailView(),
      binding: SewaDetailBinding(),
    ),
    GetPage(
      name: _Paths.DETAIL_HISTORY,
      page: () => const DetailHistoryView(),
      binding: DetailHistoryBinding(),
    ),
    GetPage(
      name: _Paths.SETTING,
      page: () => const SettingView(),
      binding: SettingBinding(),
    ),
    GetPage(
      name: _Paths.ABOUT,
      page: () => const AboutView(),
      binding: AboutBinding(),
    ),
    GetPage(
      name: _Paths.PENGAJUAN_BUKU_CREATE,
      page: () => const PengajuanBukuCreateView(),
      binding: PengajuanBukuCreateBinding(),
    ),
    GetPage(
      name: _Paths.PENGAJUAN_BUKU_UPDATE,
      page: () => const PengajuanBukuUpdateView(),
      binding: PengajuanBukuUpdateBinding(),
    ),
    GetPage(
      name: _Paths.SETTING_ADMIN,
      page: () => const SettingAdminView(),
      binding: SettingAdminBinding(),
    ),
    GetPage(
      name: _Paths.LIST_TESTIMONI,
      page: () => const ListTestimoniView(),
      binding: ListTestimoniBinding(),
    ),
  ];
}
