import 'package:flutter/material.dart';
import 'package:frontend/constants/app_assets.dart';

class DetailBarangAdmin extends StatelessWidget {
  const DetailBarangAdmin({super.key});

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
                child: SizedBox(
                  width: 29,
                  height: 31,
                  child: const Icon(
                    Icons.settings,
                    color: Color(0xFF8D8D8D),
                    size: 26,
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
                    'Detail Barang',
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
                left: 171,
                top: 76,
                child: Container(
                  width: 65,
                  height: 65,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(AppAssets.dbJudul),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 22,
                top: 197,
                child: Container(
                  width: 370,
                  height: 123,
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 1,
                        color: const Color(0xFFB1B1B1),
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 22,
                top: 197,
                child: Container(
                  width: 370,
                  height: 48,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFF3EFF4),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 1,
                        color: const Color(0xFFB1B1B1),
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 72,
                top: 526,
                child: Container(
                  width: 320,
                  height: 36,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFEEE9F0),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 1,
                        color: const Color(0xFFB1B1B1),
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 12,
                top: 327,
                child: Container(
                  width: 389,
                  height: 41,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFEEEAF1),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(1)),
                  ),
                ),
              ),
              Positioned(
                left: 12,
                top: 569,
                child: Container(
                  width: 389,
                  height: 41,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFEEEAF1),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(1)),
                  ),
                ),
              ),
              Positioned(
                left: 392,
                top: 245,
                child: Container(
                  transform: Matrix4.identity()..translate(0.0, 0.0)..rotateZ(3.14),
                  width: 370,
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 1,
                        strokeAlign: BorderSide.strokeAlignCenter,
                        color: const Color(0xFF9E9E9E),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 392,
                top: 289,
                child: Container(
                  transform: Matrix4.identity()..translate(0.0, 0.0)..rotateZ(3.14),
                  width: 370,
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 1,
                        strokeAlign: BorderSide.strokeAlignCenter,
                        color: const Color(0xFF9E9E9E),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 392,
                top: 403,
                child: Container(
                  transform: Matrix4.identity()..translate(0.0, 0.0)..rotateZ(3.14),
                  width: 370,
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 1,
                        strokeAlign: BorderSide.strokeAlignCenter,
                        color: const Color(0xFF9E9E9E),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 392,
                top: 444,
                child: Container(
                  transform: Matrix4.identity()..translate(0.0, 0.0)..rotateZ(3.14),
                  width: 370,
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 1,
                        strokeAlign: BorderSide.strokeAlignCenter,
                        color: const Color(0xFF9E9E9E),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 392,
                top: 482,
                child: Container(
                  transform: Matrix4.identity()..translate(0.0, 0.0)..rotateZ(3.14),
                  width: 370,
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 1,
                        strokeAlign: BorderSide.strokeAlignCenter,
                        color: const Color(0xFF9E9E9E),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 392,
                top: 519,
                child: Container(
                  transform: Matrix4.identity()..translate(0.0, 0.0)..rotateZ(3.14),
                  width: 370,
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 1,
                        strokeAlign: BorderSide.strokeAlignCenter,
                        color: const Color(0xFF9E9E9E),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 26,
                top: 198,
                child: Container(
                  width: 71,
                  height: 47,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(AppAssets.dfLaptop),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 26,
                top: 246,
                child: Container(
                  width: 41,
                  height: 43,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(AppAssets.dbPeminjaman),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 32,
                top: 290,
                child: Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(AppAssets.dbRangeTanggal),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 22,
                top: 332,
                child: Container(
                  width: 31,
                  height: 31,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(AppAssets.dbDetailPeminjaman),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 18,
                top: 376,
                child: ClipOval(
                  child: Image.asset(
                    AppAssets.dbnUser,
                    width: 24,
                    height: 24,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                left: 20,
                top: 414,
                child: SizedBox(
                  width: 30,
                  height: 26,
                  child: Image.asset(
                    AppAssets.dbnTanggalPinjam,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              Positioned(
                left: 19,
                top: 453,
                child: SizedBox(
                  width: 30,
                  height: 26,
                  child: Image.asset(
                    AppAssets.dbnTanggalKembali,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              Positioned(
                left: 19,
                top: 488,
                child: SizedBox(
                  width: 28,
                  height: 28,
                  child: Image.asset(
                    AppAssets.dbStatus,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              Positioned(
                left: 19,
                top: 570,
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(AppAssets.dbFotoKembali),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 19.40,
                top: 524.90,
                child: Container(
                  transform: Matrix4.identity()..translate(0.0, 0.0)..rotateZ(-0.10),
                  width: 40.39,
                  height: 40.39,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(AppAssets.dbDeskripsi),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 26,
                top: 625,
                child: Container(
                  width: 145,
                  height: 69,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFD7D7D7),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 1,
                        color: const Color(0xFFB1B1B1),
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 247,
                top: 625,
                child: Container(
                  width: 145,
                  height: 69,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFD7D7D7),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 1,
                        color: const Color(0xFFB1B1B1),
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 37,
                top: 627,
                child: Container(
                  width: 119,
                  height: 67,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(AppAssets.dbLaptopRusak),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 258,
                top: 627,
                child: Container(
                  width: 119,
                  height: 67,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(AppAssets.dbMonitorRusak),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 25,
                top: 623,
                child: Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(AppAssets.dbnTongSampah),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 246,
                top: 623,
                child: Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(AppAssets.dbnTongSampah2),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 91,
                top: 201,
                child: SizedBox(
                  width: 107,
                  height: 23,
                  child: Text(
                    'Nama Barang',
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
                left: 42,
                top: 336,
                child: SizedBox(
                  width: 171,
                  height: 23,
                  child: Text(
                    'Detail Peminjaman',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontFamily: 'Phetsarath',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 47,
                top: 578,
                child: SizedBox(
                  width: 171,
                  height: 23,
                  child: Text(
                    'Foto Pengembalian',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontFamily: 'Phetsarath',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 58,
                top: 267,
                child: SizedBox(
                  width: 107,
                  height: 23,
                  child: Text(
                    'Budi Agung',
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
                left: 278,
                top: 376,
                child: SizedBox(
                  width: 107,
                  height: 23,
                  child: Text(
                    'Budi Agung',
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
                left: 278,
                top: 415,
                child: SizedBox(
                  width: 107,
                  height: 23,
                  child: Text(
                    '24 Mar 2024',
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
                left: 278,
                top: 454,
                child: SizedBox(
                  width: 107,
                  height: 23,
                  child: Text(
                    '26 Mar 2024',
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
                left: 68,
                top: 220,
                child: SizedBox(
                  width: 107,
                  height: 23,
                  child: Text(
                    'Laptop',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontFamily: 'Phetsarath',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 15,
                top: 247,
                child: SizedBox(
                  width: 174,
                  height: 23,
                  child: Text(
                    'Peminjam',
                    textAlign: TextAlign.center,
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
                left: 37,
                top: 376,
                child: SizedBox(
                  width: 156,
                  height: 23,
                  child: Text(
                    'Nama Peminjam',
                    textAlign: TextAlign.center,
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
                left: 39,
                top: 415,
                child: SizedBox(
                  width: 156,
                  height: 23,
                  child: Text(
                    'Tanggal Dipinjam',
                    textAlign: TextAlign.center,
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
                left: 36,
                top: 454,
                child: SizedBox(
                  width: 156,
                  height: 23,
                  child: Text(
                    'Tanggal Kembali',
                    textAlign: TextAlign.center,
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
                left: 4,
                top: 491,
                child: SizedBox(
                  width: 156,
                  height: 23,
                  child: Text(
                    'Status',
                    textAlign: TextAlign.center,
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
                left: 75,
                top: 534,
                child: SizedBox(
                  width: 263,
                  height: 23,
                  child: Text(
                    'Laptop rusak LCD retak, perlu perbaikan',
                    textAlign: TextAlign.center,
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
                left: 258,
                top: 294,
                child: Container(
                  width: 127,
                  height: 22,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFF49E3D),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 236,
                top: 295,
                child: SizedBox(
                  width: 174,
                  height: 23,
                  child: Text(
                    'Terlambat 2 Hari',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontFamily: 'Phetsarath',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 250,
                top: 490,
                child: Container(
                  width: 127,
                  height: 22,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFF49E3D),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 228,
                top: 491,
                child: SizedBox(
                  width: 174,
                  height: 23,
                  child: Text(
                    'Terlambat 2 Hari',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontFamily: 'Phetsarath',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 62,
                top: 295,
                child: SizedBox(
                  width: 174,
                  height: 23,
                  child: Text(
                    '24 Mar 2024 - 26 Mar 2024',
                    textAlign: TextAlign.center,
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
                left: 380,
                top: 369,
                child: SizedBox(
                  width: 5,
                  height: 32,
                  child: Text(
                    '>',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 380,
                top: 407,
                child: SizedBox(
                  width: 5,
                  height: 32,
                  child: Text(
                    '>',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 380,
                top: 446,
                child: SizedBox(
                  width: 5,
                  height: 32,
                  child: Text(
                    '>',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 380,
                top: 484,
                child: SizedBox(
                  width: 5,
                  height: 32,
                  child: Text(
                    '>',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
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