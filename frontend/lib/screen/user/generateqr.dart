import 'package:flutter/material.dart';

<<<<<<< HEAD
class GenerateQrScannerUser extends StatelessWidget {
  const GenerateQrScannerUser({super.key});

=======
import 'user_ui.dart';

class GenerateQrUser extends StatefulWidget {
  const GenerateQrUser({super.key});

  @override
  State<GenerateQrUser> createState() => _GenerateQrUserState();
}

class _GenerateQrUserState extends State<GenerateQrUser> {
>>>>>>> 10f9c2930719f31f6da0da358a8ff35c3fb218ab
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
                children: [
                  const Padding(
                    padding: EdgeInsets.all(10),
                    child: UserInfoTile(
                      leading: UserProductThumb(icon: Icons.laptop_mac_rounded),
                      title: 'Laptop',
                    ),
                  ),
                  Container(height: 1, color: UserUi.softBorder),
                  const Padding(
                    padding: EdgeInsets.all(10),
                    child: Row(
                      children: [
                        Icon(Icons.list_alt_rounded, color: Color(0xFF52B2F1)),
                        SizedBox(width: 8),
                        Text('Kategori', style: TextStyle(fontSize: 13)),
                      ],
                    ),
                  ),
                  Container(height: 1, color: UserUi.softBorder),
                  const Padding(
                    padding: EdgeInsets.all(10),
                    child: Row(
                      children: [
                        Icon(Icons.memory_rounded, color: Color(0xFF52B2F1)),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            'Elektronik',
                            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
                          ),
                        ),
                        Icon(Icons.chevron_right_rounded),
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
                    child: UserTextInputMock(
                      text: 'Laptop merek honor keluaran tahun 2019 dengan layar 12 inci.',
                      muted: true,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Container(
              width: 90,
              height: 66,
              decoration: BoxDecoration(
                color: const Color(0xFFF8F2F7),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: UserUi.frameBorder, width: 3),
              ),
              child: const Icon(Icons.laptop_mac_rounded, size: 40, color: Color(0xFF4460C8)),
            ),
            const SizedBox(height: 8),
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
}