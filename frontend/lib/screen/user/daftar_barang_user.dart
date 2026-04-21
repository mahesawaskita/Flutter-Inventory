import 'package:flutter/material.dart';

class DaftarBarangUserScreen extends StatefulWidget {
  const DaftarBarangUserScreen({Key? key}) : super(key: key);

  @override
  State<DaftarBarangUserScreen> createState() => _DaftarBarangUserScreenState();
}

class _DaftarBarangUserScreenState extends State<DaftarBarangUserScreen> {
  final List<Map<String, dynamic>> items = [
    {
      'name': 'Laptop',
      'brand': 'Bintang Audi',
      'status': 'Tersedia',
      'statusColor': Colors.green,
      'date': 'Batas Pengembalian 28 Maret 2024',
      'icon': 'assets/image/user/daftar barang/image 22.png',
    },
    {
      'name': 'Monitor',
      'brand': 'Melissa Putri',
      'status': 'Hampir Habis',
      'statusColor': Colors.orange,
      'date': '4 sisa',
      'icon': 'assets/image/user/daftar barang/image 30.png',
    },
    {
      'name': 'Printer',
      'brand': 'Budi Agung',
      'status': 'Tersedia',
      'statusColor': Colors.green,
      'date': '',
      'icon': 'assets/image/user/daftar barang/image 38.png',
    },
    {
      'name': 'Server',
      'brand': 'Putri Ayu',
      'status': 'Habis',
      'statusColor': Colors.red,
      'date': '0 trouble',
      'icon': 'assets/image/user/daftar barang/image 40.png',
    },
    {
      'name': 'Mouse',
      'brand': 'Ujang Lurah',
      'status': 'Hampir Habis',
      'statusColor': Colors.orange,
      'date': '3 sisa',
      'icon': 'assets/image/user/daftar barang/image 46.png',
    },
  ];

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
          'Daftar Barang',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Header Stats
              Row(
                children: [
                  _buildStatCard('225', 'Barang', Colors.blue[100]!),
                  const SizedBox(width: 12),
                  _buildStatCard('11', 'Barang', Colors.yellow[100]!),
                  const SizedBox(width: 12),
                  _buildStatCard('5', 'Barang', Colors.red[100]!),
                ],
              ),
              const SizedBox(height: 20),

              // Filter Tabs
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _buildFilterTab('Semua Barang', true),
                    const SizedBox(width: 8),
                    _buildFilterTab('Elektronik', false),
                    const SizedBox(width: 8),
                    _buildFilterTab('Deumana', false),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Search Bar
              TextField(
                decoration: InputDecoration(
                  hintText: 'Cari nama barang atau peminjam...',
                  prefixIcon: const Icon(Icons.search, color: Colors.grey),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.grey[300]!),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.grey[300]!),
                  ),
                  contentPadding: const EdgeInsets.symmetric(vertical: 12),
                ),
              ),
              const SizedBox(height: 20),

              // Items List
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final item = items[index];
                  return _buildItemCard(
                    icon: item['icon'],
                    name: item['name'],
                    brand: item['brand'],
                    status: item['status'],
                    statusColor: item['statusColor'],
                    subtext: item['date'],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatCard(String count, String label, Color bgColor) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            Text(
              count,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: const TextStyle(
                fontSize: 12,
                color: Colors.black54,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterTab(String label, bool isActive) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isActive ? Colors.blue : Colors.grey[200],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 12,
          color: isActive ? Colors.white : Colors.black,
          fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
  }

  Widget _buildItemCard({
    required String icon,
    required String name,
    required String brand,
    required String status,
    required Color statusColor,
    required String subtext,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Image.asset(
              icon,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  brand,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.black54,
                  ),
                ),
                if (subtext.isNotEmpty)
                  Text(
                    subtext,
                    style: const TextStyle(
                      fontSize: 11,
                      color: Colors.black54,
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: statusColor.withOpacity(0.2),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              status,
              style: TextStyle(
                fontSize: 11,
                color: statusColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 8),
          const Icon(Icons.chevron_right, color: Colors.grey),
        ],
      ),
    );
  }
}
