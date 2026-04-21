import 'package:flutter/material.dart';
import 'package:lemigas/constants/app_assets.dart';

class StatusBarangAdmin extends StatelessWidget {
  const StatusBarangAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          child: SizedBox(
            width: constraints.maxWidth,
            child: FittedBox(
              fit: BoxFit.fitWidth,
              alignment: Alignment.topCenter,
              child: SizedBox(
                width: 414,
                height: 896,
                child: Container(
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(color: const Color(0xFF1A1A1A)),
                  child: Stack(
                    children: [
              Positioned(
                left: 54.80,
                top: 77.75,
                child: Container(
                  transform: Matrix4.identity()..translate(0.0, 0.0)..rotateZ(3.11),
                  width: 32.77,
                  height: 32.77,
                  child: Stack(),
                ),
              ),
              Positioned(
                left: 160,
                top: 774,
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(AppAssets.splash),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 5,
                top: 116,
                child: Container(
                  width: 402,
                  height: 652,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFFFFBFB),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 6,
                        color: const Color(0xFFB0A0A0),
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 120,
                top: 704,
                child: Container(
                  width: 175,
                  height: 48,
                  decoration: ShapeDecoration(
                    color: const Color(0xFF0E62BC),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 120,
                top: 704,
                child: Container(
                  width: 175,
                  height: 40,
                  decoration: ShapeDecoration(
                    color: const Color(0xFF3998FC),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 22,
                top: 352,
                child: Container(
                  width: 111,
                  height: 36,
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 1,
                        color: const Color(0xFF9A9A9A),
                      ),
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 22,
                top: 395,
                child: Container(
                  width: 300,
                  height: 27,
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 1,
                        color: const Color(0xFFA7A7A7),
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 325,
                top: 395,
                child: Container(
                  width: 67,
                  height: 27,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFE7E7E9),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 1,
                        color: const Color(0xFFB9B9B9),
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 149,
                top: 352,
                child: Container(
                  width: 163,
                  height: 36,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFD5D2DD),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 1,
                        color: const Color(0xFFB5B5B5),
                      ),
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 299,
                top: 352,
                child: Container(
                  width: 92,
                  height: 36,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFD5D2DD),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 1,
                        color: const Color(0xFFB5B5B5),
                      ),
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 150,
                top: 70,
                child: Container(
                  width: 108,
                  height: 78,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFFFFBFB),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 3,
                        color: const Color(0xFFB0A0A0),
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 22,
                top: 198,
                child: Container(
                  width: 181,
                  height: 75,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFFBE5B3),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 2,
                        color: const Color(0xFFB0A0A0),
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 22,
                top: 285,
                child: Container(
                  width: 181,
                  height: 57,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFDCEBF9),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 2,
                        color: const Color(0xFFB0A0A0),
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 211,
                top: 285,
                child: Container(
                  width: 181,
                  height: 57,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFF1ECF0),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 2,
                        color: const Color(0xFFB0A0A0),
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 211,
                top: 198,
                child: Container(
                  width: 180,
                  height: 75,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFE1EEF9),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 2,
                        color: const Color(0xFFB0A0A0),
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 185,
                top: 51,
                child: Container(
                  width: 73,
                  height: 66,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(),
                ),
              ),
              Positioned(
                left: 348,
                top: 135,
                child: Container(
                  width: 44,
                  height: 40,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFD9D9D9),
                    shape: OvalBorder(),
                  ),
                ),
              ),
              Positioned(
                left: 356,
                top: 140,
                child: const SizedBox(
                  width: 29,
                  height: 31,
                  child: Icon(
                    Icons.settings,
                    size: 26,
                    color: Color(0xFF8D8D8D),
                  ),
                ),
              ),
              Positioned(
                left: 134,
                top: 159,
                child: SizedBox(
                  width: 146,
                  height: 29,
                  child: Text(
                    'Status Barang',
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
                left: 28,
                top: 400,
                child: Container(
                  width: 18,
                  height: 17,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(),
                  child: Stack(),
                ),
              ),
              Positioned(
                left: 67,
                top: 208,
                child: SizedBox(
                  width: 131,
                  height: 23,
                  child: Text(
                    'Total Barang Disewakan',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 10,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 32,
                top: 225,
                child: SizedBox(
                  width: 131,
                  height: 23,
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: '6 ',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 10,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        TextSpan(
                          text: 'Dipinjam',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 10,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Positioned(
                left: 40,
                top: 245,
                child: SizedBox(
                  width: 131,
                  height: 23,
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: '^',
                          style: TextStyle(
                            color: const Color(0xFFDFCC00),
                            fontSize: 10,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        TextSpan(
                          text: ' +5',
                          style: TextStyle(
                            color: const Color(0xFF00E338),
                            fontSize: 10,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        TextSpan(
                          text: ' ',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 10,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        TextSpan(
                          text: 'Barang baru',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 10,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Positioned(
                left: 231,
                top: 323,
                child: SizedBox(
                  width: 131,
                  height: 23,
                  child: Text(
                    'Perlu Perbaikan',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 10,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 212,
                top: 245,
                child: SizedBox(
                  width: 131,
                  height: 23,
                  child: Text(
                    'Hari ini 7',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: const Color(0xFF00FAFF),
                      fontSize: 10,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 108,
                top: 323,
                child: SizedBox(
                  width: 131,
                  height: 23,
                  child: Text(
                    '2 telat',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: const Color(0xFFFF0000),
                      fontSize: 10,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 72,
                top: 295,
                child: SizedBox(
                  width: 108,
                  height: 32,
                  child: Text(
                    'Terlambat\nDikembalikan',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 10,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 255,
                top: 208,
                child: SizedBox(
                  width: 108,
                  height: 32,
                  child: Text(
                    'Total Barang\nDikembalikan',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 10,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 258,
                top: 295,
                child: SizedBox(
                  width: 108,
                  height: 32,
                  child: Text(
                    'Total Barang\nRusak',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 10,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 167,
                top: 74,
                child: Container(
                  width: 74,
                  height: 69,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(AppAssets.stJudul),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 22,
                top: 197,
                child: Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(AppAssets.stBarangPinjam),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 211,
                top: 191,
                child: Container(
                  width: 44,
                  height: 66,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(AppAssets.stTotalKembali),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 21,
                top: 284,
                child: Container(
                  width: 54,
                  height: 54,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(AppAssets.stTelat),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 214,
                top: 290,
                child: Container(
                  width: 41,
                  height: 41,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(AppAssets.stTotalRusak),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 508.80,
                top: 54.75,
                child: Container(
                  transform: Matrix4.identity()..translate(0.0, 0.0)..rotateZ(3.11),
                  width: 32.77,
                  height: 32.77,
                  child: Stack(),
                ),
              ),
              Positioned(
                left: 26,
                top: 459,
                child: Container(
                  width: 360,
                  height: 188,
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 1,
                        color: const Color(0xFFE3E0E0),
                      ),
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 26,
                top: 470,
                child: Container(
                  width: 112,
                  height: 55,
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 1,
                        color: const Color(0xFFA7A7A7),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 26,
                top: 431,
                child: Container(
                  width: 112,
                  height: 40,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFE3E0E0),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 1,
                        color: const Color(0xFFA7A7A7),
                      ),
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 312,
                top: 431,
                child: Container(
                  width: 74,
                  height: 40,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFE3E0E0),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 1,
                        color: const Color(0xFFA7A7A7),
                      ),
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 26,
                top: 523,
                child: Container(
                  width: 112,
                  height: 57,
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 1,
                        color: const Color(0xFFA7A7A7),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 26,
                top: 576,
                child: Container(
                  width: 112,
                  height: 58,
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 1,
                        color: const Color(0xFFA7A7A7),
                      ),
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 26,
                top: 633,
                child: Container(
                  width: 112,
                  height: 57,
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 1,
                        color: const Color(0xFFA7A7A7),
                      ),
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 312,
                top: 632,
                child: Container(
                  width: 74,
                  height: 58,
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 1,
                        color: const Color(0xFFA7A7A7),
                      ),
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 25,
                top: 481,
                child: Container(
                  width: 52,
                  height: 35,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(AppAssets.stLaptop),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 26,
                top: 530,
                child: Container(
                  width: 48,
                  height: 41,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(AppAssets.stMonitor),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 30,
                top: 583,
                child: Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(AppAssets.stPrinter),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 31,
                top: 641,
                child: Container(
                  width: 41,
                  height: 41,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(AppAssets.stMouse),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 137,
                top: 431,
                child: Container(
                  width: 91,
                  height: 40,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFD9D9D9),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 1,
                        color: const Color(0xFF9C9C9C),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 137,
                top: 470,
                child: Container(
                  width: 91,
                  height: 54,
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 1,
                        color: const Color(0xFF9C9C9C),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 226,
                top: 470,
                child: Container(
                  width: 91,
                  height: 54,
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 1,
                        color: const Color(0xFF9C9C9C),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 313,
                top: 470,
                child: Container(
                  width: 73,
                  height: 54,
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 1,
                        color: const Color(0xFF9C9C9C),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 137,
                top: 523,
                child: Container(
                  width: 91,
                  height: 54,
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 1,
                        color: const Color(0xFF9C9C9C),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 226,
                top: 523,
                child: Container(
                  width: 91,
                  height: 54,
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 1,
                        color: const Color(0xFF9C9C9C),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 313,
                top: 523,
                child: Container(
                  width: 73,
                  height: 54,
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 1,
                        color: const Color(0xFF9C9C9C),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 137,
                top: 576,
                child: Container(
                  width: 91,
                  height: 58,
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 1,
                        color: const Color(0xFF9C9C9C),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 226,
                top: 576,
                child: Container(
                  width: 91,
                  height: 58,
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 1,
                        color: const Color(0xFF9C9C9C),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 313,
                top: 576,
                child: Container(
                  width: 73,
                  height: 58,
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 1,
                        color: const Color(0xFF9C9C9C),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 137,
                top: 633,
                child: Container(
                  width: 91,
                  height: 57,
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 1,
                        color: const Color(0xFF9C9C9C),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 226,
                top: 633,
                child: Container(
                  width: 88,
                  height: 57,
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 1,
                        color: const Color(0xFF9C9C9C),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 26,
                top: 442,
                child: SizedBox(
                  width: 111,
                  height: 29,
                  child: Text(
                    'Nama Barang',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                      fontFamily: 'Phetsarath',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 127,
                top: 442,
                child: SizedBox(
                  width: 111,
                  height: 29,
                  child: Text(
                    'Peminjam',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                      fontFamily: 'Phetsarath',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 226,
                top: 431,
                child: Container(
                  width: 88,
                  height: 40,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFD9D9D9),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 1,
                        color: const Color(0xFF9C9C9C),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 216,
                top: 434,
                child: SizedBox(
                  width: 111,
                  height: 29,
                  child: Text(
                    'Tanggal \nDipinjam',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                      fontFamily: 'Phetsarath',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 295,
                top: 442,
                child: SizedBox(
                  width: 111,
                  height: 29,
                  child: Text(
                    'Status',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                      fontFamily: 'Phetsarath',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 67,
                top: 483,
                child: SizedBox(
                  width: 63,
                  height: 28,
                  child: Text(
                    'Laptop',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 13,
                      fontFamily: 'Phetsarath',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 179,
                top: 483,
                child: SizedBox(
                  width: 60,
                  height: 28,
                  child: Text(
                    'Budi Agung',
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
                left: 320,
                top: 481,
                child: Container(
                  width: 58,
                  height: 35,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFFEE4A7),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3)),
                  ),
                ),
              ),
              Positioned(
                left: 232,
                top: 483,
                child: SizedBox(
                  width: 81,
                  height: 28,
                  child: Text(
                    '24 Mar 2024',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 13,
                      fontFamily: 'Phetsarath',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 320,
                top: 533,
                child: Container(
                  width: 58,
                  height: 35,
                  decoration: ShapeDecoration(
                    color: const Color(0xFF57D3C9),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3)),
                  ),
                ),
              ),
              Positioned(
                left: 320,
                top: 585,
                child: Container(
                  width: 58,
                  height: 42,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFFE6F51),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3)),
                  ),
                ),
              ),
              Positioned(
                left: 320,
                top: 641,
                child: Container(
                  width: 58,
                  height: 42,
                  decoration: ShapeDecoration(
                    color: const Color(0xFF57D3C9),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3)),
                  ),
                ),
              ),
              Positioned(
                left: 309,
                top: 484,
                child: SizedBox(
                  width: 81,
                  height: 28,
                  child: Text(
                    'Terlambat\n2 Hari',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 10,
                      fontFamily: 'Phetsarath',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 309,
                top: 542,
                child: SizedBox(
                  width: 81,
                  height: 28,
                  child: Text(
                    'Dipinjam',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 11,
                      fontFamily: 'Phetsarath',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 309,
                top: 594,
                child: SizedBox(
                  width: 81,
                  height: 28,
                  child: Text(
                    'Telat',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontFamily: 'Phetsarath',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 309,
                top: 654,
                child: SizedBox(
                  width: 81,
                  height: 28,
                  child: Text(
                    'Dipinjam',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 11,
                      fontFamily: 'Phetsarath',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 232,
                top: 502,
                child: SizedBox(
                  width: 81,
                  height: 28,
                  child: Text(
                    '26 Mar 2024',
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
                left: 232,
                top: 535,
                child: SizedBox(
                  width: 81,
                  height: 28,
                  child: Text(
                    '25 Mar 2024',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 13,
                      fontFamily: 'Phetsarath',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 232,
                top: 554,
                child: SizedBox(
                  width: 81,
                  height: 28,
                  child: Text(
                    '27 Mar 2024',
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
                left: 232,
                top: 590,
                child: SizedBox(
                  width: 81,
                  height: 28,
                  child: Text(
                    '23 Mar 2024',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 13,
                      fontFamily: 'Phetsarath',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 232,
                top: 609,
                child: SizedBox(
                  width: 81,
                  height: 28,
                  child: Text(
                    '25 Mar 2024',
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
                left: 232,
                top: 647,
                child: SizedBox(
                  width: 81,
                  height: 28,
                  child: Text(
                    '26 Mar 2024',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 13,
                      fontFamily: 'Phetsarath',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 232,
                top: 666,
                child: SizedBox(
                  width: 81,
                  height: 28,
                  child: Text(
                    '28 Mar 2024',
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
                left: 176,
                top: 535,
                child: SizedBox(
                  width: 63,
                  height: 28,
                  child: Text(
                    'Melissa Putri',
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
                left: 173,
                top: 590,
                child: SizedBox(
                  width: 63,
                  height: 28,
                  child: Text(
                    'Bintang Audi',
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
                left: 179,
                top: 647,
                child: SizedBox(
                  width: 51,
                  height: 28,
                  child: Text(
                    'Putri Ayu',
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
                left: 74,
                top: 535,
                child: SizedBox(
                  width: 57,
                  height: 29,
                  child: Text(
                    'Monitor',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 13,
                      fontFamily: 'Phetsarath',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 71,
                top: 590,
                child: SizedBox(
                  width: 58,
                  height: 28,
                  child: Text(
                    'Printer',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 13,
                      fontFamily: 'Phetsarath',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 77,
                top: 647,
                child: SizedBox(
                  width: 45,
                  height: 28,
                  child: Text(
                    'Mouse',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 13,
                      fontFamily: 'Phetsarath',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 38,
                top: 402,
                child: SizedBox(
                  width: 152,
                  height: 23,
                  child: Text(
                    'Cari barang, peminjam... ',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: const Color(0xFF7F7F7F),
                      fontSize: 11,
                      fontFamily: 'Phetsarath',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 332,
                top: 399,
                child: SizedBox(
                  width: 55,
                  height: 23,
                  child: Text(
                    'Detail',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 13,
                      fontFamily: 'Phetsarath',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 160,
                top: 219,
                child: SizedBox(
                  width: 38,
                  height: 23,
                  child: Text(
                    '14',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 32,
                      fontFamily: 'Outfit',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 337,
                top: 202,
                child: SizedBox(
                  width: 51,
                  height: 23,
                  child: Text(
                    '20',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 32,
                      fontFamily: 'Outfit',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 150,
                top: 290,
                child: SizedBox(
                  width: 61,
                  height: 23,
                  child: Text(
                    '3',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 30,
                      fontFamily: 'Outfit',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 339,
                top: 291,
                child: SizedBox(
                  width: 61,
                  height: 23,
                  child: Text(
                    '2',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 30,
                      fontFamily: 'Outfit',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 133,
                top: 371,
                child: Container(
                  width: 16,
                  height: 17,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFD9D9D9),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 1,
                        color: const Color(0xFFA1A1A1),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 148,
                top: 709,
                child: SizedBox(
                  width: 119,
                  height: 23,
                  child: Text(
                    'Lanjut',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontFamily: 'Phetsarath',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 22,
                top: 359,
                child: SizedBox(
                  width: 111,
                  height: 23,
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: 'Sedang',
                          style: TextStyle(
                            color: const Color(0xFF3998FC),
                            fontSize: 12,
                            fontFamily: 'Phetsarath',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        TextSpan(
                          text: ' Dipinjam',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                            fontFamily: 'Phetsarath',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Positioned(
                left: 163,
                top: 359,
                child: SizedBox(
                  width: 125,
                  height: 23,
                  child: Text(
                    'History Penggunaan',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                      fontFamily: 'Phetsarath',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 305,
                top: 359,
                child: SizedBox(
                  width: 111,
                  height: 23,
                  child: Text(
                    'Filter',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontFamily: 'Phetsarath',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 310,
                top: 358,
                child: const SizedBox(
                  width: 24,
                  height: 24,
                  child: Icon(
                    Icons.filter_list,
                    size: 20,
                    color: Color(0xFF3998FC),
                  ),
                ),
              ),
              Positioned(
                left: 27,
                top: 386,
                child: Container(
                  width: 102,
                  height: 3,
                  decoration: ShapeDecoration(
                    color: const Color(0xFF3998FC),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 145,
                top: 325,
                child: Container(
                  width: 11,
                  height: 11,
                  decoration: const BoxDecoration(
                    color: Color(0xFF3998FC),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              Positioned(
                left: 142,
                top: 478,
                child: Container(
                  width: 31,
                  height: 32,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(AppAssets.stLaptop),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 142,
                top: 532,
                child: Container(
                  width: 31,
                  height: 32,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(AppAssets.stMonitor),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 142,
                top: 584,
                child: Container(
                  width: 31,
                  height: 31,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(AppAssets.stPrinter),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 142,
                top: 643,
                child: Container(
                  width: 31,
                  height: 29,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(AppAssets.stMouse),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
            ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}