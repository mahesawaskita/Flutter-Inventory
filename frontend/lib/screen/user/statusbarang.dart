import 'package:flutter/material.dart';

class StatusBarangUser extends StatefulWidget {
  @override
  State<StatusBarangUser> createState() => _StatusBarangUserState();
}

class _StatusBarangUserState extends State<StatusBarangUser> {
  String selectedFilter = 'Semua';

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
          'Status Barang',
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _StatusCard(
                    title: 'Sedang Dipinjam',
                    count: '5',
                    backgroundColor: const Color(0xFFE0E7FA),
                    icon: Icons.inventory_2,
                  ),
                  _StatusCard(
                    title: 'Telah Dikembalikan',
                    count: '7',
                    backgroundColor: const Color(0xFFE8F3EF),
                    icon: Icons.check_circle,
                  ),
                  _StatusCard(
                    title: 'Terlambat',
                    count: '2',
                    backgroundColor: const Color(0xFFFCE7E2),
                    icon: Icons.warning,
                  ),
                ],
              ),
              const SizedBox(height: 20),
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
                          hintText: 'Cari barang atau peminjam...',
                          hintStyle: TextStyle(
                            color: Color(0xFF7F7F7F),
                            fontSize: 12,
                            fontFamily: 'Poppins',
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.tune, color: Color(0xFF7F7F7F)),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: ['Semua', 'Sedang Dipinjam', 'Riwayat Perbaikan']
                      .map((filter) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: ChoiceChip(
                        label: Text(filter),
                        selected: selectedFilter == filter,
                        onSelected: (selected) {
                          setState(() {
                            selectedFilter = filter;
                          });
                        },
                        selectedColor: const Color(0xFF329CFA),
                        backgroundColor: Colors.grey[200],
                        labelStyle: TextStyle(
                          color: selectedFilter == filter
                              ? Colors.white
                              : Colors.black,
                          fontSize: 12,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(height: 20),
              _ItemListTile(
                itemName: 'Laptop',
                borrowerName: 'Bintang Audi',
                status: 'Dipinjam',
                statusColor: Colors.blue,
                date: 'Pinjam hingga 28 Maret 2024',
                image: 'assets/image/user/status barang/image 22.png',
                duration: '2 hari lagi',
              ),
              const SizedBox(height: 12),
              _ItemListTile(
                itemName: 'Mouse',
                borrowerName: 'Melissa Putri',
                status: 'Sudah Dikembalikan',
                statusColor: Colors.green,
                date: 'Di pinjam selama 14 Maret 2024',
                image: 'assets/image/user/status barang/image 30.png',
              ),
              const SizedBox(height: 12),
              _ItemListTile(
                itemName: 'Printer',
                borrowerName: 'Budi Agung',
                status: 'Sudah Dikembalikan',
                statusColor: Colors.green,
                date: 'Di pinjam selama 15 Feb 2024',
                image: 'assets/image/user/status barang/image 40.png',
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatusCard extends StatelessWidget {
  final String title;
  final String count;
  final Color backgroundColor;
  final IconData icon;

  const _StatusCard({
    required this.title,
    required this.count,
    required this.backgroundColor,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Text(
              count,
              style: const TextStyle(
                fontSize: 20,
                fontFamily: 'Outfit',
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 10,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ItemListTile extends StatelessWidget {
  final String itemName;
  final String borrowerName;
  final String status;
  final Color statusColor;
  final String date;
  final String image;
  final String? duration;

  const _ItemListTile({
    required this.itemName,
    required this.borrowerName,
    required this.status,
    required this.statusColor,
    required this.date,
    required this.image,
    this.duration,
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
                Text(
                  date,
                  style: const TextStyle(
                    fontSize: 11,
                    fontFamily: 'Poppins',
                    color: Colors.grey,
                  ),
                ),
                if (duration != null)
                  Text(
                    duration!,
                    style: const TextStyle(
                      fontSize: 10,
                      fontFamily: 'Poppins',
                      color: Colors.orange,
                      fontWeight: FontWeight.w600,
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
