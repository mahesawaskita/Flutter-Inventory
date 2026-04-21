import 'package:flutter/material.dart';

class DetailPerbaikanUser extends StatelessWidget {
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
                child: Container(
                  width: 389,
                  height: 646,
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
              Positioned(
                left: 159,
                top: 91,
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
                left: 121,
                top: 175,
                child: SizedBox(
                  width: 224,
                  height: 29,
                  child: Text(
                    'Detail Perbaikan',
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
                left: 27,
                top: 249,
                child: Container(
                  width: 359,
                  height: 463,
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
                top: 369,
                child: Container(
                  width: 348,
                  height: 244,
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
                left: 31,
                top: 390,
                child: Container(
                  width: 63,
                  height: 51,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage("https://placehold.co/63x51"),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 199,
                top: 320,
                child: Container(
                  width: 163,
                  height: 35,
                  decoration: ShapeDecoration(
                    color: const Color(0xFF3280FF),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 49,
                top: 321,
                child: Container(
                  width: 143,
                  height: 35,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFFEE9C3),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 217,
                top: 328,
                child: SizedBox(
                  width: 131,
                  height: 41,
                  child: Text(
                    'Riwayat Perbaikan',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 58,
                top: 330,
                child: SizedBox(
                  width: 154,
                  height: 42,
                  child: Text(
                    'Riwayat Peminjaman',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 96,
                top: 400,
                child: SizedBox(
                  width: 184,
                  height: 42,
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: 'Perbaikan hingga \n',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 10,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        TextSpan(
                          text: '28 Maret 2024',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 10,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 278,
                top: 393,
                child: SizedBox(
                  width: 184,
                  height: 42,
                  child: Text(
                    'Dalam perbaikan',
                    style: TextStyle(
                      color: const Color(0xFF6D6D6D),
                      fontSize: 10,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 278,
                top: 471,
                child: SizedBox(
                  width: 184,
                  height: 42,
                  child: Text(
                    'Perbaikan selesai',
                    style: TextStyle(
                      color: const Color(0xFF6D6D6D),
                      fontSize: 10,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 279,
                top: 535,
                child: SizedBox(
                  width: 184,
                  height: 42,
                  child: Text(
                    'Perbaikan selesai',
                    style: TextStyle(
                      color: const Color(0xFF6D6D6D),
                      fontSize: 10,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 31,
                top: 471,
                child: Container(
                  width: 63,
                  height: 51,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage("https://placehold.co/63x51"),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 96,
                top: 477,
                child: SizedBox(
                  width: 184,
                  height: 41,
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: 'Di perbaikan pada Tanggal \n',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 10,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        TextSpan(
                          text: '14 Maret 2024',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 10,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 31,
                top: 539,
                child: Container(
                  width: 63,
                  height: 51,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage("https://placehold.co/63x51"),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 96,
                top: 547,
                child: SizedBox(
                  width: 184,
                  height: 41,
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: 'Di perbaikan pada tanggal \n',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 10,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        TextSpan(
                          text: '15 Feb 2024',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 10,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 32,
                top: 463,
                child: Container(
                  width: 348,
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 1,
                        strokeAlign: BorderSide.strokeAlignCenter,
                        color: const Color(0xFFC5C5C5),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 32,
                top: 530,
                child: Container(
                  width: 348,
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 1,
                        strokeAlign: BorderSide.strokeAlignCenter,
                        color: const Color(0xFFC5C5C5),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 125,
                top: 673,
                child: Container(
                  width: 163,
                  height: 30,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFCFCDDE),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 259,
                top: 665,
                child: SizedBox(
                  width: 5,
                  height: 42,
                  child: Text(
                    '>',
                    style: TextStyle(
                      color: const Color(0xFF329CFA),
                      fontSize: 24,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 146,
                top: 677,
                child: SizedBox(
                  width: 132,
                  height: 42,
                  child: Text(
                    'Lihat Selengkapnya',
                    style: TextStyle(
                      color: const Color(0xFF329CFA),
                      fontSize: 11,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 251,
                top: 418,
                child: Container(
                  width: 120,
                  height: 23,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFB0D8A6),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                ),
              ),
              Positioned(
                left: 259,
                top: 497,
                child: Container(
                  width: 112,
                  height: 23,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFB0D8A6),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                ),
              ),
              Positioned(
                left: 259,
                top: 560,
                child: Container(
                  width: 112,
                  height: 23,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFB0D8A6),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                ),
              ),
              Positioned(
                left: 255,
                top: 421,
                child: SizedBox(
                  width: 184,
                  height: 42,
                  child: Text(
                    'Sedang Dalam Perbaikan',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 8.80,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 270,
                top: 500,
                child: SizedBox(
                  width: 184,
                  height: 42,
                  child: Text(
                    'Selesai Perbaikan',
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
                left: 268,
                top: 561,
                child: SizedBox(
                  width: 184,
                  height: 42,
                  child: Text(
                    'Selesai Perbaikan',
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
                left: 175,
                top: 99,
                child: Container(
                  width: 62,
                  height: 62,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage("https://placehold.co/62x62"),
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