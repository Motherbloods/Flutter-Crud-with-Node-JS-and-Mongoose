# Aplikasi Manajemen Produk

Aplikasi ini terdiri dari dua bagian utama: server backend yang dibangun dengan Node.js, Express, dan MongoDB, serta aplikasi mobile yang dikembangkan dengan Flutter.

## Struktur Proyek

```
project_root/
│
├── server/
│   ├── app.js
│   ├── package.json
│   └── ...
│
└── formflutter/
    ├── lib/
    │   ├── main.dart
    │   ├── models/
    │   │   └── product.dart
    │   └── ui/
    │       ├── home_page.dart
    │       ├── product_page.dart
    │       ├── listproduct_page.dart
    │       ├── editproduct_page.dart
    │       └── edit_product_arguments.dart
    └── ...
```

## Server (Backend)

### Teknologi yang Digunakan
- Node.js
- Express.js
- MongoDB
- Mongoose

### Fitur
- API untuk membuat, membaca, memperbarui, dan menghapus produk
- Koneksi ke database MongoDB

### Cara Menjalankan Server

1. Pastikan MongoDB sudah terinstal dan berjalan di komputer Anda.
2. Buka terminal dan navigasikan ke folder `server`.
3. Jalankan perintah berikut:

```bash
npm install
node app.js
```

Server akan berjalan di `http://localhost:8000`.

## Aplikasi Flutter (Frontend)

### Teknologi yang Digunakan
- Flutter
- Dart
- HTTP package untuk koneksi ke API

### Fitur
- Halaman utama dengan opsi untuk membuat produk baru atau melihat daftar produk
- Formulir untuk membuat produk baru
- Daftar produk dengan opsi untuk mengedit atau menghapus produk
- Halaman edit produk

### Cara Menjalankan Aplikasi Flutter

1. Pastikan Flutter SDK sudah terinstal di komputer Anda.
2. Buka terminal dan navigasikan ke folder `formflutter`.
3. Jalankan perintah berikut:

```bash
flutter pub get
flutter run
```

Pastikan emulator atau perangkat fisik sudah terhubung sebelum menjalankan `flutter run`.

## Catatan Penting

- Pastikan untuk mengubah URL API di file-file Dart (`product_page.dart`, `listproduct_page.dart`, `editproduct_page.dart`) sesuai dengan alamat IP komputer Anda jika menjalankan server secara lokal.
- Aplikasi ini menggunakan koneksi langsung ke MongoDB. Untuk penggunaan produksi, disarankan untuk menambahkan lapisan keamanan tambahan.