import 'package:flutter/material.dart';
import 'package:frontend/constants/app_assets.dart';
import 'package:frontend/screen/admin/TambahBarang.dart';

class PenambahanBarangAdmin extends StatefulWidget {
  const PenambahanBarangAdmin({super.key});

  @override
  State<PenambahanBarangAdmin> createState() => _PenambahanBarangAdminState();
}

class _PenambahanBarangAdminState extends State<PenambahanBarangAdmin> {
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
                left: 55.80,
                top: 78.75,
                child: Container(
                  transform: Matrix4.identity()..translate(0.0, 0.0)..rotateZ(3.11),
                  width: 32.77,
                  height: 32.77,
                  child: Stack(),
                ),
              ),
              Positioned(
                left: 161,
                top: 773,
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
                left: 6,
                top: 115,
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
                left: 119,
                top: 723,
                child: Container(
                  width: 175,
                  height: 30,
                  decoration: ShapeDecoration(
                    color: const Color(0xFF0E62BC),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 245,
                top: 526,
                child: Container(
                  width: 142,
                  height: 27,
                  decoration: ShapeDecoration(
                    color: const Color(0xFF0D62BB),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 23,
                top: 415,
                child: Container(
                  width: 128,
                  height: 72,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFF0EEF6),
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
                left: 165,
                top: 415,
                child: Container(
                  width: 221,
                  height: 25,
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 1,
                        color: const Color(0xFFB3B3B3),
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 166,
                top: 444,
                child: Container(
                  width: 145,
                  height: 25,
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 1,
                        color: const Color(0xFFB1B1B1),
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 317,
                top: 444,
                child: Container(
                  width: 69,
                  height: 25,
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 1,
                        color: const Color(0xFFADADAD),
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 360,
                top: 444,
                child: Container(
                  width: 26,
                  height: 25,
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 1,
                        color: const Color(0xFFADADAD),
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 317,
                top: 444,
                child: Container(
                  width: 23,
                  height: 25,
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 1,
                        color: const Color(0xFFADADAD),
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 27,
                top: 589,
                child: Container(
                  width: 360,
                  height: 126,
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
                left: 27,
                top: 589,
                child: Container(
                  width: 88,
                  height: 26,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFE2DFDF),
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
                left: 27,
                top: 639,
                child: Container(
                  width: 88,
                  height: 26,
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
                left: 27,
                top: 614,
                child: Container(
                  width: 88,
                  height: 26,
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
                left: 27,
                top: 664,
                child: Container(
                  width: 88,
                  height: 26,
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
                left: 27,
                top: 689,
                child: Container(
                  width: 88,
                  height: 26,
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
                left: 114,
                top: 589,
                child: Container(
                  width: 70,
                  height: 26,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFE3E0E0),
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
                left: 114,
                top: 639,
                child: Container(
                  width: 70,
                  height: 26,
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
                left: 114,
                top: 614,
                child: Container(
                  width: 70,
                  height: 26,
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
                left: 114,
                top: 664,
                child: Container(
                  width: 70,
                  height: 26,
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
                left: 114,
                top: 689,
                child: Container(
                  width: 70,
                  height: 26,
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
                left: 183,
                top: 589,
                child: Container(
                  width: 99,
                  height: 26,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFE3E0E0),
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
                left: 183,
                top: 639,
                child: Container(
                  width: 99,
                  height: 26,
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
                left: 183,
                top: 614,
                child: Container(
                  width: 99,
                  height: 26,
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
                left: 183,
                top: 664,
                child: Container(
                  width: 99,
                  height: 26,
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
                left: 183,
                top: 689,
                child: Container(
                  width: 99,
                  height: 26,
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
                left: 281,
                top: 589,
                child: Container(
                  width: 99,
                  height: 26,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFE3E0E0),
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
                left: 357,
                top: 589,
                child: Container(
                  width: 30,
                  height: 26,
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
                left: 281,
                top: 639,
                child: Container(
                  width: 106,
                  height: 26,
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
                left: 357,
                top: 639,
                child: Container(
                  width: 30,
                  height: 26,
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
                left: 281,
                top: 614,
                child: Container(
                  width: 106,
                  height: 26,
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
                left: 357,
                top: 614,
                child: Container(
                  width: 30,
                  height: 26,
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
                left: 281,
                top: 664,
                child: Container(
                  width: 106,
                  height: 26,
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
                left: 357,
                top: 664,
                child: Container(
                  width: 30,
                  height: 26,
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
                left: 281,
                top: 689,
                child: Container(
                  width: 99,
                  height: 26,
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
                left: 357,
                top: 689,
                child: Container(
                  width: 30,
                  height: 26,
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
                left: 119,
                top: 723,
                child: Container(
                  width: 175,
                  height: 25,
                  decoration: ShapeDecoration(
                    color: const Color(0xFF3998FC),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 245,
                top: 522,
                child: Container(
                  width: 142,
                  height: 27,
                  decoration: ShapeDecoration(
                    color: const Color(0xFF3998FC),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 23,
                top: 351,
                child: Container(
                  width: 111,
                  height: 27,
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
                left: 23,
                top: 383,
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
                left: 23,
                top: 493,
                child: Container(
                  width: 363,
                  height: 24,
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 1,
                        color: const Color(0xFFA8A8A8),
                      ),
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 326,
                top: 383,
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
                left: 134,
                top: 351,
                child: Container(
                  width: 150,
                  height: 27,
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
                left: 151,
                top: 69,
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
                left: 23,
                top: 197,
                child: Container(
                  width: 181,
                  height: 75,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFE0ECFA),
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
                left: 28,
                top: 205,
                child: Container(
                  width: 48,
                  height: 37,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(AppAssets.penTotalTersedia),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 23,
                top: 284,
                child: Container(
                  width: 181,
                  height: 57,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFE0ECFC),
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
                left: 212,
                top: 284,
                child: Container(
                  width: 181,
                  height: 57,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFFEE7C8),
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
                left: 212,
                top: 197,
                child: Container(
                  width: 180,
                  height: 75,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFE2EFE6),
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
                left: 186,
                top: 50,
                child: Container(
                  width: 73,
                  height: 66,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(AppAssets.penJudul),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 349,
                top: 134,
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
                left: 357,
                top: 139,
                child: SizedBox(
                  width: 29,
                  height: 31,
                  child: const Icon(
                    Icons.settings,
                    size: 26,
                    color: Color(0xFF8D8D8D),
                  ),
                ),
              ),
              Positioned(
                left: 35,
                top: 211,
                child: Container(
                  width: 33,
                  height: 33,
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(
                        width: 1,
                        color: Color(0xFFB9B8B8),
                      ),
                    ),
                  ),
                  child: const Icon(
                    Icons.search,
                    size: 20,
                    color: Color(0xFF7F7F7F),
                  ),
                ),
              ),
              Positioned(
                left: 28,
                top: 297,
                child: Container(
                  width: 48,
                  height: 37,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(AppAssets.penRestok),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 219,
                top: 205,
                child: Container(
                  width: 34,
                  height: 34,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(AppAssets.penBarangBaruHariIni),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 219,
                top: 297,
                child: Container(
                  width: 34,
                  height: 34,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(AppAssets.penPerbaikan),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 387,
                top: 559,
                child: Container(
                  transform: Matrix4.identity()..translate(0.0, 0.0)..rotateZ(3.14),
                  width: 364,
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
                left: 320,
                top: 448,
                child: Container(
                  width: 17,
                  height: 17,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(),
                  child: Stack(),
                ),
              ),
              Positioned(
                left: 89,
                top: 158,
                child: SizedBox(
                  width: 232,
                  height: 31,
                  child: Text(
                    'Penambahan Barang',
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
                left: 29,
                top: 388,
                child: Container(
                  width: 18,
                  height: 17,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(),
                  child: Stack(),
                ),
              ),
              Positioned(
                left: 65,
                top: 203,
                child: SizedBox(
                  width: 131,
                  height: 23,
                  child: Text(
                    'Total Barang Tersedia',
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
                left: 65,
                top: 304,
                child: SizedBox(
                  width: 100,
                  height: 23,
                  child: Text(
                    'Pending Restok',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 11,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 23,
                top: 357,
                child: SizedBox(
                  width: 111,
                  height: 23,
                  child: Text(
                    'Tambah Barang',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: const Color(0xFF3998FC),
                      fontSize: 11,
                      fontFamily: 'Phetsarath',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 27,
                top: 565,
                child: SizedBox(
                  width: 185,
                  height: 23,
                  child: Text(
                    'Riwayat Penambahan Stok',
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
                left: 257,
                top: 526,
                child: SizedBox(
                  width: 119,
                  height: 23,
                  child: Text(
                    'Tambah Barang',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontFamily: 'Phetsarath',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 146,
                top: 725,
                child: SizedBox(
                  width: 119,
                  height: 23,
                  child: Text(
                    'Lanjut',
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
                left: 48,
                top: 390,
                child: SizedBox(
                  width: 125,
                  height: 23,
                  child: Text(
                    'Cari barang, kategori... ',
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
                left: 28,
                top: 498,
                child: SizedBox(
                  width: 307,
                  height: 23,
                  child: Text(
                    'Contoh: Laptop merek Asus ROG Core i9 dengan RAM 8',
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
                left: 170,
                top: 420,
                child: SizedBox(
                  width: 84,
                  height: 23,
                  child: Text(
                    'Nama Barang',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: const Color(0xFF7F7F7F),
                      fontSize: 12,
                      fontFamily: 'Phetsarath',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 43,
                top: 251,
                child: SizedBox(
                  width: 134,
                  height: 23,
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: '+55',
                          style: TextStyle(
                            color: const Color(0xFF00E5FF),
                            fontSize: 10,
                            fontFamily: 'Phetsarath',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        TextSpan(
                          text: ' sejak minggu lalu',
                          style: TextStyle(
                            color: const Color(0xFF7F7F7F),
                            fontSize: 10,
                            fontFamily: 'Phetsarath',
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
                left: 241,
                top: 244,
                child: SizedBox(
                  width: 152,
                  height: 23,
                  child: Text(
                    'Terakhir Ditambah 5 jam lalu',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: const Color(0xFF013782),
                      fontSize: 10,
                      fontFamily: 'Phetsarath',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 162,
                top: 474,
                child: SizedBox(
                  width: 78,
                  height: 23,
                  child: Text(
                    'Stok Perkiraan',
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
                left: 25,
                top: 466,
                child: SizedBox(
                  width: 124,
                  height: 23,
                  child: Text(
                    'Tambahkan Foto Barang',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 9,
                      fontFamily: 'Phetsarath',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 170,
                top: 449,
                child: SizedBox(
                  width: 61,
                  height: 23,
                  child: Text(
                    'Elektronik',
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
                left: 29,
                top: 593,
                child: SizedBox(
                  width: 84,
                  height: 23,
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
                left: 58,
                top: 619,
                child: SizedBox(
                  width: 45,
                  height: 23,
                  child: Text(
                    'Mouse',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                      fontFamily: 'Phetsarath',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 188,
                top: 620,
                child: SizedBox(
                  width: 81,
                  height: 23,
                  child: Text(
                    'Melissa Putri',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                      fontFamily: 'Phetsarath',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 361,
                top: 619,
                child: SizedBox(
                  width: 22,
                  height: 23,
                  child: Text(
                    '10',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                      fontFamily: 'Phetsarath',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 339,
                top: 447,
                child: SizedBox(
                  width: 22,
                  height: 23,
                  child: Text(
                    '10',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontFamily: 'Outfit',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 344,
                top: 202,
                child: SizedBox(
                  width: 38,
                  height: 23,
                  child: Text(
                    '15',
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
                left: 346,
                top: 290,
                child: SizedBox(
                  width: 38,
                  height: 23,
                  child: Text(
                    '2',
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
                left: 161,
                top: 290,
                child: SizedBox(
                  width: 38,
                  height: 23,
                  child: Text(
                    '5',
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
                left: 132,
                top: 216,
                child: SizedBox(
                  width: 61,
                  height: 23,
                  child: Text(
                    '225',
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
                left: 62,
                top: 217,
                child: SizedBox(
                  width: 61,
                  height: 23,
                  child: Text(
                    '225',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontFamily: 'Outfit',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 223,
                top: 471,
                child: SizedBox(
                  width: 61,
                  height: 23,
                  child: Text(
                    '225',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontFamily: 'Outfit',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 361,
                top: 645,
                child: SizedBox(
                  width: 22,
                  height: 23,
                  child: Text(
                    '6',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                      fontFamily: 'Phetsarath',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 361,
                top: 669,
                child: SizedBox(
                  width: 22,
                  height: 23,
                  child: Text(
                    '8',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                      fontFamily: 'Phetsarath',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 361,
                top: 694,
                child: SizedBox(
                  width: 22,
                  height: 23,
                  child: Text(
                    '2',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                      fontFamily: 'Phetsarath',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 189,
                top: 644,
                child: SizedBox(
                  width: 57,
                  height: 23,
                  child: Text(
                    'Putri Ayu',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                      fontFamily: 'Phetsarath',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 186,
                top: 669,
                child: SizedBox(
                  width: 77,
                  height: 23,
                  child: Text(
                    'Budi Agung',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                      fontFamily: 'Phetsarath',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 187,
                top: 694,
                child: SizedBox(
                  width: 83,
                  height: 23,
                  child: Text(
                    'Bintang Audi',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                      fontFamily: 'Phetsarath',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 60,
                top: 645,
                child: SizedBox(
                  width: 45,
                  height: 23,
                  child: Text(
                    'Printer',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                      fontFamily: 'Phetsarath',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 57,
                top: 669,
                child: SizedBox(
                  width: 57,
                  height: 23,
                  child: Text(
                    'Monitor',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                      fontFamily: 'Phetsarath',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 59,
                top: 694,
                child: SizedBox(
                  width: 45,
                  height: 23,
                  child: Text(
                    'Server',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                      fontFamily: 'Phetsarath',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 119,
                top: 593,
                child: SizedBox(
                  width: 61,
                  height: 23,
                  child: Text(
                    'Kategori',
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
                left: 118,
                top: 619,
                child: SizedBox(
                  width: 61,
                  height: 23,
                  child: Text(
                    'Elektronik',
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
                left: 276,
                top: 620,
                child: SizedBox(
                  width: 84,
                  height: 23,
                  child: Text(
                    '5 Maret 2024',
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
                left: 280,
                top: 645,
                child: SizedBox(
                  width: 77,
                  height: 23,
                  child: Text(
                    '2 Maret 2024',
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
                left: 285,
                top: 669,
                child: SizedBox(
                  width: 61,
                  height: 23,
                  child: Text(
                    '29 Feb 2024',
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
                left: 285,
                top: 694,
                child: SizedBox(
                  width: 61,
                  height: 23,
                  child: Text(
                    '28 Feb 2024',
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
                left: 118,
                top: 645,
                child: SizedBox(
                  width: 61,
                  height: 23,
                  child: Text(
                    'Elektronik',
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
                left: 118,
                top: 669,
                child: SizedBox(
                  width: 61,
                  height: 23,
                  child: Text(
                    'Elektronik',
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
                left: 118,
                top: 694,
                child: SizedBox(
                  width: 61,
                  height: 23,
                  child: Text(
                    'Elektronik',
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
                left: 181,
                top: 594,
                child: SizedBox(
                  width: 104,
                  height: 23,
                  child: Text(
                    'Ditambahkan Oleh',
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
                left: 278,
                top: 590,
                child: SizedBox(
                  width: 84,
                  height: 23,
                  child: Text(
                    'Ditambahkan Tanggal',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 9,
                      fontFamily: 'Phetsarath',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 355,
                top: 594,
                child: SizedBox(
                  width: 34,
                  height: 23,
                  child: Text(
                    'Jum',
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
                left: 134,
                top: 357,
                child: SizedBox(
                  width: 150,
                  height: 23,
                  child: Text(
                    'History Penambahan',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 11,
                      fontFamily: 'Phetsarath',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 332,
                top: 387,
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
                left: 258,
                top: 205,
                child: SizedBox(
                  width: 100,
                  height: 23,
                  child: Text(
                    'Barang Baru\nHari Ini',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 11,
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
                  width: 100,
                  height: 23,
                  child: Text(
                    'Barang Rusak/\nPerlu Perbaikan',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 11,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 30,
                top: 614,
                child: Container(
                  width: 25,
                  height: 25,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(AppAssets.penMouse),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 30,
                top: 639,
                child: Container(
                  width: 25,
                  height: 25,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(AppAssets.penPrinter),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 30,
                top: 666,
                child: Container(
                  width: 28,
                  height: 24,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(AppAssets.penPerbaikan),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 52,
                top: 406,
                child: Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(AppAssets.penTambahFoto),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 28,
                top: 690,
                child: Container(
                  width: 25,
                  height: 25,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(AppAssets.penMonitor),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 36,
                top: 376,
                child: Container(
                  width: 86,
                  height: 3,
                  decoration: ShapeDecoration(
                    color: const Color(0xFF3998FC),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
              ),

              // Tombol "Tambah Barang" — navigasi ke form tambah barang
              Positioned(
                left: 245,
                top: 522,
                child: GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const DetailPenambahanBarangAdmin(),
                    ),
                  ),
                  child: Container(
                    width: 142,
                    height: 30,
                    color: Colors.transparent,
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