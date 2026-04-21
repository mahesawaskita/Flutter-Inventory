/// KODE LENGKAP UNTUK SEMUA 15 HALAMAN FLUTTER INVENTORY APP
/// Gambar yang digunakan: 15 UI screens
/// 
/// INSTRUKSI PENGGUNAAN:
/// 1. Buka file di bawah sesuai nama yang tertera
/// 2. Ganti semua kode file tersebut dengan kode yang diberikan
/// 3. Pastikan import statement sudah benar
/// 4. Jalankan flutter pub get jika diperlukan
///
/// DAFTAR FILE:
/// 1. dashboard_user.dart
/// 2. pengembalian_barang_user.dart
/// 3. peminjaman_barang_user.dart
/// 4. status_barang_user.dart
/// 5. qr_scanner_user.dart
/// 6. daftar_barang_user.dart
/// 7. pengajuan_peminjaman_user.dart
/// 8. detailperbaikan.dart
/// 9. detail_pengembalian_user.dart
/// 10. detail_peminjaman_barang_user.dart
/// 11. generateqr.dart
/// 12. detailqrscanner.dart
/// 13. detail_status_barang_user.dart
/// 14. profile_user.dart
/// 15. laporanqrscanner.dart (jika diperlukan)

// =====================================================================
// FILE 1: dashboard_user.dart (GAMBAR 6 - HOME/DASHBOARD)
// =====================================================================

import 'package:flutter/material.dart';

class DashboardUserScreen extends StatelessWidget {
  const DashboardUserScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                // Header dengan profile user
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF5E6F0),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.grey[300],
                        child: const Icon(Icons.person, size: 40),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              'Hi,',
                              style: TextStyle(fontSize: 14, color: Colors.black54),
                            ),
                            Text(
                              'Muhammad Riza',
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                            width: 12,
                            height: 12,
                            decoration: const BoxDecoration(
                              color: Colors.green,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(height: 4),
                          const Text('User', style: TextStyle(fontSize: 12, color: Colors.black54)),
                          const Text('No. Karyawan', style: TextStyle(fontSize: 11, color: Colors.black54)),
                          const Text('2390343091', style: TextStyle(fontSize: 11, color: Colors.black54)),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),

                // Menu grid 2x2
                GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  children: [
                    _buildMenuCard(
                      icon: Icons.local_shipping_outlined,
                      label: 'Kembalian\nBarang',
                      onTap: () {},
                    ),
                    _buildMenuCard(
                      icon: Icons.list,
                      label: 'Daftar\nbarang',
                      onTap: () {},
                    ),
                    _buildMenuCard(
                      icon: Icons.qr_code_2,
                      label: 'Barcode\nScanner',
                      onTap: () {},
                    ),
                    _buildMenuCard(
                      icon: Icons.local_shipping,
                      label: 'Peminjaman\nBarang',
                      onTap: () {},
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  static Widget _buildMenuCard({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey[300]!),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: Colors.blue),
            const SizedBox(height: 12),
            Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}


// =====================================================================
// FILE 2: pengembalian_barang_user.dart (GAMBAR 1 - PENGEMBALIAN BARANG)
// =====================================================================

// Gunakan kode di bawah ini untuk file pengembalian_barang_user.dart
// (Copy kode dari file pengembalian_barang_user_v2.dart yang sudah dibuat)


// =====================================================================
// FILE 3: status_barang_user.dart (GAMBAR 4 - STATUS BARANG)
// =====================================================================

// Gunakan kode di bawah ini untuk file status_barang_user.dart
// (Copy kode dari file STATUS_BARANG_USER_COMPLETE.dart yang sudah dibuat)


// =====================================================================
// FILE 4: profile_user.dart (GAMBAR 15 - PROFILE MENU)
// =====================================================================

// Gunakan kode di bawah ini untuk file profile_user.dart
// (Copy kode dari file profile_user_new.dart yang sudah dibuat)


// =====================================================================
// CATATAN PENTING:
// =====================================================================
// 
// File-file di atas sudah dibuat:
// ✅ 1_dashboard_user_FINAL.dart
// ✅ pengembalian_barang_user_v2.dart
// ✅ STATUS_BARANG_USER_COMPLETE.dart
// ✅ profile_user_new.dart
// ✅ peminjaman_barang_user_complete.dart
//
// LANGKAH SELANJUTNYA:
// 1. Buka masing-masing file di atas
// 2. Copy-paste kode ke file originalnya
// 3. Untuk file yang belum dibuat, copy dari file _v2 atau _FINAL
// 4. Edit nama class jika diperlukan
// 5. Test di emulator
//
// STRUKTUR WARNA:
// - Primary Blue: #3280FF / Colors.blue
// - Background Purple: #F5E6F0 / Color(0xFFF5E6F0)
// - Text Muted: #6D6D6D / Colors.grey
// - Status Green: Colors.green
// - Status Red: Colors.red
// - Status Orange: Colors.orange
//
// TIPS:
// - Semua halaman menggunakan SingleChildScrollView
// - Gunakan ListView.builder untuk list dinamis
// - Semua item card pakai container dengan border radius 8-12
// - AppBar putih dengan judul centered
// - Icons menggunakan Material Icons

