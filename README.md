# 📚 Library App

Aplikasi peminjaman buku berbasis Flutter dengan fitur pencarian buku, kategori, koleksi, dan detail buku. Dibangun menggunakan Flutter, GetX, dan Firebase.

---
## 📝 Deskripsi Aplikasi
Library App adalah aplikasi mobile untuk:
- Melihat buku terbaru  
- Menjelajahi kategori buku  
- Melihat detail buku
- Melakukan peminjaman buku 
- Riwayat peminjaman 
- Mengelola data buku (admin)  
- Mengelola kategori buku (admin)  
- Mengelola riwayat peminjaman buku (admin)  
- Integrasi data dengan Firebase  

---
## 👥 Profil Kelompok

| Kelas | NIM | Nama | Username GitHub |
|------|------|------|------------------|
| RI-7A | 202210370311324 | Raka Adyatma Bimasakti | rakarajinibadah |
| RI-7A | 202210370311351 | Farid Anugraha | Srellica |
| RI-7D | 202210370311011 | Mohamad Raihan | Reeyyyh |
| RI-7D | 202210370311030 | Muhammad Arif Irfan | marifirfannn |

---
## 🎨 **Link Figma (Desain UI/UX)**
🔗 https://www.figma.com/design/iuzxcSUNA0KG80KBrCfyoF/perpustakaan?node-id=604-3604&t=YmIVhXjPpWetmwjg-1

---

### A. Fitur Pengguna (User)
1. **Melihat Buku Terbaru** – Menampilkan daftar buku terbaru beserta cover dan ringkasan singkat.  
2. **Pencarian Buku** – Mencari buku berdasarkan judul, penulis, atau ISBN.  
3. **Kategori Buku** – Menelusuri buku berdasarkan kategori.  
4. **Detail Buku** – Menampilkan informasi lengkap buku: judul, penulis, penerbit, ringkasan, stok.  
5. **Peminjaman Buku** – Melakukan peminjaman buku, memantau status, dan membatasi jumlah pinjaman.  
6. **Riwayat Peminjaman** – Melihat daftar buku yang dipinjam, status, dan tanggal pengembalian.  
7. **Profil Pengguna** – Mengelola data profil dan melihat riwayat peminjaman.  

### B. Fitur Admin
1. **Manajemen Buku** – Menambah, mengedit, dan menghapus buku; mengatur jumlah stok.  
2. **Manajemen Kategori Buku** – Menambah, mengedit, dan menghapus kategori buku.  
3. **Manajemen Riwayat Peminjaman** – Memantau seluruh riwayat peminjaman dan menandai status pengembalian.  
4. **Dashboard Admin** – Menampilkan statistik buku, kategori, dan peminjaman.  

### C. Integrasi Sistem
1. **Supabase** – Auth (email/password), Firestore untuk data buku, kategori, peminjaman, dan pengguna.  
2. **GetX** – State management, navigasi, dan dependency injection.  
3. **UI/UX** – Implementasi desain sesuai Figma.  

# Library App — GitHub Backlog

Anggota:
- @rakarajinibadah (Raka)
- @Srellica (Farid)
- @Reeyyyh (Raihan)
- @marifirfannn (Arif)

Milestone:
- Sprint 1: Setup + Auth + Home
- Sprint 2: Search + Category + Borrow
- Sprint 3: Admin CRUD + Borrow Admin
- Sprint 4: Dashboard + Security + Release

---

## Sprint 1 — Setup + Auth + Home (MVP dasar)

### 1) Setup proyek + arsitektur + base UI (EPIC)
**PIC:** @marifirfannn  
**Checklist:**
- [ ] Struktur folder (models, repos, services, controllers, views, routes, bindings, widgets)
- [ ] GetX routing + binding
- [ ] Theme + reusable components (Button/Input/Card/Badge)
- [ ] UI states: loading/empty/error
- [ ] README cara run + env

### 2) Supabase Auth (register/login/logout + session)
**PIC:** @Reeyyyh  
**Checklist:**
- [ ] AuthService (signUp/signIn/signOut/getSession)
- [ ] AuthController + state loading/error
- [ ] UI Login + Register + validation
- [ ] AuthGate / route guard
- [ ] Toast/snackbar error

### 3) Home: Buku Terbaru (list + skeleton + refresh)
**PIC:** @Srellica  
**Checklist:**
- [ ] UI list/grid card buku (cover, judul, penulis, ringkasan)
- [ ] BookController (fetch terbaru)
- [ ] Repo getLatestBooks
- [ ] Skeleton + empty state
- [ ] Klik item -> Detail Buku

