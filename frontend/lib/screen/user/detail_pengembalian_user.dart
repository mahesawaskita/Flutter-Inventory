import 'package:flutter/material.dart';

class DetailPengembalianBarangUserScreen extends StatefulWidget {
  const DetailPengembalianBarangUserScreen({Key? key}) : super(key: key);

  @override
  State<DetailPengembalianBarangUserScreen> createState() =>
      _DetailPengembalianBarangUserScreenState();
}

class _DetailPengembalianBarangUserScreenState
    extends State<DetailPengembalianBarangUserScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Detail Pengembalian Barang',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Rental Status Tabs
              Row(
                children: [
                  _buildStatusTab('Riwayat Peminjaman', true),
                  const SizedBox(width: 12),
                  _buildStatusTab('Riwayat Perbaikan', false),
                ],
              ),
              const SizedBox(height: 24),

              // Item Card
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Image.asset(
                        'assets/image/user/detail pengembalian barang/image 22.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Laptop',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Text(
                            'Bintang Audi',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Borrowing Info
              const Text(
                'Informasi Peminjaman',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),

              _buildInfoBox(
                'Barang yang Dikembalikan',
                'Laptop',
                Colors.blue[50]!,
              ),
              const SizedBox(height: 12),

              _buildInfoBox(
                'Tanggal Peminjaman',
                '24 Maret 2024',
                Colors.blue[50]!,
              ),
              const SizedBox(height: 12),

              _buildInfoBox(
                'Tanggal Kembali',
                '1 Mei 2024',
                Colors.blue[50]!,
              ),
              const SizedBox(height: 12),

              _buildInfoBox(
                'Tanggal Pengembalian',
                '29 April 2024',
                Colors.blue[50]!,
              ),
              const SizedBox(height: 24),

              // Photo Section
              const Text(
                'Foto Barang',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey[300]!),
                ),
                child: Image.asset(
                  'assets/image/user/detail pengembalian barang/image 74.png',
                  fit: BoxFit.cover,
                  height: 120,
                ),
              ),
              const SizedBox(height: 24),

              // Confirm Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // Confirm return
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Konfirmasi',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatusTab(String label, bool isActive) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: isActive ? Colors.amber[100] : Colors.transparent,
          borderRadius: BorderRadius.circular(6),
          border: isActive
              ? Border.all(color: Colors.amber[300]!)
              : Border.all(color: Colors.grey[300]!),
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: isActive ? Colors.black : Colors.black54,
          ),
        ),
      ),
    );
  }

  Widget _buildInfoBox(String label, String value, Color bgColor) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.black54,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
