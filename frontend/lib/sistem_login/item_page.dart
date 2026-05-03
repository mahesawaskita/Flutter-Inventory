import 'package:flutter/material.dart';
import '/service/api_service.dart';
import '/service/auth_service.dart';
import 'login_page.dart';
import 'edit_item_page.dart';
import 'add_item_page.dart'; // ⬅️ WAJIB ADA

class ItemPage extends StatefulWidget {
  const ItemPage({super.key});

  @override
  State<ItemPage> createState() => _ItemPageState();
}

class _ItemPageState extends State<ItemPage> {
  List items = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchItems();
  }

  /// Ambil data item dari API
  void fetchItems() async {
    try {
      String? token = await AuthService.getToken();

      if (token == null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const LoginPage()),
        );
        return;
      }

      var data = await ApiService.getItems(token);

      setState(() {
        items = data;
        isLoading = false;
      });
    } catch (e) {
      print("ERROR: $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  /// Logout user dan kembali ke login
  void handleLogout() async {
    await AuthService.logout();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const LoginPage()),
    );
  }

  /// Navigasi ke halaman tambah item
  void goToAddItem() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const AddItemPage()),
    );

    if (result == true) {
      fetchItems(); // refresh setelah tambah
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Items'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: handleLogout,
          ),
        ],
      ),

      // 🔥 Floating Action Button
      floatingActionButton: FloatingActionButton(
        onPressed: goToAddItem,
        child: const Icon(Icons.add),
      ),

      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : items.isEmpty
              ? const Center(child: Text("Data kosong"))
              : ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(items[index]['name'] ?? '-'),
                      subtitle: Text("Stock: ${items[index]['stock'] ?? 0}"),
                      onTap: () async {
                        final result = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => EditItemPage(item: items[index]),
                          ),
                        );

                        if (result == true) {
                          fetchItems(); // refresh setelah edit/delete
                        }
                      },
                    );
                  },
                ),
    );
  }
}