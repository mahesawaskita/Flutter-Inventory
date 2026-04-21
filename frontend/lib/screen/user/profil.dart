import 'package:flutter/material.dart';
import 'user_ui.dart';

class ProfilUser extends StatelessWidget {
  const ProfilUser({super.key});

  @override
  Widget build(BuildContext context) {
    return UserPageScaffold(
      title: 'Profil',
      showBack: false,
      actions: [
        TextButton(
          onPressed: () {},
          child: const Text('Edit Profil'),
        ),
      ],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _ProfileHeader(
            name: 'Muhammad Riza',
            employeeNo: '2390343091',
            email: 'production@gmail.com',
            phone: '+62 858 2563',
            role: 'User',
            joined: '2024',
            jobTitle: 'Staff Gudang',
          ),
          const SizedBox(height: 14),
          const Text('Menu Profil', style: TextStyle(fontWeight: FontWeight.w800)),
          const SizedBox(height: 10),
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 2.6,
            children: [
              _MenuCard(icon: Icons.badge_outlined, title: 'Data\nPribadi', onTap: () {}),
              _MenuCard(icon: Icons.lock_outline_rounded, title: 'Data\nPassword', onTap: () {}),
              _MenuCard(icon: Icons.history_rounded, title: 'Riwayat\nAktivitas', onTap: () {}),
              _MenuCard(icon: Icons.logout_rounded, title: 'Logout', onTap: () {}),
            ],
          ),
        ],
      ),
    );
  }
}

class _ProfileHeader extends StatelessWidget {
  const _ProfileHeader({
    required this.name,
    required this.employeeNo,
    required this.email,
    required this.phone,
    required this.role,
    required this.joined,
    required this.jobTitle,
  });

  final String name;
  final String employeeNo;
  final String email;
  final String phone;
  final String role;
  final String joined;
  final String jobTitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFFDF3FB),
        borderRadius: BorderRadius.circular(14),
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        children: [
          Row(
            children: [
              const CircleAvatar(
                radius: 26,
                backgroundColor: Colors.white,
                child: Icon(Icons.person_rounded, color: UserUi.primary),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name, style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 16)),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Container(
                          width: 8,
                          height: 8,
                          decoration: const BoxDecoration(color: Color(0xFF07FF02), shape: BoxShape.circle),
                        ),
                        const SizedBox(width: 6),
                        Text(role, style: const TextStyle(fontSize: 13)),
                        const SizedBox(width: 12),
                        Text('No. $employeeNo', style: const TextStyle(fontSize: 12, color: UserUi.textMuted)),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          _InfoRow(label: 'Email', value: email),
          const SizedBox(height: 6),
          _InfoRow(label: 'No. Telepon', value: phone),
          const SizedBox(height: 6),
          _InfoRow(label: 'Jabatan', value: jobTitle),
          const SizedBox(height: 6),
          _InfoRow(label: 'Bergabung Sejak', value: joined),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(label, style: const TextStyle(fontStyle: FontStyle.italic, fontSize: 12)),
        const Spacer(),
        Text(value, style: const TextStyle(fontStyle: FontStyle.italic, fontSize: 12, fontWeight: FontWeight.w600)),
      ],
    );
  }
}

class _MenuCard extends StatelessWidget {
  const _MenuCard({required this.icon, required this.title, required this.onTap});

  final IconData icon;
  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color(0xFFFCF2FA),
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: UserUi.primary),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.w900, height: 1.1),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

