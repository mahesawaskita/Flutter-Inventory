import 'package:flutter/material.dart';
import 'user_ui.dart';

class DetailPeminjamanBarangUser extends StatelessWidget {
  const DetailPeminjamanBarangUser({super.key});

  @override
  Widget build(BuildContext context) {
    return UserPageScaffold(
      title: 'Detail Peminjaman',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
            padding: const EdgeInsets.all(12),
            child: Row(
              children: const [
                CircleAvatar(
                  radius: 26,
                  backgroundColor: Color(0xFFFAF0F8),
                  child: Icon(Icons.assignment_outlined, color: UserUi.primary),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Laptop', style: TextStyle(fontWeight: FontWeight.w900)),
                      SizedBox(height: 2),
                      Text('Muhammad Riza', style: TextStyle(color: UserUi.textMuted, fontSize: 12)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Container(
            decoration: BoxDecoration(color: UserUi.card, borderRadius: BorderRadius.circular(14)),
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: const [
                Text('Detail', style: TextStyle(fontWeight: FontWeight.w900)),
                SizedBox(height: 8),
                _Row(label: 'Tanggal pinjam', value: '26 Maret 2024'),
                _Row(label: 'Batas kembali', value: '28 Maret 2024'),
                _Row(label: 'Keperluan', value: 'Mengerjakan tugas kantor'),
              ],
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 44,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: UserUi.primary,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
              ),
              onPressed: () {},
              child: const Text('Kembali', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800)),
            ),
          ),
        ],
      ),
    );
  }
}

class _Row extends StatelessWidget {
  const _Row({required this.label, required this.value});
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Expanded(child: Text(label, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 12))),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: const TextStyle(fontSize: 12, color: UserUi.textMuted),
            ),
          ),
        ],
      ),
    );
  }
}

