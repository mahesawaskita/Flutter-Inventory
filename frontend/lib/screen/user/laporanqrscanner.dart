import 'package:flutter/material.dart';

import 'user_ui.dart';

class LaporanQrScannerUser extends StatefulWidget {
  const LaporanQrScannerUser({super.key});

  @override
  State<LaporanQrScannerUser> createState() => _LaporanQrScannerUserState();
}

class _LaporanQrScannerUserState extends State<LaporanQrScannerUser> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const _GenerateBackdrop(),
        Positioned.fill(
          child: Container(color: const Color(0xFF8D8393).withOpacity(.35)),
        ),
        Center(
          child: Container(
            width: 290,
            padding: const EdgeInsets.fromLTRB(18, 16, 18, 14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(22),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 16,
                      backgroundColor: Color(0xFF1DB954),
                      child: Icon(Icons.check_rounded, color: Colors.white),
                    ),
                    SizedBox(width: 10),
                    Text('QR Code Dibuat!', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900)),
                  ],
                ),
                const SizedBox(height: 10),
                const Text(
                  'QR code berhasil dibuat dan sudah diunduh!',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 13, color: UserUi.textMuted),
                ),
                const SizedBox(height: 12),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF7F4F7),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: UserUi.softBorder),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.download_done_rounded, color: Color(0xFF41C441)),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'QRCode_Laptop.png',
                          style: TextStyle(fontSize: 13, color: Color(0xFF7482BF), fontWeight: FontWeight.w800),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 14),
                const UserPrimaryButton(text: 'OK'),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _GenerateBackdrop extends StatelessWidget {
  const _GenerateBackdrop();

  @override
  Widget build(BuildContext context) {
    return UserPageScaffold(
      child: UserFramedPage(
        title: 'Generate QR Scanner',
        topIcon: const Icon(Icons.qr_code_2_rounded, size: 46, color: Color(0xFF545163)),
        child: Column(
          children: [
            UserSectionCard(
              padding: EdgeInsets.zero,
              child: Column(
                children: const [
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: UserInfoTile(
                      leading: UserProductThumb(icon: Icons.laptop_mac_rounded),
                      title: 'Laptop',
                      subtitle: 'Elektronik',
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
                    child: UserTextInputMock(
                      text: 'Laptop merek honor keluaran tahun 2019 dengan layar 12 inci.',
                      muted: true,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 14),
            Container(
              width: 126,
              height: 126,
              color: Colors.white,
              alignment: Alignment.center,
              child: const Icon(Icons.qr_code_2_rounded, size: 112),
            ),
            const SizedBox(height: 8),
            const Text('QR code untuk barang Laptop', style: TextStyle(fontSize: 13, color: UserUi.textMuted)),
            const SizedBox(height: 12),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 92),
              child: UserPrimaryButton(text: 'Cetak QR Code'),
            ),
          ],
        ),
      ),
    );
  }
}
