import 'package:flutter/material.dart';
import 'user_ui.dart';

class DetailQrScannerUser extends StatelessWidget {
  const DetailQrScannerUser({super.key});

  @override
  Widget build(BuildContext context) {
    return UserPageScaffold(
      title: 'Detail QR',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            height: 200,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: UserUi.border, width: 2),
            ),
            child: const Center(
              child: Icon(Icons.qr_code_rounded, size: 120, color: UserUi.textMuted),
            ),
          ),
          const SizedBox(height: 12),
          Container(
            decoration: BoxDecoration(color: UserUi.card, borderRadius: BorderRadius.circular(14)),
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: const [
                Text('Hasil Scan', style: TextStyle(fontWeight: FontWeight.w900)),
                SizedBox(height: 8),
                _Row(label: 'Nama Barang', value: 'Laptop'),
                _Row(label: 'Pemilik', value: 'Bintang Audi'),
                _Row(label: 'Status', value: 'Dipinjam'),
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
              child: const Text('Lanjut', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800)),
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
          Text(value, style: const TextStyle(fontSize: 12, color: UserUi.textMuted)),
        ],
      ),
    );
  }
}

