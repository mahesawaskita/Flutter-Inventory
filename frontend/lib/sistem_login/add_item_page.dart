import 'package:flutter/material.dart';
import '/service/api_service.dart';
import '/service/auth_service.dart';

class AddItemPage extends StatefulWidget {
  const AddItemPage({super.key});

  @override
  State<AddItemPage> createState() => _AddItemPageState();
}

class _AddItemPageState extends State<AddItemPage> {
  final nameController = TextEditingController();
  final stockController = TextEditingController();
  final descController = TextEditingController();

  bool isLoading = false;

  void handleSubmit() async {
    setState(() => isLoading = true);

    String? token = await AuthService.getToken();

    if (token == null) return;

    bool success = await ApiService.createItem(token, {
      "category_id": 1,
      "name": nameController.text,
      "description": descController.text,
      "stock": int.parse(stockController.text),
      "condition": "good"
    });

    setState(() => isLoading = false);

    if (success) {
      Navigator.pop(context, true); // kirim signal ke halaman sebelumnya
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Gagal tambah item")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Tambah Item")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: "Nama Barang"),
            ),
            TextField(
              controller: stockController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: "Stock"),
            ),
            TextField(
              controller: descController,
              decoration: const InputDecoration(labelText: "Deskripsi"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: isLoading ? null : handleSubmit,
              child: isLoading
                  ? const CircularProgressIndicator()
                  : const Text("Simpan"),
            )
          ],
        ),
      ),
    );
  }
}