import 'package:flutter/material.dart';

class ProfilUser extends StatelessWidget {
  const ProfilUser({super.key});

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
                left: 9,
                top: 119,
                child: Container(
                  width: 394,
                  height: 102,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFFDF3FB),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 35,
                top: 145,
                child: Container(
                  width: 53,
                  height: 53,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(),
                  child: Stack(),
                ),
              ),
              Positioned(
                left: 97,
                top: 140,
                child: SizedBox(
                  width: 160,
                  height: 32,
                  child: Text(
                    'Muhammad Riza\n',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 97,
                top: 185,
                child: SizedBox(
                  width: 112,
                  height: 30,
                  child: Text(
                    'No. 2390343091',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 13,
                      fontStyle: FontStyle.italic,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 12,
                top: 495,
                child: Container(
                  width: 190,
                  height: 60,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFFCF2FA),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 114,
                top: 505,
                child: SizedBox(
                  width: 92,
                  height: 37,
                  child: Text(
                    'Data\nPribadi',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 218,
                top: 495,
                child: Container(
                  width: 186,
                  height: 60,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFFCF2FA),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 12,
                top: 568,
                child: Container(
                  width: 190,
                  height: 60,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFFCF2FA),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 218,
                top: 568,
                child: Container(
                  width: 186,
                  height: 60,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFFAF3FA),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 21,
                top: 482,
                child: Container(
                  width: 86,
                  height: 86,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage("https://placehold.co/86x86"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 237,
                top: 498,
                child: Container(
                  width: 55,
                  height: 55,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage("https://placehold.co/55x55"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 302,
                top: 504,
                child: SizedBox(
                  width: 95,
                  height: 34,
                  child: Text(
                    'Data\nPassword',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 303,
                top: 586,
                child: SizedBox(
                  width: 55,
                  height: 16,
                  child: Text(
                    'Logout',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 26,
                top: 282,
                child: SizedBox(
                  width: 92,
                  height: 15,
                  child: Text(
                    'Menu Profil',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 29,
                top: 313,
                child: SizedBox(
                  width: 78,
                  height: 17,
                  child: Text(
                    'Email',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 13,
                      fontStyle: FontStyle.italic,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 233,
                top: 322,
                child: SizedBox(
                  width: 164,
                  height: 15,
                  child: Text(
                    'production@gmail.com',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 13,
                      fontStyle: FontStyle.italic,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 29,
                top: 338,
                child: SizedBox(
                  width: 78,
                  height: 17,
                  child: Text(
                    'No. Telepon',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 13,
                      fontStyle: FontStyle.italic,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 296,
                top: 347,
                child: SizedBox(
                  width: 90,
                  height: 15,
                  child: Text(
                    '+62 858 2563',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 13,
                      fontStyle: FontStyle.italic,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 29,
                top: 361,
                child: SizedBox(
                  width: 78,
                  height: 17,
                  child: Text(
                    'Jabatan',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 13,
                      fontStyle: FontStyle.italic,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 292,
                top: 372,
                child: SizedBox(
                  width: 94,
                  height: 15,
                  child: Text(
                    'Staff Gudang',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 13,
                      fontStyle: FontStyle.italic,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 353,
                top: 393,
                child: SizedBox(
                  width: 33,
                  height: 15,
                  child: Text(
                    '2024',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 13,
                      fontStyle: FontStyle.italic,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 29,
                top: 392,
                child: SizedBox(
                  width: 114,
                  height: 16,
                  child: Text(
                    'Bergabung Sejak',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 13,
                      fontStyle: FontStyle.italic,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 33,
                top: 561,
                child: Container(
                  width: 57,
                  height: 57,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage("https://placehold.co/57x57"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 110,
                top: 579,
                child: SizedBox(
                  width: 92,
                  height: 37,
                  child: Text(
                    'Riwayat\nAktivitas',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 231,
                top: 573,
                child: Container(
                  width: 52,
                  height: 52,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage("https://placehold.co/52x52"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 296,
                top: 143,
                child: Container(
                  width: 82,
                  height: 18,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFD5D2DD),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                  ),
                ),
              ),
              Positioned(
                left: 296,
                top: 143,
                child: SizedBox(
                  width: 80,
                  height: 18,
                  child: Text(
                    'Edit Profil',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: const Color(0xFF201F1F),
                      fontSize: 13,
                      fontStyle: FontStyle.italic,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 54.80,
                top: 79.75,
                child: Container(
                  transform: Matrix4.identity()..translate(0.0, 0.0)..rotateZ(3.11),
                  width: 32.77,
                  height: 32.77,
                  child: Stack(),
                ),
              ),
              Positioned(
                left: 97,
                top: 169,
                child: Container(
                  width: 9,
                  height: 9,
                  decoration: ShapeDecoration(
                    color: const Color(0xFF07FF02),
                    shape: OvalBorder(),
                  ),
                ),
              ),
              Positioned(
                left: 116,
                top: 163,
                child: SizedBox(
                  width: 57,
                  height: 17,
                  child: Text(
                    'User',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
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