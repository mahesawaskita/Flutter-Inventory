import 'package:flutter/material.dart';
import 'package:lemigas/constants/app_assets.dart';

class DetailPenambahanBarangAdmin extends StatefulWidget {
  const DetailPenambahanBarangAdmin({super.key});

  @override
  State<DetailPenambahanBarangAdmin> createState() => _DetailPenambahanBarangAdminState();
}

class _DetailPenambahanBarangAdminState extends State<DetailPenambahanBarangAdmin> {
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
                left: 117,
                top: 710,
                child: Container(
                  width: 175,
                  height: 40,
                  decoration: ShapeDecoration(
                    color: const Color(0xFF0E62BC),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 145,
                top: 611,
                child: Container(
                  width: 124,
                  height: 69,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFF5F3F8),
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
                left: 23,
                top: 308,
                child: Container(
                  width: 171,
                  height: 39,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFE0E8FA),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                ),
              ),
              Positioned(
                left: 201,
                top: 308,
                child: Container(
                  width: 192,
                  height: 39,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFEFEEF3),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                ),
              ),
              Positioned(
                left: 23,
                top: 379,
                child: Container(
                  width: 178,
                  height: 34,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFF5F3F8),
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
                left: 23,
                top: 444,
                child: Container(
                  width: 178,
                  height: 34,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFF5F3F8),
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
                left: 215,
                top: 444,
                child: Container(
                  width: 178,
                  height: 34,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFF5F3F8),
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
                left: 215,
                top: 379,
                child: Container(
                  width: 178,
                  height: 34,
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
                left: 117,
                top: 710,
                child: Container(
                  width: 175,
                  height: 33,
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
                top: 509,
                child: Container(
                  width: 370,
                  height: 66,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFF5F3F8),
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
                left: 217,
                top: 314,
                child: Container(
                  width: 171,
                  height: 27,
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
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
                  width: 370,
                  height: 101,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFFCE3E6),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 1,
                        color: const Color(0xFFFD8F8F),
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 36,
                top: 241,
                child: Container(
                  width: 347,
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
                left: 186,
                top: 50,
                child: Container(
                  width: 73,
                  height: 66,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(),
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
                left: 387,
                top: 593,
                child: Container(
                  transform: Matrix4.identity()..translate(0.0, 0.0)..rotateZ(3.14),
                  width: 250,
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
                left: 387,
                top: 696,
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
                left: 144,
                top: 715,
                child: SizedBox(
                  width: 119,
                  height: 30,
                  child: Text(
                    'Simpan',
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
                left: 42,
                top: 245,
                child: SizedBox(
                  width: 174,
                  height: 23,
                  child: Text(
                    'Masukkan nama barang...',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: const Color(0xFF7F7F7F),
                      fontSize: 13,
                      fontFamily: 'Phetsarath',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 16,
                top: 451,
                child: SizedBox(
                  width: 174,
                  height: 23,
                  child: Text(
                    'Masukkan jumlah stok.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: const Color(0xFF7F7F7F),
                      fontSize: 13,
                      fontFamily: 'Phetsarath',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 32,
                top: 516,
                child: SizedBox(
                  width: 190,
                  height: 23,
                  child: Text(
                    'Masukkan deskripsi barang...',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: const Color(0xFF7F7F7F),
                      fontSize: 13,
                      fontFamily: 'Phetsarath',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 112,
                top: 657,
                child: SizedBox(
                  width: 190,
                  height: 23,
                  child: Text(
                    '+ Tambah Foto',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: const Color(0xFF494949),
                      fontSize: 13,
                      fontFamily: 'Phetsarath',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 217,
                top: 451,
                child: SizedBox(
                  width: 174,
                  height: 23,
                  child: Text(
                    'Masukkan harga barang...',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: const Color(0xFF7F7F7F),
                      fontSize: 13,
                      fontFamily: 'Phetsarath',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 62,
                top: 320,
                child: SizedBox(
                  width: 174,
                  height: 23,
                  child: Text(
                    'Gadget',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: const Color(0xFF393939),
                      fontSize: 12,
                      fontFamily: 'Phetsarath',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 93,
                top: 316,
                child: SizedBox(
                  width: 174,
                  height: 23,
                  child: Text(
                    '>',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: const Color(0xFF393939),
                      fontSize: 15,
                      fontFamily: 'Phetsarath',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 35,
                top: 275,
                child: SizedBox(
                  width: 174,
                  height: 23,
                  child: Text(
                    'Nama barang harus diisi!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: const Color(0xFFFF0000),
                      fontSize: 11,
                      fontFamily: 'Phetsarath',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 190,
                top: 55,
                child: SizedBox(
                  width: 81,
                  height: 23,
                  child: Text(
                    '+',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: const Color(0xFF00FFD0),
                      fontSize: 48,
                      fontFamily: 'Phetsarath',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 249,
                top: 318,
                child: SizedBox(
                  width: 113,
                  height: 23,
                  child: Text(
                    'Tambah Kategori',
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
                left: 27,
                top: 318,
                child: SizedBox(
                  width: 113,
                  height: 23,
                  child: Text(
                    'Kategori',
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
                left: 32,
                top: 387,
                child: SizedBox(
                  width: 113,
                  height: 23,
                  child: Text(
                    'Elektronik',
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
                left: 27,
                top: 486,
                child: SizedBox(
                  width: 113,
                  height: 23,
                  child: Text(
                    'Deskripsi',
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
                left: 36,
                top: 583,
                child: SizedBox(
                  width: 113,
                  height: 23,
                  child: Text(
                    'Foto Barang',
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
                left: 220,
                top: 387,
                child: SizedBox(
                  width: 113,
                  height: 23,
                  child: Text(
                    'Tersedia',
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
                left: 1,
                top: 356,
                child: SizedBox(
                  width: 113,
                  height: 23,
                  child: Text(
                    'Kategori',
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
                left: -16,
                top: 421,
                child: SizedBox(
                  width: 113,
                  height: 23,
                  child: Text(
                    'Stok',
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
                left: 179,
                top: 356,
                child: SizedBox(
                  width: 113,
                  height: 23,
                  child: Text(
                    'Status',
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
                left: 177,
                top: 421,
                child: SizedBox(
                  width: 113,
                  height: 23,
                  child: Text(
                    'Harga',
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
                left: 78,
                top: 209,
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
                left: 174,
                top: 74,
                child: Container(
                  width: 66,
                  height: 68,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(AppAssets.dpbJudul),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 32,
                top: 206,
                child: Container(
                  width: 47,
                  height: 31,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(AppAssets.dpbNama),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 190,
                top: 622,
                child: Container(
                  width: 33,
                  height: 33,
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
                left: 166,
                top: 606,
                child: SizedBox(
                  width: 81,
                  height: 23,
                  child: Text(
                    '+',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: const Color(0xFF04CCFF),
                      fontSize: 48,
                      fontFamily: 'Phetsarath',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 194,
                top: 306,
                child: SizedBox(
                  width: 81,
                  height: 23,
                  child: Text(
                    '+',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: const Color(0xFF4DDBFF),
                      fontSize: 32,
                      fontFamily: 'Phetsarath',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 358,
                top: 207,
                child: const SizedBox(
                  width: 25,
                  height: 25,
                  child: Icon(
                    Icons.arrow_drop_down,
                    size: 22,
                    color: Color(0xFF3998FC),
                  ),
                ),
              ),
              Positioned(
                left: 33,
                top: 273,
                child: Container(
                  width: 18,
                  height: 18,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(AppAssets.dpbTambahKategori),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 29,
                top: 314,
                child: Container(
                  width: 23,
                  height: 23,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(AppAssets.dpbKategori),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 29,
                top: 385,
                child: Container(
                  width: 22,
                  height: 22,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(AppAssets.dpbTersedia),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 172,
                top: 448,
                child: Container(
                  width: 26,
                  height: 26,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(AppAssets.dpbStok),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 222,
                top: 385,
                child: Container(
                  width: 23,
                  height: 23,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(AppAssets.dpbElektronik),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 27,
                top: 484,
                child: Container(
                  width: 25,
                  height: 25,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(AppAssets.dpbDeskripsi),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 23,
                top: 578,
                child: Container(
                  width: 29,
                  height: 29,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(AppAssets.dpbFotoBarang),
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