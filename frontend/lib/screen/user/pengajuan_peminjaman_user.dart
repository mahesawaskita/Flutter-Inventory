import 'package:flutter/material.dart';

import 'user_ui.dart';

class PengajuanPeminjamanUserScreen extends StatelessWidget {
  const PengajuanPeminjamanUserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return UserPageScaffold(
      child: UserFramedPage(
        title: 'Pengajuan Peminjaman',
        topIcon: const Icon(Icons.assignment_rounded, size: 46, color: Color(0xFF33343D)),
        topTrailing: Container(
          width: 38,
          height: 38,
          decoration: const BoxDecoration(
            color: Color(0xFFD2D0D2),
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.settings, color: Color(0xFF8A8A8A)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            UserSectionCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  UserInfoTile(
                    leading: UserProductThumb(
                      icon: Icons.inventory_2_rounded,
                      background: Color(0xFFF7E3C1),
                    ),
                    title: 'Nama Barang',
                  ),
                  SizedBox(height: 8),
                  UserTextInputMock(text: 'Laptop'),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 42,
                    decoration: BoxDecoration(
                      color: const Color(0xFFD9E8FB),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: const Row(
                      children: [
                        Icon(Icons.subject_rounded, color: Color(0xFF45B6FA)),
                        SizedBox(width: 8),
                        Text('Kategori', style: TextStyle(fontWeight: FontWeight.w700)),
                        Spacer(),
                        Text('Gadget >', style: TextStyle(color: UserUi.textMuted)),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Container(
                    height: 42,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.add, color: Color(0xFF58C6F5)),
                        SizedBox(width: 6),
                        Text('Tambah Kategori', style: TextStyle(fontWeight: FontWeight.w700)),
                        SizedBox(width: 6),
                        Icon(Icons.keyboard_arrow_down_rounded),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            UserSectionCard(
              child: Column(
                children: [
                  Row(
                    children: const [
                      Expanded(child: _FieldWithLabel(label: 'Kategori', value: 'Elektronik', icon: Icons.memory_rounded, trailing: Icon(Icons.keyboard_arrow_down_rounded))),
                      SizedBox(width: 12),
                      Expanded(child: _FieldWithLabel(label: 'Status', value: 'Tersedia', icon: Icons.check_circle_rounded, valueColor: Color(0xFF1E8F2F), trailing: Icon(Icons.keyboard_arrow_down_rounded))),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: const [
                      Expanded(child: _FieldWithLabel(label: 'Stok', value: '8', icon: Icons.inventory_rounded)),
                      SizedBox(width: 12),
                      Expanded(child: _FieldWithLabel(label: 'Harga', value: 'Rp. 8.000.000', icon: Icons.shopping_cart_checkout_rounded)),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const _TextArea(
                    label: 'Nama Merek',
                    icon: Icons.receipt_long_rounded,
                    text: 'Laptop merek honor keluaran tahun 2019 dengan layar 12 inci.',
                  ),
                  const SizedBox(height: 10),
                  const _PhotoHeader(),
                  const SizedBox(height: 10),
                  Row(
                    children: const [
                      Expanded(child: _PreviewPhoto()),
                      SizedBox(width: 8),
                      Expanded(child: _AddPhoto()),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 102),
              child: UserPrimaryButton(text: 'Konfirmasi'),
            ),
          ],
        ),
      ),
    );
  }
}

class _FieldWithLabel extends StatelessWidget {
  const _FieldWithLabel({
    required this.label,
    required this.value,
    required this.icon,
    this.trailing,
    this.valueColor,
  });

  final String label;
  final String value;
  final IconData icon;
  final Widget? trailing;
  final Color? valueColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 13)),
        const SizedBox(height: 4),
        Container(
          height: 34,
          decoration: BoxDecoration(
            color: UserUi.input,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: UserUi.softBorder),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            children: [
              Icon(icon, size: 18, color: const Color(0xFF59B8F4)),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  value,
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: valueColor ?? Colors.black87),
                ),
              ),
              if (trailing != null) trailing!,
            ],
          ),
        ),
      ],
    );
  }
}

class _TextArea extends StatelessWidget {
  const _TextArea({
    required this.label,
    required this.icon,
    required this.text,
  });

  final String label;
  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: const Color(0xFF59B8F4)),
            const SizedBox(width: 6),
            Text(label, style: const TextStyle(fontSize: 13)),
          ],
        ),
        const SizedBox(height: 6),
        Container(
          width: double.infinity,
          constraints: const BoxConstraints(minHeight: 66),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: UserUi.input,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: UserUi.softBorder),
          ),
          child: Text(text, style: const TextStyle(fontSize: 12, height: 1.4)),
        ),
      ],
    );
  }
}

class _PhotoHeader extends StatelessWidget {
  const _PhotoHeader();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.description_rounded),
        const SizedBox(width: 6),
        const Text('Deskripsi', style: TextStyle(fontWeight: FontWeight.w800)),
        const SizedBox(width: 8),
        Expanded(
          child: Container(
            height: 1,
            decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(color: UserUi.frameBorder, style: BorderStyle.solid)),
            ),
          ),
        ),
      ],
    );
  }
}

class _PreviewPhoto extends StatelessWidget {
  const _PreviewPhoto();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 68,
      decoration: BoxDecoration(
        color: const Color(0xFFD7D7D7),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: UserUi.frameBorder.withOpacity(.7)),
      ),
      child: Stack(
        children: [
          const Center(
            child: Icon(Icons.laptop_mac_rounded, size: 42, color: Color(0xFF4460C8)),
          ),
          Positioned(
            top: 4,
            right: 4,
            child: Container(
              width: 24,
              height: 24,
              decoration: const BoxDecoration(color: Color(0xFFD63A30), shape: BoxShape.circle),
              child: const Icon(Icons.delete_rounded, size: 14, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}

class _AddPhoto extends StatelessWidget {
  const _AddPhoto();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 68,
      decoration: BoxDecoration(
        color: const Color(0xFFF9F5F9),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: UserUi.softBorder, style: BorderStyle.solid),
      ),
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.add_circle_rounded, size: 34, color: Color(0xFF5BC9F6)),
          SizedBox(height: 4),
          Text('+ Tambah Foto', style: TextStyle(fontSize: 12, color: UserUi.textMuted)),
        ],
      ),
    );
  }
}
