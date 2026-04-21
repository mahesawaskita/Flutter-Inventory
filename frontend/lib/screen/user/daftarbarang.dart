import 'package:flutter/material.dart';
import 'package:frontend/constants/user_assets.dart';

class DaftarBarangUser extends StatefulWidget {
  @override
  State<DaftarBarangUser> createState() => _DaftarBarangUserState();
}

class _DaftarBarangUserState extends State<DaftarBarangUser> {
  String selectedCategory = 'Semua';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Daftar Barang',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Category Filter
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _CategoryChip(
                      label: 'Semua Barang',
                      count: '225',
                      backgroundColor: const Color(0xFFE0E7FA),
                      isSelected: selectedCategory == 'Semua',
                      onTap: () => setState(() => selectedCategory = 'Semua'),
                    ),
                    const SizedBox(width: 8),
                    _CategoryChip(
                      label: 'Elektronik',
                      count: '11',
                      backgroundColor: const Color(0xFFFFF0DB),
                      isSelected: selectedCategory == 'Elektronik',
                      onTap: () => setState(() => selectedCategory = 'Elektronik'),
                    ),
                    const SizedBox(width: 8),
                    _CategoryChip(
                      label: 'Furniture',
                      count: '5',
                      backgroundColor: const Color(0xFFFCE7E2),
                      isSelected: selectedCategory == 'Furniture',
                      onTap: () => setState(() => selectedCategory = 'Furniture'),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              
              // Item List
              _ItemCard(
                itemName: 'Laptop',
                category: 'Elektronik',
                status: 'Tersedia',
                image: UserAssets.daftarImage22,
              ),
              const SizedBox(height: 12),
              _ItemCard(
                itemName: 'Monitor',
                category: 'Elektronik',
                status: 'Hampir Habis',
                image: UserAssets.daftarImage27,
              ),
              const SizedBox(height: 12),
              _ItemCard(
                itemName: 'Printer',
                category: 'Elektronik',
                status: 'Tersedia',
                image: UserAssets.daftarImage30,
              ),
              const SizedBox(height: 12),
              _ItemCard(
                itemName: 'Server',
                category: 'Elektronik',
                status: 'Habis',
                image: UserAssets.daftarImage38,
              ),
              const SizedBox(height: 12),
              _ItemCard(
                itemName: 'Mouse',
                category: 'Elektronik',
                status: 'Hampir Habis',
                image: UserAssets.daftarImage39,
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

class _CategoryChip extends StatelessWidget {
  final String label;
  final String count;
  final Color backgroundColor;
  final bool isSelected;
  final VoidCallback onTap;

  const _CategoryChip({
    required this.label,
    required this.count,
    required this.backgroundColor,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(20),
          border: isSelected ? Border.all(color: Colors.blue, width: 2) : null,
        ),
        child: Column(
          children: [
            Text(
              count,
              style: const TextStyle(
                fontSize: 16,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              label,
              style: const TextStyle(
                fontSize: 11,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ItemCard extends StatelessWidget {
  final String itemName;
  final String category;
  final String status;
  final String image;

  const _ItemCard({
    required this.itemName,
    required this.category,
    required this.status,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    Color getStatusColor() {
      if (status == 'Tersedia') return Colors.green;
      if (status == 'Hampir Habis') return Colors.orange;
      return Colors.red;
    }

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Row(
        children: [
          Image.asset(
            image,
            width: 70,
            height: 70,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                width: 70,
                height: 70,
                color: Colors.grey[200],
                child: const Icon(Icons.image),
              );
            },
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  itemName,
                  style: const TextStyle(
                    fontSize: 14,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  category,
                  style: const TextStyle(
                    fontSize: 12,
                    fontFamily: 'Poppins',
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: getStatusColor().withOpacity(0.2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              status,
              style: TextStyle(
                fontSize: 11,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
                color: getStatusColor(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
import ""package:flutter/material.dart"";

class DaftarBarangUser extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          ""Daftar Barang"",
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontFamily: ""Poppins"",
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Category Filter
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _CategoryChip(
                      label: ""Semua Barang"",
                      count: ""225"",
                      backgroundColor: const Color(0xFFE0E7FA),
                      isSelected: true,
                    ),
                    const SizedBox(width: 8),
                    _CategoryChip(
                      label: ""Elektronik"",
                      count: ""11"",
                      backgroundColor: const Color(0xFFFFF0DB),
                    ),
                    const SizedBox(width: 8),
                    _CategoryChip(
                      label: ""Furniture"",
                      count: ""5"",
                      backgroundColor: const Color(0xFFFCE7E2),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              
              // Item List
              _ItemCard(
                itemName: ""Laptop"",
                category: ""Elektronik"",
                status: ""Tersedia"",
                image: ""assets/image/user/daftar barang/image 22.png"",
              ),
              const SizedBox(height: 12),
              _ItemCard(
                itemName: ""Monitor"",
                category: ""Elektronik"",
                status: ""Hampir Habis"",
                image: ""assets/image/user/daftar barang/image 27.png"",
              ),
              const SizedBox(height: 12),
              _ItemCard(
                itemName: ""Printer"",
                category: ""Elektronik"",
                status: ""Tersedia"",
                image: ""assets/image/user/daftar barang/image 30.png"",
              ),
              const SizedBox(height: 12),
              _ItemCard(
                itemName: ""Server"",
                category: ""Elektronik"",
                status: ""Habis"",
                image: ""assets/image/user/daftar barang/image 38.png"",
              ),
              const SizedBox(height: 12),
              _ItemCard(
                itemName: ""Mouse"",
                category: ""Elektronik"",
                status: ""Hampir Habis"",
                image: ""assets/image/user/daftar barang/image 39.png"",
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

class _CategoryChip extends StatelessWidget {
  final String label;
  final String count;
  final Color backgroundColor;
  final bool isSelected;

  const _CategoryChip({
    required this.label,
    required this.count,
    required this.backgroundColor,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20),
        border: isSelected ? Border.all(color: Colors.blue, width: 2) : null,
      ),
      child: Column(
        children: [
          Text(
            count,
            style: const TextStyle(
              fontSize: 16,
              fontFamily: ""Poppins"",
              fontWeight: FontWeight.w700,
            ),
          ),
          Text(
            label,
            style: const TextStyle(
              fontSize: 11,
              fontFamily: ""Poppins"",
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class _ItemCard extends StatelessWidget {
  final String itemName;
  final String category;
  final String status;
  final String image;

  const _ItemCard({
    required this.itemName,
    required this.category,
    required this.status,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    Color getStatusColor() {
      if (status == ""Tersedia"") return Colors.green;
      if (status == ""Hampir Habis"") return Colors.orange;
      return Colors.red;
    }

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Row(
        children: [
          Image.asset(
            image,
            width: 70,
            height: 70,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                width: 70,
                height: 70,
                color: Colors.grey[200],
                child: const Icon(Icons.image),
              );
            },
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  itemName,
                  style: const TextStyle(
                    fontSize: 14,
                    fontFamily: ""Poppins"",
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  category,
                  style: const TextStyle(
                    fontSize: 12,
                    fontFamily: ""Poppins"",
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: getStatusColor().withOpacity(0.2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              status,
              style: TextStyle(
                fontSize: 11,
                fontFamily: ""Poppins"",
                fontWeight: FontWeight.w600,
                color: getStatusColor(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