### 4) Detail Buku (info lengkap + stok + tombol pinjam placeholder)
**PIC:** @marifirfannn  
**Checklist:**
- [ ] UI detail (judul, penulis, penerbit, ISBN, ringkasan, kategori, stok)
- [ ] Fetch by id (BookRepo.getById)
- [ ] Badge stok (available/out)
- [ ] Tombol Pinjam (sementara siap sambung ke Sprint 2)

---

## Sprint 2 — Search + Category + Borrow (Core user features)

### 5) Search buku (judul/penulis/ISBN + debounce)
**PIC:** @Reeyyyh  
**Checklist:**
- [ ] SearchController (debounce 400–600ms)
- [ ] Repo query search (contains/ilike)
- [ ] UI search + results + empty/error
- [ ] Klik hasil -> Detail Buku

### 6) Kategori (list kategori + buku per kategori)
**PIC:** @Srellica  
**Checklist:**
- [ ] CategoryRepo (getAll, getBooksByCategory)
- [ ] CategoryController
- [ ] UI: CategoryListPage
- [ ] UI: CategoryBooksPage

### 7) Peminjaman buku (create borrow + kurangi stok + limit)
**PIC:** @rakarajinibadah  
**Rules:**
- Max pinjaman aktif: 3
- Tidak boleh pinjam buku sama kalau masih borrowed
- Stok harus > 0
**Checklist:**
- [ ] Schema borrow: user_id, book_id, borrow_date, due_date, return_date, status
- [ ] BorrowRepo.createBorrow()
- [ ] Update stok buku (aman/atomic jika bisa)
- [ ] Validasi limit + duplicate borrowed
- [ ] UI konfirmasi pinjam + loading/error

### 8) Riwayat peminjaman user (aktif/selesai + badge status)
**PIC:** @marifirfannn  
**Checklist:**
- [ ] BorrowRepo.getByUser()
- [ ] UI tabs: Aktif / Selesai
- [ ] Tanggal pinjam/jatuh tempo/status + late label
- [ ] Loading/empty/error state

### 9) Profil user (lihat + edit basic)
**PIC:** @Srellica  
**Checklist:**
- [ ] ProfileRepo (get/update)
- [ ] UI profil (nama, email, dll)
- [ ] Form edit + validation
- [ ] Ringkasan pinjaman (optional)

---

## Sprint 3 — Admin CRUD + Borrow Admin

### 10) Role admin + guard menu
**PIC:** @Reeyyyh  
**Checklist:**
- [ ] Role admin dari profile (role=admin)
- [ ] Admin route guard
- [ ] Menu admin hanya muncul untuk admin

### 11) Admin CRUD Buku + stok
**PIC:** @rakarajinibadah  
**Checklist:**
- [ ] Admin list buku + search
- [ ] Tambah/Edit/Hapus buku
- [ ] Update stok (>=0)
- [ ] Validasi ISBN unique (jika dipakai)

### 12) Admin CRUD Kategori
**PIC:** @Srellica  
**Checklist:**
- [ ] List kategori
- [ ] Tambah/Edit/Hapus kategori
- [ ] Warning kalau kategori masih dipakai

### 13) Admin riwayat peminjaman + return
**PIC:** @marifirfannn  
**Checklist:**
- [ ] Admin lihat semua borrow + filter status
- [ ] Tombol Return -> status returned + return_date
- [ ] Stok buku bertambah 1 saat return

---

## Sprint 4 — Dashboard + Security + Release

### 14) Admin Dashboard (statistik)
**PIC:** @rakarajinibadah  
**Checklist:**
- [ ] Total buku, total kategori, borrow aktif, borrow terlambat
- [ ] UI cards rapi

### 15) Security (RLS/Rules)
**PIC:** @Reeyyyh  
**Checklist:**
- [ ] User hanya akses borrow miliknya
- [ ] Admin akses semua
- [ ] User tidak bisa ubah stok buku
- [ ] Test policy pakai akun user & admin

### 16) Testing + Release
**PIC:** @marifirfannn  
**Checklist:**
- [ ] Minimal unit test: borrow limit logic / mapper
- [ ] Build APK release (dan web build jika perlu)
- [ ] Update README cara build

---

## Definition of Done (DoD)
- [ ] Sesuai checklist fitur
- [ ] Tidak crash (basic QA)
- [ ] Ada loading/empty/error state
- [ ] Sudah merge ke main




