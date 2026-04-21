import 'package:flutter/material.dart';

class PengajuanPeminjamanUserScreen extends StatelessWidget {
  const PengajuanPeminjamanUserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEAEAEA),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // 🔙 BACK BUTTON
              Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {},
                ),
              ),

              // 📦 HEADER ICON
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.inventory, size: 40),
              ),

              const SizedBox(height: 10),

              // 🧾 CARD UTAMA
              Container(
                margin: const EdgeInsets.all(16),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFFD6CED9),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // TITLE
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Pengajuan Peminjaman",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const Icon(Icons.settings),
                      ],
                    ),

                    const SizedBox(height: 16),

                    // NAMA BARANG
                    const Text("Nama Barang"),
                    const SizedBox(height: 6),
                    TextField(
                      decoration: InputDecoration(
                        hintText: "Laptop",
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    // KATEGORI + BUTTON
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Row(
                              children: [
                                Icon(Icons.category),
                                SizedBox(width: 8),
                                Text("Kategori"),
                                Spacer(),
                                Icon(Icons.keyboard_arrow_down),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        ElevatedButton.icon(
                          onPressed: () {},
                          icon: const Icon(Icons.add),
                          label: const Text("Tambah"),
                        )
                      ],
                    ),

                    const SizedBox(height: 16),

                    // STATUS & STOK
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              labelText: "Stok",
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              labelText: "Harga",
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),

                    // DESKRIPSI
                    const Text("Deskripsi"),
                    const SizedBox(height: 6),
                    TextField(
                      maxLines: 3,
                      decoration: InputDecoration(
                        hintText: "Masukkan deskripsi...",
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    // FOTO
                    Row(
                      children: [
                        Container(
                          width: 100,
                          height: 80,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(Icons.image),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Container(
                            height: 80,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Center(
                              child: Icon(Icons.add),
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    // BUTTON
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {},
                        child: const Text("Konfirmasi"),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}