import 'package:flutter/material.dart';
import 'user_ui.dart';

class DetailPerbaikanUser extends StatelessWidget {
  const DetailPerbaikanUser({super.key});

  @override
  Widget build(BuildContext context) {
    return UserPageScaffold(
      title: 'Detail Perbaikan',
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
                  child: Icon(Icons.build_rounded, color: UserUi.primary),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Monitor', style: TextStyle(fontWeight: FontWeight.w900)),
                      SizedBox(height: 2),
                      Text('Laporan kerusakan', style: TextStyle(color: UserUi.textMuted, fontSize: 12)),
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
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text('Deskripsi', style: TextStyle(fontWeight: FontWeight.w900)),
                SizedBox(height: 8),
                Text(
                  'Layar berkedip dan ada garis. Mohon dicek.',
                  style: TextStyle(fontSize: 12, height: 1.25),
                ),
                SizedBox(height: 12),
                Text('Status', style: TextStyle(fontWeight: FontWeight.w900)),
                SizedBox(height: 8),
                Align(
                  alignment: Alignment.centerLeft,
                  child: UserChip(
                    text: 'Diproses',
                    background: Color(0xFFDEDEF9),
                    foreground: Color(0xFF329CFA),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

