import 'package:flutter/material.dart';
import 'package:frontend/constants/user_assets.dart';

class PeminjamanBarangUser extends StatefulWidget {
  @override
  State<PeminjamanBarangUser> createState() => _PeminjamanBarangUserState();
}

class _PeminjamanBarangUserState extends State<PeminjamanBarangUser> {
  String selectedTab = 'Sedang Dipinjam';

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
          'Peminjaman Barang',
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
              // Tab buttons
              Row(
                children: [
                  Expanded(
                    child: _TabButton(
                      label: 'Sedang Dipinjam',
                      isActive: selectedTab == 'Sedang Dipinjam',
                      onTap: () => setState(() => selectedTab = 'Sedang Dipinjam'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _TabButton(
                      label: 'Riwayat Perbaikan',
                      isActive: selectedTab == 'Riwayat Perbaikan',
                      onTap: () => setState(() => selectedTab = 'Riwayat Perbaikan'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              
              // Search
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: const Color(0xFFF7EDF8),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.search, color: Color(0xFF7F7F7F)),
                    const SizedBox(width: 8),
                    const Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Cari barang yang hendak dikembalikan...',
                          hintStyle: TextStyle(
                            color: Color(0xFF7F7F7F),
                            fontSize: 12,
                            fontFamily: 'Poppins',
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              
              // Item list based on tab
              if (selectedTab == 'Sedang Dipinjam') ...[
                _BorrowingCard(
                  itemName: 'Laptop',
                  borrowerName: 'Bintang Audi',
                  borrowDate: '24 Maret 2024',
                  returnDate: '1 Mei 2024',
                  status: 'Sedang Dipinjam',
                  statusColor: Colors.blue,
                  image: UserAssets.peminjamanImage22,
                ),
                const SizedBox(height: 12),
                _BorrowingCard(
                  itemName: 'Mouse',
                  borrowerName: 'Melissa Putri',
                  borrowDate: '27 Maret 2024',
                  returnDate: '27 Maret 2024',
                  status: 'Sudah Dikembalikan',
                  statusColor: Colors.green,
                  image: UserAssets.peminjamanImage23,
                ),
              ] else ...[
                _RepairCard(
                  itemName: 'Printer',
                  status: 'Sedang Dalam Perbaikan',
                  statusColor: Colors.orange,
                  repairDate: '25 Maret 2024',
                  image: UserAssets.peminjamanImage24,
                ),
                const SizedBox(height: 12),
                _RepairCard(
                  itemName: 'Monitor',
                  status: 'Sudah Diperbaiki',
                  statusColor: Colors.green,
                  repairDate: '22 Maret 2024',
                  image: UserAssets.peminjamanImage25,
                ),
              ],
              
              const SizedBox(height: 20),
              
              // Info box
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF3CD),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.info, color: Colors.orange),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Ajukan peminjaman melalui tombol di bawah',
                        style: TextStyle(
                          fontSize: 12,
                          fontFamily: 'Poppins',
                          color: Colors.orange[900],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              
              // Action button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF329CFA),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Ajukan Peminjaman',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
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
}

class _TabButton extends StatelessWidget {
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _TabButton({
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: isActive ? const Color(0xFF329CFA) : Colors.grey[200],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              color: isActive ? Colors.white : Colors.black,
              fontSize: 12,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}

class _BorrowingCard extends StatelessWidget {
  final String itemName;
  final String borrowerName;
  final String borrowDate;
  final String returnDate;
  final String status;
  final Color statusColor;
  final String image;

  const _BorrowingCard({
    required this.itemName,
    required this.borrowerName,
    required this.borrowDate,
    required this.returnDate,
    required this.status,
    required this.statusColor,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
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
            width: 60,
            height: 60,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                width: 60,
                height: 60,
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
                  borrowerName,
                  style: const TextStyle(
                    fontSize: 12,
                    fontFamily: 'Poppins',
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(Icons.date_range, size: 12, color: Colors.grey[600]),
                    const SizedBox(width: 4),
                    Text(
                      '$borrowDate - $returnDate',
                      style: TextStyle(
                        fontSize: 10,
                        fontFamily: 'Poppins',
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: statusColor.withOpacity(0.2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              status,
              style: TextStyle(
                fontSize: 10,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
                color: statusColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _RepairCard extends StatelessWidget {
  final String itemName;
  final String status;
  final Color statusColor;
  final String repairDate;
  final String image;

  const _RepairCard({
    required this.itemName,
    required this.status,
    required this.statusColor,
    required this.repairDate,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
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
            width: 60,
            height: 60,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                width: 60,
                height: 60,
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
                  repairDate,
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
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: statusColor.withOpacity(0.2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              status,
              style: TextStyle(
                fontSize: 10,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
                color: statusColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
import 'package:flutter/material.dart';

class PeminjamanBarangUser extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 414,
          height: 896,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(color: Colors.white),
          child: Stack(
            children: [
              Positioned(
                left: 12,
                top: 132,
                child: Container(
                  width: 389,
                  height: 633,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFEDE2F0),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 3,
                        color: const Color(0xFFAC9BAB),
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 159,
                top: 92,
                child: Container(
                  width: 95,
                  height: 75,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFFBF0F8),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 3,
                        color: const Color(0xFFAC9BAB),
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 28,
                top: 212,
                child: Container(
                  width: 357,
                  height: 27,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFF7EDF8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 27,
                top: 248,
                child: Container(
                  width: 357,
                  height: 33,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFFAF0F8),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                  ),
                ),
              ),
              Positioned(
                left: 27,
                top: 287,
                child: Container(
                  width: 357,
                  height: 119,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFFAF0F7),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 28,
                top: 563,
                child: Opacity(
                  opacity: 0.50,
                  child: Container(
                    width: 357,
                    height: 190,
                    decoration: ShapeDecoration(
                      color: const Color(0xFFFBF1F9),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 27,
                top: 412,
                child: Container(
                  width: 357,
                  height: 86,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFFAF0F8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 24,
                top: 503,
                child: Container(
                  width: 360,
                  height: 54,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFF8EEF7),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                ),
              ),
              Positioned(
                left: 96,
                top: 512,
                child: Container(
                  width: 219,
                  height: 35,
                  decoration: ShapeDecoration(
                    color: const Color(0xFF329CFA),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 34,
                top: 593,
                child: Container(
                  width: 344,
                  height: 26,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFD9D9D9),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 293,
                top: 595,
                child: Container(
                  width: 82,
                  height: 21,
                  decoration: ShapeDecoration(
                    color: const Color(0xFF329CFA),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 247,
                top: 630,
                child: Container(
                  width: 131,
                  height: 21,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFDEDEF9),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 177,
                top: 336,
                child: Container(
                  width: 203,
                  height: 21,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFEDE6F5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 247,
                top: 675,
                child: Container(
                  width: 131,
                  height: 23,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFDEDEF9),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 124,
                top: 725,
                child: Container(
                  width: 163,
                  height: 23,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFE4D9E7),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 288,
                top: 593,
                child: Container(
                  transform: Matrix4.identity()..translate(0.0, 0.0)..rotateZ(1.57),
                  width: 26,
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 1,
                        strokeAlign: BorderSide.strokeAlignCenter,
                        color: const Color(0xFFF3E9F0),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 181,
                top: 593,
                child: Container(
                  transform: Matrix4.identity()..translate(0.0, 0.0)..rotateZ(1.57),
                  width: 26,
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 1,
                        strokeAlign: BorderSide.strokeAlignCenter,
                        color: const Color(0xFFEDE2EA),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 38,
                top: 629,
                child: Container(
                  width: 34,
                  height: 32,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFD9D9D9),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                  ),
                ),
              ),
              Positioned(
                left: 39,
                top: 677,
                child: Container(
                  width: 34,
                  height: 32,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFD9D9D9),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                  ),
                ),
              ),
              Positioned(
                left: 28,
                top: 327,
                child: Container(
                  width: 356,
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 1,
                        strokeAlign: BorderSide.strokeAlignCenter,
                        color: const Color(0xFFE9DEE6),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 28,
                top: 366,
                child: Container(
                  width: 356,
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 1,
                        strokeAlign: BorderSide.strokeAlignCenter,
                        color: const Color(0xFFE9DEE6),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 59.80,
                top: 91.75,
                child: Container(
                  transform: Matrix4.identity()..translate(0.0, 0.0)..rotateZ(3.11),
                  width: 32.77,
                  height: 32.77,
                  child: Stack(),
                ),
              ),
              Positioned(
                left: 173,
                top: 95,
                child: Container(
                  width: 67,
                  height: 70,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(),
                  child: Stack(),
                ),
              ),
              Positioned(
                left: 95,
                top: 172,
                child: SizedBox(
                  width: 224,
                  height: 29,
                  child: Text(
                    'Peminjaman Barang',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontFamily: 'Paytone One',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 35,
                top: 217,
                child: Container(
                  width: 18,
                  height: 17,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(),
                  child: Stack(),
                ),
              ),
              Positioned(
                left: 30,
                top: 295,
                child: Container(
                  width: 30,
                  height: 25,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage("https://placehold.co/30x25"),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 33,
                top: 335,
                child: Container(
                  width: 27,
                  height: 24,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage("https://placehold.co/27x24"),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 182,
                top: 339,
                child: Container(
                  width: 19,
                  height: 17,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage("https://placehold.co/19x17"),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 34,
                top: 375,
                child: Container(
                  width: 26,
                  height: 24,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage("https://placehold.co/26x24"),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 34,
                top: 416,
                child: Container(
                  width: 24,
                  height: 26,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage("https://placehold.co/24x26"),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 139,
                top: 542,
                child: Container(
                  transform: Matrix4.identity()..translate(0.0, 0.0)..rotateZ(3.14),
                  width: 23,
                  height: 23,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage("https://placehold.co/23x23"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 39,
                top: 677,
                child: Container(
                  width: 34,
                  height: 34,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage("https://placehold.co/34x34"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 40,
                top: 668.50,
                child: Container(
                  width: 338,
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 1,
                        strokeAlign: BorderSide.strokeAlignCenter,
                        color: const Color(0xFFAC9BAB),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 55,
                top: 219,
                child: SizedBox(
                  width: 190,
                  height: 23,
                  child: Text(
                    'Cari barang yang ingin dipinjam... ',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: const Color(0xFF7F7F7F),
                      fontSize: 11,
                      fontFamily: 'Phetsarath',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 62,
                top: 257,
                child: SizedBox(
                  width: 104,
                  height: 32,
                  child: Text(
                    'Nama Peminjam',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 11,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 62,
                top: 291,
                child: SizedBox(
                  width: 132,
                  height: 32,
                  child: Text(
                    'Barang yang Dipinjam',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 11,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 62,
                top: 307,
                child: SizedBox(
                  width: 132,
                  height: 32,
                  child: Text(
                    'Laptop',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 11,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 365,
                top: 290,
                child: SizedBox(
                  width: 5,
                  height: 32,
                  child: Text(
                    '>',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 365,
                top: 247,
                child: SizedBox(
                  width: 5,
                  height: 32,
                  child: Text(
                    '>',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 365,
                top: 367,
                child: SizedBox(
                  width: 5,
                  height: 32,
                  child: Text(
                    '>',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 258,
                top: 719,
                child: SizedBox(
                  width: 5,
                  height: 32,
                  child: Text(
                    '>',
                    style: TextStyle(
                      color: const Color(0xFF329CFA),
                      fontSize: 24,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 202,
                top: 339,
                child: SizedBox(
                  width: 132,
                  height: 32,
                  child: Text(
                    '26 Maret 2024',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 11,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 77,
                top: 649,
                child: SizedBox(
                  width: 132,
                  height: 32,
                  child: Text(
                    '17 - 19 Apr 2024',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 11,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 256,
                top: 632,
                child: SizedBox(
                  width: 132,
                  height: 32,
                  child: Text(
                    'Sudah Dikembalikan',
                    style: TextStyle(
                      color: const Color(0xFF329CFA),
                      fontSize: 11,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 256,
                top: 678,
                child: SizedBox(
                  width: 132,
                  height: 32,
                  child: Text(
                    'Sudah Dikembalikan',
                    style: TextStyle(
                      color: const Color(0xFF329CFA),
                      fontSize: 11,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 145,
                top: 728,
                child: SizedBox(
                  width: 132,
                  height: 32,
                  child: Text(
                    'Lihat Selengkapnya',
                    style: TextStyle(
                      color: const Color(0xFF329CFA),
                      fontSize: 11,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 77,
                top: 697,
                child: SizedBox(
                  width: 132,
                  height: 32,
                  child: Text(
                    '05 - 08 Apr 2024',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 11,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 299,
                top: 339,
                child: SizedBox(
                  width: 132,
                  height: 32,
                  child: Text(
                    '28 Maret 2024',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 11,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 62,
                top: 386,
                child: SizedBox(
                  width: 149,
                  height: 32,
                  child: Text(
                    'Mengerjakan tugas kantor',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 11,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 36,
                top: 443,
                child: SizedBox(
                  width: 325,
                  height: 55,
                  child: Text(
                    'Barang hanya boleh dipinjam untuk keperluan kantor.\nBatas waktu peminjaman maksimal 3 hari.\nKeterlambatan pengembalian akan dikenakan sanksi.',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 11,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 44,
                top: 597,
                child: SizedBox(
                  width: 149,
                  height: 32,
                  child: Text(
                    'Menunggu Persetujuan',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 11,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 188,
                top: 597,
                child: SizedBox(
                  width: 149,
                  height: 32,
                  child: Text(
                    'Sedang Dipinjam',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 11,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 313,
                top: 597,
                child: SizedBox(
                  width: 149,
                  height: 32,
                  child: Text(
                    'Riwayat',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 11,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 62,
                top: 339,
                child: SizedBox(
                  width: 132,
                  height: 32,
                  child: Text(
                    'Waktu Peminjaman',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 11,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 62,
                top: 371,
                child: SizedBox(
                  width: 132,
                  height: 32,
                  child: Text(
                    'Keperluan',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 11,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 64,
                top: 421,
                child: SizedBox(
                  width: 156,
                  height: 32,
                  child: Text(
                    'Peraturan Peminjaman',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 39,
                top: 568,
                child: SizedBox(
                  width: 184,
                  height: 32,
                  child: Text(
                    'Riwayat Peminjaman Saya',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 13,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 143,
                top: 519,
                child: SizedBox(
                  width: 184,
                  height: 32,
                  child: Text(
                    'Ajukan Peminjaman',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 77,
                top: 629,
                child: SizedBox(
                  width: 184,
                  height: 32,
                  child: Text(
                    'Mouse',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 13,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 77,
                top: 677,
                child: SizedBox(
                  width: 184,
                  height: 32,
                  child: Text(
                    'Projector',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 13,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 40,
                top: 629,
                child: Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage("https://placehold.co/32x32"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 33,
                top: 252,
                child: Container(
                  width: 25,
                  height: 25,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage("https://placehold.co/25x25"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}