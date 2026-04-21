import 'package:flutter/material.dart';
import 'user_ui.dart';

class QrScannerUser extends StatelessWidget {
  const QrScannerUser({super.key});

  @override
  Widget build(BuildContext context) {
    return UserPageScaffold(
      title: 'QR Scanner',
      child: UserFramedPage(
        title: 'QR Scanner',
        topIcon: const Icon(Icons.qr_code_2_rounded),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _ScannerPreview(),
            const SizedBox(height: 10),
            _ItemHeader(),
            const SizedBox(height: 10),
            Row(
              children: const [
                Expanded(child: _TopTab(selected: true, text: 'Riwayat Peminjaman')),
                SizedBox(width: 10),
                Expanded(child: _TopTab(selected: false, text: 'Riwayat Perbaikan', trailing: '1')),
              ],
            ),
            const SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFFEAE1F0),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: UserUi.frameBorder.withValues(alpha: 0.35)),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      children: const [
                        Expanded(
                          child: Text('Riwayat Peminjaman', style: TextStyle(fontWeight: FontWeight.w900)),
                        ),
                        Icon(Icons.more_horiz_rounded),
                      ],
                    ),
                  ),
                  Container(height: 1, color: UserUi.frameBorder.withValues(alpha: 0.2)),
                  const _HistoryRow(
                    name: 'Bintang Audi',
                    date: 'Pinjam hingga 28 Maret 2024',
                    chipText: 'Sedang Dipinjam',
                    chipBg: Color(0xFFB0D8A6),
                  ),
                  const _HistoryRow(
                    name: 'Melissa Putri',
                    date: 'Di pinjam selama 14 Maret 2024',
                    chipText: 'Sudah Dikembalikan',
                    chipBg: Color(0xFFB0D8A6),
                  ),
                  const _HistoryRow(
                    name: 'Budi Agung',
                    date: 'Di pinjam selama 15 Feb 2024',
                    chipText: 'Sudah Dikembalikan',
                    chipBg: Color(0xFFB0D8A6),
                  ),
                  const SizedBox(height: 6),
                  Center(
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFE2DEEC),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('Lihat Selengkapnya', style: TextStyle(color: UserUi.primary, fontSize: 11)),
                          SizedBox(width: 6),
                          Icon(Icons.chevron_right_rounded, color: UserUi.primary, size: 18),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ScannerPreview extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
      decoration: BoxDecoration(
        color: const Color(0xFFD7D2DA),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: Container(
              width: 110,
              height: 110,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Icon(Icons.qr_code_rounded, size: 80),
            ),
          ),
          Positioned(
            right: 12,
            bottom: 12,
            child: Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: const Color(0xFF313B4A),
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 3),
              ),
              child: const Center(child: Icon(Icons.qr_code_rounded, color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }
}

class _ItemHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: const Color(0xFFF9F1FB), borderRadius: BorderRadius.circular(14)),
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
            child: const Icon(Icons.laptop_mac_rounded),
          ),
          const SizedBox(width: 10),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Laptop', style: TextStyle(fontWeight: FontWeight.w900)),
                Text('Bintang Audi', style: TextStyle(fontSize: 12)),
                SizedBox(height: 2),
                Text('Batas Pengembalian 28 Maret 2024  •  2 hari lagi', style: TextStyle(fontSize: 10, color: UserUi.textMuted)),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
            decoration: BoxDecoration(color: const Color(0xFFA9C5EC), borderRadius: BorderRadius.circular(14)),
            child: const Text('Kembalikan', style: TextStyle(color: Color(0xFF00599E), fontSize: 12, fontWeight: FontWeight.w700)),
          ),
        ],
      ),
    );
  }
}

class _TopTab extends StatelessWidget {
  const _TopTab({required this.selected, required this.text, this.trailing});

  final bool selected;
  final String text;
  final String? trailing;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 36,
      decoration: BoxDecoration(
        color: selected ? UserUi.primary : const Color(0xFFF4EED6),
        borderRadius: BorderRadius.circular(18),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            text,
            style: TextStyle(
              color: selected ? Colors.white : Colors.black,
              fontWeight: FontWeight.w700,
              fontSize: 12,
            ),
          ),
          if (trailing != null) ...[
            const SizedBox(width: 6),
            Text(trailing!, style: TextStyle(color: selected ? Colors.white : Colors.black, fontWeight: FontWeight.w900)),
            const SizedBox(width: 4),
            Icon(Icons.chevron_right_rounded, color: selected ? Colors.white : Colors.black, size: 18),
          ],
        ],
      ),
    );
  }
}

class _HistoryRow extends StatelessWidget {
  const _HistoryRow({
    required this.name,
    required this.date,
    required this.chipText,
    required this.chipBg,
  });

  final String name;
  final String date;
  final String chipText;
  final Color chipBg;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
      child: Row(
        children: [
          const CircleAvatar(radius: 18, backgroundColor: Colors.white, child: Icon(Icons.person_rounded, size: 18)),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: const TextStyle(fontWeight: FontWeight.w900)),
                Text(date, style: const TextStyle(fontSize: 10, color: UserUi.textMuted)),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(color: chipBg, borderRadius: BorderRadius.circular(12)),
            child: Text(chipText, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w700)),
          ),
        ],
      ),
    );
  }
}

