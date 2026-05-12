import 'package:flutter/material.dart';

class DetailBarangAdmin extends StatelessWidget {
  final Map<String, dynamic> item;

  const DetailBarangAdmin({super.key, required this.item});

  static const _blue = Color(0xFF3998FC);

  Color _conditionColor(String condition) {
    switch (condition.toLowerCase()) {
      case 'tersedia':
        return const Color(0xFF34C759);
      case 'dipinjam':
        return const Color(0xFF57D3C9);
      case 'rusak':
      case 'perlu perbaikan':
        return const Color(0xFFFE6F51);
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final name = item['name']?.toString() ?? '-';
    final categoryId = item['category_id']?.toString();
    final category = item['category_name']?.toString() ??
        item['category']?.toString() ??
        (categoryId != null ? 'ID: $categoryId' : '-');
    final stock = item['stock']?.toString() ?? '0';
    final condition = item['condition']?.toString() ?? 'Tersedia';
    final description = item['description']?.toString() ?? '-';
    final condColor = _conditionColor(condition);

    return Scaffold(
      backgroundColor: const Color(0xFFF2F4F7),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A1A1A),
        foregroundColor: Colors.white,
        title: const Text(
          'Detail Barang',
          style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings, color: Colors.grey),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Item header card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 4,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    width: 64,
                    height: 64,
                    decoration: BoxDecoration(
                      color: _blue.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.inventory_2_rounded,
                        color: _blue, size: 32),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          style: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1A1A1A),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          category,
                          style: const TextStyle(
                            fontSize: 13,
                            color: Color(0xFF888888),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: condColor.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                                color: condColor.withOpacity(0.4), width: 1),
                          ),
                          child: Text(
                            condition,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: condColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 12),

            // Info rows card
            _sectionCard(
              title: 'Informasi Barang',
              children: [
                _infoRow(Icons.inventory_2_outlined, 'Nama Barang', name),
                _divider(),
                _infoRow(Icons.category_outlined, 'Kategori', category),
                _divider(),
                _infoRow(Icons.layers_outlined, 'Stok', '$stock unit'),
                _divider(),
                _infoRow(Icons.info_outline, 'Kondisi', condition,
                    valueColor: condColor),
              ],
            ),

            const SizedBox(height: 12),

            // Description card
            _sectionCard(
              title: 'Deskripsi',
              children: [
                Text(
                  description.isEmpty ? '-' : description,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xFF444444),
                    height: 1.5,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            // Loan detail card (placeholder — no loans table)
            _sectionCard(
              title: 'Detail Peminjaman',
              children: [
                _infoRow(Icons.person_outline, 'Peminjam', '-'),
                _divider(),
                _infoRow(Icons.calendar_today_outlined, 'Tanggal Dipinjam', '-'),
                _divider(),
                _infoRow(Icons.event_available_outlined, 'Tanggal Kembali', '-'),
                _divider(),
                _infoRow(Icons.flag_outlined, 'Status Peminjaman', '-'),
              ],
            ),

            const SizedBox(height: 24),

            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () => Navigator.of(context).pop(),
                icon: const Icon(Icons.arrow_back, size: 18),
                label: const Text('Kembali'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: _blue,
                  side: const BorderSide(color: _blue),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
              ),
            ),

            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _sectionCard({required String title, required List<Widget> children}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1A1A1A),
            ),
          ),
          const SizedBox(height: 12),
          ...children,
        ],
      ),
    );
  }

  Widget _infoRow(IconData icon, String label, String value,
      {Color? valueColor}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, size: 18, color: const Color(0xFF888888)),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              label,
              style: const TextStyle(fontSize: 13, color: Color(0xFF666666)),
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: valueColor ?? const Color(0xFF1A1A1A),
            ),
          ),
        ],
      ),
    );
  }

  Widget _divider() => const Divider(height: 1, color: Color(0xFFEEEEEE));
}
