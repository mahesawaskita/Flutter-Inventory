import 'package:flutter/material.dart';
import 'package:lemigas/constants/app_assets.dart';
import 'package:lemigas/screen/admin/Profil.dart';

class AdminDashboard extends StatelessWidget {
  const AdminDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1E1E1E),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              
              // ===== HEADER (tap → profil) =====
              Material(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(16),
                clipBehavior: Clip.antiAlias,
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute<void>(
                        builder: (context) => const ProfilPage(),
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 28,
                          backgroundColor: Colors.grey,
                          child: ClipOval(
                            child: Image.asset(
                              AppAssets.dbnUser,
                              width: 56,
                              height: 56,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                'Hi,',
                                style: TextStyle(fontSize: 14),
                              ),
                              Text(
                                'Muhammad Riza',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Row(
                              children: const [
                                Icon(Icons.circle, color: Colors.green, size: 10),
                                SizedBox(width: 6),
                                Text('Admin'),
                              ],
                            ),
                            const SizedBox(height: 6),
                            const Text(
                              'No. Karyawan\n2390343091',
                              textAlign: TextAlign.right,
                              style: TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 30),

              // ===== TITLE =====
              const Text(
                "Menu Admin",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 20),

              // ===== MENU =====
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildMenuItem(
                    title: "Penambahan\nBarang",
                    assetPath: AppAssets.dashShoppingCart,
                  ),
                  _buildMenuItem(
                    title: "Daftar\nbarang",
                    assetPath: AppAssets.dashWishlist,
                  ),
                  _buildMenuItem(
                    title: "Status Barang",
                    assetPath: AppAssets.dashStatusBarang,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ===== WIDGET MENU ITEM =====
  Widget _buildMenuItem({required String title, required String assetPath}) {
    return Container(
      width: 100,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.3),
            blurRadius: 4,
            offset: const Offset(2, 3),
          )
        ],
      ),
      child: Column(
        children: [
          
          // ICON
          Container(
            height: 50,
            width: 50,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
            clipBehavior: Clip.antiAlias,
            child: Padding(
              padding: const EdgeInsets.all(6),
              child: Image.asset(assetPath, fit: BoxFit.contain),
            ),
          ),

          const SizedBox(height: 10),

          // TEXT
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          )
        ],
      ),
    );
  }
}