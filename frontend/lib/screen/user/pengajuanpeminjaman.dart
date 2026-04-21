import 'package:flutter/material.dart';

class PengajuanPeminjamanUser extends StatelessWidget {
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
                left: 54.80,
                top: 78.75,
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
                    color: const Color(0xFFEDE2F0),
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
                    color: const Color(0xFFFBF0F8),
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
                child: Container(
                  width: 29,
                  height: 31,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage("https://placehold.co/29x31"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 82,
                top: 158,
                child: SizedBox(
                  width: 250,
                  height: 29,
                  child: Text(
                    'Pengajuan Peminjaman',
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
                left: 170,
                top: 75,
                child: Container(
                  width: 67,
                  height: 67,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage("https://placehold.co/67x67"),
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
                  height: 101,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFF1EEF5),
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
                left: 31,
                top: 206,
                child: Container(
                  width: 47,
                  height: 31,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage("https://placehold.co/47x31"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 77,
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
                left: 35,
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
                left: -18,
                top: 245,
                child: SizedBox(
                  width: 174,
                  height: 23,
                  child: Text(
                    'Laptop',
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
                left: 22,
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
                left: 200,
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
                left: 28,
                top: 314,
                child: Container(
                  width: 23,
                  height: 23,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage("https://placehold.co/23x23"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 216,
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
                left: 193,
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
                left: 92,
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
                left: 26,
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
                left: 248,
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
                left: 61,
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
                left: 0,
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
                left: 178,
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
                left: 22,
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
                left: 214,
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
                left: 28,
                top: 385,
                child: Container(
                  width: 22,
                  height: 22,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage("https://placehold.co/22x22"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 221,
                top: 385,
                child: Container(
                  width: 23,
                  height: 23,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage("https://placehold.co/23x23"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 31,
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
                left: 219,
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
                left: -17,
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
                left: 176,
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
                left: 22,
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
                left: 214,
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
                left: 171,
                top: 448,
                child: Container(
                  width: 26,
                  height: 26,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage("https://placehold.co/26x26"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: -52,
                top: 451,
                child: SizedBox(
                  width: 174,
                  height: 23,
                  child: Text(
                    '8',
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
                left: 177,
                top: 451,
                child: SizedBox(
                  width: 174,
                  height: 23,
                  child: Text(
                    'Rp. 8.000.000',
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
                left: 26,
                top: 483,
                child: Container(
                  width: 23,
                  height: 23,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage("https://placehold.co/23x23"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 35,
                top: 486,
                child: SizedBox(
                  width: 113,
                  height: 23,
                  child: Text(
                    'Nama Merek',
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
                left: 22,
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
                left: 26,
                top: 611,
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
                left: 33,
                top: 516,
                child: SizedBox(
                  width: 348,
                  height: 38,
                  child: Text(
                    'Laptop merek honor keluaran tahun 2019 dengan layar 12 inci.',
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
                left: 26,
                top: 581,
                child: Container(
                  width: 25,
                  height: 25,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage("https://placehold.co/25x25"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 26,
                top: 583,
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
                left: 386,
                top: 593,
                child: Container(
                  transform: Matrix4.identity()..translate(0.0, 0.0)..rotateZ(3.14),
                  width: 260,
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
                left: 178,
                top: 611,
                child: Container(
                  width: 214,
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
                left: 267,
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
                left: 243,
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
                left: 189,
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
                left: 386,
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
                left: 121,
                top: 712,
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
                left: 121,
                top: 712,
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
                left: 148,
                top: 718,
                child: SizedBox(
                  width: 119,
                  height: 30,
                  child: Text(
                    'Konfirmasi',
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
                left: 51,
                top: 611,
                child: Container(
                  width: 97,
                  height: 69,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage("https://placehold.co/97x69"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 136,
                top: 609,
                child: Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage("https://placehold.co/36x36"),
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