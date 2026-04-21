import 'package:flutter/material.dart';
import '/service/api_service.dart';
import '/service/auth_service.dart';

class EditItemPage extends StatefulWidget {
  final Map item;

  const EditItemPage({super.key, required this.item});

  @override
  State<EditItemPage> createState() => _EditItemPageState();
}

class _EditItemPageState extends State<EditItemPage> {
  late TextEditingController nameController;
  late TextEditingController stockController;
  late TextEditingController descController;

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.item['name']);
    stockController =
        TextEditingController(text: widget.item['stock'].toString());
    descController =
        TextEditingController(text: widget.item['description'] ?? '');
  }

  void handleUpdate() async {
    setState(() => isLoading = true);

    String? token = await AuthService.getToken();
    if (token == null) return;

    bool success = await ApiService.updateItem(
      token,
      widget.item['id'],
      {
        "category_id": 1,
        "name": nameController.text,
        "description": descController.text,
        "stock": int.parse(stockController.text),
        "condition": "good"
      },
    );

    setState(() => isLoading = false);

    if (success) {
      Navigator.pop(context, true);
    }
  }

  void handleDelete() async {
    String? token = await AuthService.getToken();
    if (token == null) return;

    bool success =
        await ApiService.deleteItem(token, widget.item['id']);

    if (success) {
      Navigator.pop(context, true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Edit Item")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: "Nama"),
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
              onPressed: isLoading ? null : handleUpdate,
              child: isLoading
                  ? const CircularProgressIndicator()
                  : const Text("Update"),
            ),

            const SizedBox(height: 10),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              onPressed: handleDelete,
              child: const Text("Delete"),
            )
          ],
        ),
      ),
    );
  }
}