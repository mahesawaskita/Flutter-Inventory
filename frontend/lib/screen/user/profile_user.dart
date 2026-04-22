import 'package:flutter/material.dart';

import 'user_ui.dart';

class ProfileUserScreen extends StatefulWidget {
  const ProfileUserScreen({super.key});

  @override
  State<ProfileUserScreen> createState() => _ProfileUserScreenState();
}

class _ProfileUserScreenState extends State<ProfileUserScreen> {
  @override
  Widget build(BuildContext context) {
    final menus = <({IconData icon, String title})>[
      (icon: Icons.badge_rounded, title: 'Data\nPribadi'),
      (icon: Icons.lock_rounded, title: 'Data\nPassword'),
      (icon: Icons.history_toggle_off_rounded, title: 'Riwayat\nAktivitas'),
      (icon: Icons.logout_rounded, title: 'Logout'),
    ];

    return UserPageScaffold(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: UserUi.card,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Row(
              children: [
                Container(
                  width: 62,
                  height: 62,
                  decoration: const BoxDecoration(
                    color: Color(0xFFDFE2EC),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.person, size: 42, color: Color(0xFF5C678A)),
                ),
                const SizedBox(width: 14),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Muhammad Riza', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900)),
                      SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(Icons.circle, size: 9, color: Color(0xFF17E700)),
                          SizedBox(width: 8),
                          Text('User', style: TextStyle(fontSize: 13)),
                        ],
                      ),
                      SizedBox(height: 4),
                      Text('No. 2390343091', style: TextStyle(fontSize: 13, fontStyle: FontStyle.italic)),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: const Color(0xFFDAD5DE),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text('Edit Profil', style: TextStyle(fontStyle: FontStyle.italic)),
                ),
              ],
            ),
          ),
          const SizedBox(height: 58),
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: UserUi.card,
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text('Menu Profil', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900)),
                SizedBox(height: 16),
                _ProfileLine(label: 'Email', value: 'production@gmail.com'),
                SizedBox(height: 12),
                _ProfileLine(label: 'No. Telepon', value: '+62 858 2563'),
                SizedBox(height: 12),
                _ProfileLine(label: 'Jabatan', value: 'Staff Gudang'),
                SizedBox(height: 12),
                _ProfileLine(label: 'Bergabung Sejak', value: '2024'),
              ],
            ),
          ),
          const SizedBox(height: 72),
          Wrap(
            spacing: 16,
            runSpacing: 16,
            children: menus.map((menu) {
              return Container(
                width: (MediaQuery.of(context).size.width - 40) / 2,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                decoration: BoxDecoration(
                  color: UserUi.card,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 54,
                      height: 42,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(.6),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(menu.icon, size: 28, color: const Color(0xFF6099E9)),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Text(
                        menu.title,
                        style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w900),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

class _ProfileLine extends StatelessWidget {
  const _ProfileLine({
    required this.label,
    required this.value,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(label, style: const TextStyle(fontSize: 15, fontStyle: FontStyle.italic)),
        ),
        Expanded(
          child: Text(
            value,
            textAlign: TextAlign.right,
            style: const TextStyle(fontSize: 15, fontStyle: FontStyle.italic),
          ),
        ),
      ],
    );
  }
}
