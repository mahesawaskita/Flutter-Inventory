import 'package:flutter/material.dart';

class LaporanQrScannerUser extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 414,
          height: 896,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(color: Colors.white),
          child: Stack(
            children: [
              Positioned(
                left: 287,
                top: 51,
                child: SizedBox(
                  width: 67,
                  height: 48,
                  child: Text(
                    'Lanjut',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 60.46,
                top: 94.22,
                child: Container(
                  transform: Matrix4.identity()..translate(0.0, 0.0)..rotateZ(3.11),
                  width: 32.77,
                  height: 32.77,
                  child: Stack(),
                ),
              ),
              Positioned(
                left: 12,
                top: 132,
                child: Opacity(
                  opacity: 0.50,
                  child: Container(
                    width: 389,
                    height: 551,
                    decoration: ShapeDecoration(
                      color: const Color(0xFFEDE2F0),
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          width: 3,
                          color: const Color(0xFFAC9BAB),
                        ),
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 159,
                top: 92,
                child: Container(
                  width: 95,
                  height: 75,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFFBF0F8),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 3,
                        color: const Color(0xFFAC9BAB),
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 187,
                top: 66,
                child: Container(
                  width: 70,
                  height: 66,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(),
                ),
              ),
              Positioned(
                left: 172,
                top: 101,
                child: Container(
                  width: 69,
                  height: 58,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(),
                  child: Stack(),
                ),
              ),
              Positioned(
                left: 98,
                top: 172,
                child: SizedBox(
                  width: 224,
                  height: 29,
                  child: Text(
                    'Generate QR Scanner',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontFamily: 'Paytone One',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 22,
                top: 215,
                child: Container(
                  width: 369,
                  height: 101,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFFAF0F8),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 1,
                        color: const Color(0xFFC5C5C5),
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 22,
                top: 215,
                child: Container(
                  width: 369,
                  height: 50,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFFAF0F8),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 1,
                        color: const Color(0xFFC5C5C5),
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 32,
                top: 221,
                child: Container(
                  width: 49,
                  height: 40,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage("https://placehold.co/49x40"),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 86,
                top: 221,
                child: SizedBox(
                  width: 184,
                  height: 32,
                  child: Text(
                    'Laptop',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 13,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 86,
                top: 241,
                child: SizedBox(
                  width: 184,
                  height: 32,
                  child: Text(
                    'Elektronik',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 13,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 156,
                top: 403,
                child: Container(
                  width: 102,
                  height: 53,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFEDE2F0),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 1,
                        color: const Color(0xFFABABAB),
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 195,
                top: 411,
                child: Container(
                  width: 23,
                  height: 25,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFD9D9D9),
                    shape: OvalBorder(
                      side: BorderSide(
                        width: 1,
                        color: const Color(0xFFB1B1B1),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 178,
                top: 399,
                child: SizedBox(
                  width: 57,
                  height: 18,
                  child: Text(
                    '+',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: const Color(0xFF8B8B8B),
                      fontSize: 36,
                      fontFamily: 'Phetsarath',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 139,
                top: 438,
                child: SizedBox(
                  width: 136,
                  height: 18,
                  child: Text(
                    '+ Foto Barang',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: const Color(0xFF8B8B8B),
                      fontSize: 10,
                      fontFamily: 'Phetsarath',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 33,
                top: 270,
                child: SizedBox(
                  width: 348,
                  height: 38,
                  child: Text(
                    'Laptop merek honor keluaran tahun 2019 dengan layar\n12 inci.',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 13,
                      fontFamily: 'Phetsarath',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 118,
                top: 597,
                child: SizedBox(
                  width: 178,
                  height: 38,
                  child: Text(
                    'QR code untuk barang Laptop',
                    style: TextStyle(
                      color: const Color(0xFF8B8B8B),
                      fontSize: 12,
                      fontFamily: 'Phetsarath',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 144,
                top: 463,
                child: Container(
                  width: 126,
                  height: 126,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage("https://placehold.co/126x126"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 123,
                top: 629,
                child: Container(
                  width: 166,
                  height: 36,
                  decoration: ShapeDecoration(
                    color: const Color(0xFF0E62BC),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 123,
                top: 629,
                child: Container(
                  width: 166,
                  height: 30,
                  decoration: ShapeDecoration(
                    color: const Color(0xFF3998FC),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 87,
                top: 633,
                child: SizedBox(
                  width: 239,
                  height: 23,
                  child: Text(
                    'Cetak QR Code',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontFamily: 'Phetsarath',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 0,
                top: 0,
                child: Container(
                  width: 414,
                  height: 896,
                  decoration: BoxDecoration(color: const Color(0x381A1A1A)),
                ),
              ),
              Positioned(
                left: 61,
                top: 309,
                child: Container(
                  width: 291,
                  height: 164,
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 165,
                top: 328,
                child: SizedBox(
                  width: 184,
                  height: 32,
                  child: Text(
                    'QR Code Dibuat!',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 128,
                top: 326,
                child: Container(
                  width: 29,
                  height: 29,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage("https://placehold.co/29x29"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 78,
                top: 360,
                child: SizedBox(
                  width: 269,
                  height: 38,
                  child: Text(
                    'QR code berhasil dibuat dan sudah diunduh!',
                    style: TextStyle(
                      color: const Color(0xFF8B8B8B),
                      fontSize: 12,
                      fontFamily: 'Phetsarath',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 78,
                top: 388,
                child: Container(
                  width: 258,
                  height: 37,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFF6F2F9),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 1,
                        color: const Color(0xFFC5C5C5),
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 121,
                top: 397,
                child: SizedBox(
                  width: 269,
                  height: 38,
                  child: Text(
                    'QRCode_Laptop.png',
                    style: TextStyle(
                      color: const Color(0xFF7080B1),
                      fontSize: 14,
                      fontFamily: 'Phetsarath',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 78,
                top: 431,
                child: Container(
                  width: 258,
                  height: 36,
                  decoration: ShapeDecoration(
                    color: const Color(0xFF0E62BC),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 78,
                top: 431,
                child: Container(
                  width: 258,
                  height: 30,
                  decoration: ShapeDecoration(
                    color: const Color(0xFF3998FC),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 89,
                top: 436,
                child: SizedBox(
                  width: 239,
                  height: 23,
                  child: Text(
                    'OK',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontFamily: 'Phetsarath',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 89,
                top: 392,
                child: Container(
                  width: 29,
                  height: 29,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage("https://placehold.co/29x29"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}