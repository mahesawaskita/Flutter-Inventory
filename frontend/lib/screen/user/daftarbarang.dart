import 'package:flutter/material.dart';

class DaftarBarangUser extends StatelessWidget {
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
                left: 288,
                top: 37,
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
                  height: 673,
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
                left: 28,
                top: 213,
                child: Container(
                  width: 124,
                  height: 75,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFE0E7FA),
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
                left: 159,
                top: 213,
                child: Container(
                  width: 98,
                  height: 75,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFFFF0DB),
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
                left: 263,
                top: 213,
                child: Container(
                  width: 124,
                  height: 75,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFFCE7E2),
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
                left: 132,
                top: 172,
                child: SizedBox(
                  width: 225,
                  height: 31,
                  child: Text(
                    'Daftar Barang',
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
                left: 36,
                top: 257,
                child: SizedBox(
                  width: 126,
                  height: 23,
                  child: Text(
                    'Barang',
                    textAlign: TextAlign.center,
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
                left: 201,
                top: 218,
                child: SizedBox(
                  width: 37,
                  height: 23,
                  child: Text(
                    '11',
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
                left: 304,
                top: 218,
                child: SizedBox(
                  width: 37,
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
                left: 70,
                top: 218,
                child: SizedBox(
                  width: 60,
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
                left: 199,
                top: 259,
                child: SizedBox(
                  width: 96,
                  height: 23,
                  child: Text(
                    'Barang',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 314,
                top: 259,
                child: SizedBox(
                  width: 96,
                  height: 23,
                  child: Text(
                    'Barang',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 171,
                top: 98,
                child: Container(
                  width: 71,
                  height: 63,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(),
                  child: Stack(),
                ),
              ),
              Positioned(
                left: 270,
                top: 232,
                child: Container(
                  width: 35,
                  height: 35,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage("https://placehold.co/35x35"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 28,
                top: 303,
                child: Container(
                  width: 135,
                  height: 36,
                  decoration: ShapeDecoration(
                    color: const Color(0xFF3479F8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 171,
                top: 303,
                child: Container(
                  width: 110,
                  height: 36,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFFBF6F8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 288,
                top: 303,
                child: Container(
                  width: 99,
                  height: 36,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFFBF6F8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 56,
                top: 311,
                child: SizedBox(
                  width: 132,
                  height: 32,
                  child: Text(
                    'Semua Barang',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 205,
                top: 311,
                child: SizedBox(
                  width: 132,
                  height: 32,
                  child: Text(
                    'Elektronik',
                    style: TextStyle(
                      color: const Color(0xFF878787),
                      fontSize: 12,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 187,
                top: 303,
                child: SizedBox(
                  width: 132,
                  height: 32,
                  child: Text(
                    'i',
                    style: TextStyle(
                      color: const Color(0xFF878787),
                      fontSize: 24,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 296,
                top: 303,
                child: SizedBox(
                  width: 132,
                  height: 32,
                  child: Text(
                    '+',
                    style: TextStyle(
                      color: const Color(0xFF878787),
                      fontSize: 24,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 315,
                top: 311,
                child: SizedBox(
                  width: 132,
                  height: 32,
                  child: Text(
                    'Demuana',
                    style: TextStyle(
                      color: const Color(0xFF878787),
                      fontSize: 12,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 51,
                top: 335,
                child: SizedBox(
                  width: 15,
                  height: 32,
                  child: Transform(
                    transform: Matrix4.identity()..translate(0.0, 0.0)..rotateZ(3.14),
                    child: Text(
                      '>',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 28,
                top: 353,
                child: Container(
                  width: 357,
                  height: 27,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFF7EDF8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 34,
                top: 356,
                child: Container(
                  width: 23,
                  height: 22,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(),
                  child: Stack(),
                ),
              ),
              Positioned(
                left: 5,
                top: 360,
                child: SizedBox(
                  width: 224,
                  height: 23,
                  child: Text(
                    'Cari nama barang...',
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
                left: 29,
                top: 390,
                child: Container(
                  width: 357,
                  height: 67,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFFAF0F8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 29,
                top: 460,
                child: Container(
                  width: 357,
                  height: 67,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFFAF0F8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 28,
                top: 529,
                child: Container(
                  width: 359,
                  height: 67,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFFAF0F8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 305,
                top: 543,
                child: Container(
                  width: 75,
                  height: 36,
                  decoration: ShapeDecoration(
                    color: const Color(0xFF3280FF),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                ),
              ),
              Positioned(
                left: 265,
                top: 512,
                child: Opacity(
                  opacity: 0.50,
                  child: Container(
                    width: 28,
                    height: 5,
                    decoration: ShapeDecoration(
                      color: const Color(0xFFB5B5B5),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 32,
                top: 395,
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
                left: 305,
                top: 406,
                child: Container(
                  width: 75,
                  height: 36,
                  decoration: ShapeDecoration(
                    color: const Color(0xFF3280FF),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                ),
              ),
              Positioned(
                left: 220,
                top: 411,
                child: Container(
                  width: 75,
                  height: 20,
                  decoration: ShapeDecoration(
                    color: const Color(0xFF74D294),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                  ),
                ),
              ),
              Positioned(
                left: 200,
                top: 479,
                child: Container(
                  width: 95,
                  height: 20,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFFDEDC7),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                ),
              ),
              Positioned(
                left: 220,
                top: 547,
                child: Container(
                  width: 75,
                  height: 20,
                  decoration: ShapeDecoration(
                    color: const Color(0xFF74D294),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                  ),
                ),
              ),
              Positioned(
                left: 314,
                top: 414,
                child: SizedBox(
                  width: 121,
                  height: 32,
                  child: Text(
                    'Detail',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 230,
                top: 412,
                child: SizedBox(
                  width: 121,
                  height: 32,
                  child: Text(
                    'Tersedia',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 230,
                top: 548,
                child: SizedBox(
                  width: 121,
                  height: 32,
                  child: Text(
                    'Tersedia',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 360,
                top: 406,
                child: SizedBox(
                  width: 5,
                  height: 32,
                  child: Text(
                    '>',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 314,
                top: 551,
                child: SizedBox(
                  width: 121,
                  height: 32,
                  child: Text(
                    'Detail',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 86,
                top: 464,
                child: SizedBox(
                  width: 184,
                  height: 32,
                  child: Text(
                    'Monitor',
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
                top: 395,
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
                top: 415,
                child: SizedBox(
                  width: 184,
                  height: 32,
                  child: Text(
                    'Bintang Audi',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 13,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 86,
                top: 483,
                child: SizedBox(
                  width: 184,
                  height: 32,
                  child: Text(
                    'Melissa Putri',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 13,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 86,
                top: 552,
                child: SizedBox(
                  width: 184,
                  height: 32,
                  child: Text(
                    'Budi Agung',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 13,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 86,
                top: 534,
                child: SizedBox(
                  width: 184,
                  height: 32,
                  child: Text(
                    'Printer',
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
                left: 360,
                top: 543,
                child: SizedBox(
                  width: 5,
                  height: 32,
                  child: Text(
                    '>',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 305,
                top: 476,
                child: Container(
                  width: 75,
                  height: 36,
                  decoration: ShapeDecoration(
                    color: const Color(0xFF3280FF),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                ),
              ),
              Positioned(
                left: 314,
                top: 484,
                child: SizedBox(
                  width: 75,
                  height: 32,
                  child: Text(
                    'Detail',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 206,
                top: 480,
                child: SizedBox(
                  width: 96,
                  height: 32,
                  child: Text(
                    'Hampir Habis',
                    style: TextStyle(
                      color: const Color(0xFF8C7A7A),
                      fontSize: 12,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 360,
                top: 476,
                child: SizedBox(
                  width: 5,
                  height: 32,
                  child: Text(
                    '>',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 230,
                top: 506,
                child: SizedBox(
                  width: 223,
                  height: 32,
                  child: Text(
                    '4 sisa',
                    style: TextStyle(
                      color: const Color(0xFF878787),
                      fontSize: 10,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 32,
                top: 531,
                child: Container(
                  width: 47,
                  height: 47,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage("https://placehold.co/47x47"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 28,
                top: 598,
                child: Container(
                  width: 359,
                  height: 67,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFFAF0F8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 235,
                top: 617,
                child: Container(
                  width: 60,
                  height: 20,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFFB8B7E),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                  ),
                ),
              ),
              Positioned(
                left: 305,
                top: 612,
                child: Container(
                  width: 75,
                  height: 36,
                  decoration: ShapeDecoration(
                    color: const Color(0xFF3280FF),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                ),
              ),
              Positioned(
                left: 247,
                top: 618,
                child: SizedBox(
                  width: 121,
                  height: 32,
                  child: Text(
                    'Habis',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 314,
                top: 620,
                child: SizedBox(
                  width: 121,
                  height: 32,
                  child: Text(
                    'Detail',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 86,
                top: 621,
                child: SizedBox(
                  width: 184,
                  height: 32,
                  child: Text(
                    'Putri Ayu',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 13,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 86,
                top: 603,
                child: SizedBox(
                  width: 184,
                  height: 32,
                  child: Text(
                    'Server',
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
                left: 360,
                top: 612,
                child: SizedBox(
                  width: 5,
                  height: 32,
                  child: Text(
                    '>',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 245,
                top: 644,
                child: SizedBox(
                  width: 223,
                  height: 32,
                  child: Text(
                    '0 trouble',
                    style: TextStyle(
                      color: const Color(0xFF878787),
                      fontSize: 10,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 28,
                top: 667,
                child: Container(
                  width: 359,
                  height: 67,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFFAF0F8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 200,
                top: 683,
                child: Container(
                  width: 95,
                  height: 20,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFFDEDC7),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                ),
              ),
              Positioned(
                left: 305,
                top: 681,
                child: Container(
                  width: 75,
                  height: 36,
                  decoration: ShapeDecoration(
                    color: const Color(0xFF3280FF),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                ),
              ),
              Positioned(
                left: 265,
                top: 719,
                child: Opacity(
                  opacity: 0.50,
                  child: Container(
                    width: 28,
                    height: 5,
                    decoration: ShapeDecoration(
                      color: const Color(0xFFB5B5B5),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 314,
                top: 689,
                child: SizedBox(
                  width: 121,
                  height: 32,
                  child: Text(
                    'Detail',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 86,
                top: 690,
                child: SizedBox(
                  width: 184,
                  height: 32,
                  child: Text(
                    'Ujang Lurah',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 13,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 86,
                top: 672,
                child: SizedBox(
                  width: 184,
                  height: 32,
                  child: Text(
                    'Mouse',
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
                left: 360,
                top: 681,
                child: SizedBox(
                  width: 5,
                  height: 32,
                  child: Text(
                    '>',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 230,
                top: 713,
                child: SizedBox(
                  width: 223,
                  height: 32,
                  child: Text(
                    '3 sisa',
                    style: TextStyle(
                      color: const Color(0xFF878787),
                      fontSize: 10,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 29,
                top: 661,
                child: Container(
                  width: 58,
                  height: 58,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage("https://placehold.co/58x58"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 36,
                top: 745,
                child: Container(
                  width: 342,
                  height: 59,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFF8F8F8),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(1)),
                  ),
                ),
              ),
              Positioned(
                left: 134,
                top: 757,
                child: Container(
                  width: 149,
                  height: 35,
                  decoration: ShapeDecoration(
                    color: const Color(0xFF3280FF),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.50),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 260,
                top: 757,
                child: SizedBox(
                  width: 5,
                  height: 32,
                  child: Text(
                    '>',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 150,
                top: 764,
                child: SizedBox(
                  width: 198,
                  height: 32,
                  child: Text(
                    'Pinjam Barang',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 206,
                top: 684,
                child: SizedBox(
                  width: 96,
                  height: 32,
                  child: Text(
                    'Hampir Habis',
                    style: TextStyle(
                      color: const Color(0xFF8C7A7A),
                      fontSize: 12,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 485,
                top: 462,
                child: Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage("https://placehold.co/42x42"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 486,
                top: 605,
                child: Container(
                  width: 38,
                  height: 38,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage("https://placehold.co/38x38"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 38,
                top: 605,
                child: Container(
                  width: 38,
                  height: 38,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage("https://placehold.co/38x38"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 37,
                top: 462,
                child: Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage("https://placehold.co/42x42"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 36,
                top: 232,
                child: Container(
                  width: 34,
                  height: 35,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage("https://placehold.co/34x35"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 168,
                top: 235,
                child: Container(
                  width: 29,
                  height: 30,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage("https://placehold.co/29x30"),
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