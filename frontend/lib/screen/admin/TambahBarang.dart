import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:frontend/service/api_service.dart';
import 'package:frontend/service/auth_service.dart';
import 'package:file_picker/file_picker.dart';

class DetailPenambahanBarangAdmin extends StatefulWidget {
  const DetailPenambahanBarangAdmin({super.key});

  @override
  State<DetailPenambahanBarangAdmin> createState() =>
      _DetailPenambahanBarangAdminState();
}

class _DetailPenambahanBarangAdminState
    extends State<DetailPenambahanBarangAdmin> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _stockController = TextEditingController();
  final _descController = TextEditingController();

  List<Map<String, dynamic>> _categories = [];
  Map<String, dynamic>? _selectedCategory;
  String _selectedCondition = 'Tersedia';
  bool _isLoadingCategories = true;
  bool _isSaving = false;
  File? _imageFile;

  static const _conditions = [
    'Tersedia',
    'Dipinjam',
    'Rusak',
    'Perlu Perbaikan',
  ];

  @override
  void initState() {
    super.initState();
    _loadCategories();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _stockController.dispose();
    _descController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.image,
        allowMultiple: false,
      );
      if (result != null && result.files.single.path != null && mounted) {
        setState(() => _imageFile = File(result.files.single.path!));
      }
    } on PlatformException catch (e) {
      if (mounted) _showError('Gagal buka galeri: ${e.message}');
    } catch (e) {
      if (mounted) _showError('Gagal memilih gambar: $e');
    }
  }

  Future<void> _loadCategories() async {
    try {
      final token = await AuthService.getToken();
      if (token != null) {
        final result = await ApiService.getCategories(token);
        final cats = result.map((e) => Map<String, dynamic>.from(e)).toList();
        if (mounted) {
          setState(() {
            _categories = cats;
            if (cats.isNotEmpty) _selectedCategory = cats.first;
          });
        }
      }
    } catch (_) {
      // kategori kosong, user bisa ketik manual
    } finally {
      if (mounted) setState(() => _isLoadingCategories = false);
    }
  }

  Future<void> _saveItem() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSaving = true);
    try {
      final token = await AuthService.getToken();
      if (token == null) {
        _showError('Sesi berakhir. Silakan login ulang.');
        return;
      }

      final data = {
        'name': _nameController.text.trim(),
        'category_id': _selectedCategory?['id'],
        'stock': int.tryParse(_stockController.text.trim()) ?? 0,
        'description': _descController.text.trim(),
        'condition': _selectedCondition,
      };

      final ok = await ApiService.createItem(token, data, imagePath: _imageFile?.path);

      if (!mounted) return;
      if (ok) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Barang berhasil ditambahkan!'),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.of(context).pop();
      } else {
        _showError('Gagal menyimpan barang. Periksa koneksi ke server.');
      }
    } catch (e) {
      if (mounted) _showError('Error: $e');
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  void _showError(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg), backgroundColor: Colors.red),
    );
  }

  void _showAddCategoryDialog() {
    final ctrl = TextEditingController();
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Tambah Kategori Baru'),
        content: TextField(
          controller: ctrl,
          autofocus: true,
          textCapitalization: TextCapitalization.words,
          decoration: const InputDecoration(
            hintText: 'Nama kategori',
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () async {
              final name = ctrl.text.trim();
              if (name.isEmpty) return;
              final token = await AuthService.getToken();
              if (token == null) return;
              final ok = await ApiService.createCategory(token, name);
              if (!ctx.mounted) return;
              Navigator.pop(ctx);
              if (ok) {
                await _loadCategories();
                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Kategori berhasil ditambahkan'),
                      backgroundColor: Colors.green,
                    ),
                  );
                }
              }
            },
            style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF3998FC)),
            child:
                const Text('Simpan', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  // ─────────────────────────────────────────────
  // BUILD
  // ─────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F7),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A1A1A),
        foregroundColor: Colors.white,
        title: const Text(
          'Penambahan Barang',
          style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings, color: Colors.grey),
            onPressed: () {},
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _sectionCard(children: [
                // ── Foto Barang ──
                GestureDetector(
                  onTap: _pickImage,
                  child: Container(
                    width: double.infinity,
                    height: 150,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF5F5F5),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                          color: const Color(0xFFCCCCCC), width: 1.5),
                    ),
                    clipBehavior: Clip.hardEdge,
                    child: _imageFile != null
                        ? Stack(
                            fit: StackFit.expand,
                            children: [
                              Image.file(_imageFile!, fit: BoxFit.cover),
                              Positioned(
                                top: 6,
                                right: 6,
                                child: GestureDetector(
                                  onTap: () => setState(() => _imageFile = null),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.black54,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    padding: const EdgeInsets.all(4),
                                    child: const Icon(Icons.close,
                                        color: Colors.white, size: 18),
                                  ),
                                ),
                              ),
                            ],
                          )
                        : const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.camera_alt_outlined,
                                  size: 36, color: Colors.grey),
                              SizedBox(height: 8),
                              Text('Ketuk untuk tambahkan foto',
                                  style: TextStyle(
                                      fontSize: 13, color: Colors.grey)),
                              SizedBox(height: 4),
                              Text('Kamera atau Galeri',
                                  style: TextStyle(
                                      fontSize: 11, color: Color(0xFFAAAAAA))),
                            ],
                          ),
                  ),
                ),
              ]),

              const SizedBox(height: 12),

              // ── Informasi Barang ──
              _sectionCard(title: 'Informasi Barang', children: [
                _fieldLabel('Nama Barang *'),
                TextFormField(
                  controller: _nameController,
                  textCapitalization: TextCapitalization.words,
                  decoration: _inputDeco('Masukkan nama barang...'),
                  validator: (v) => (v == null || v.trim().isEmpty)
                      ? 'Nama barang wajib diisi'
                      : null,
                ),
                const SizedBox(height: 14),

                // ── Kategori ──
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _fieldLabel('Kategori'),
                          _isLoadingCategories
                              ? const SizedBox(
                                  height: 48,
                                  child: Center(
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      color: Color(0xFF3998FC),
                                    ),
                                  ),
                                )
                              : DropdownButtonFormField<Map<String, dynamic>>(
                                  value: _selectedCategory,
                                  decoration: _inputDeco('Pilih kategori'),
                                  items: _categories
                                      .map((cat) =>
                                          DropdownMenuItem(
                                            value: cat,
                                            child: Text(
                                              cat['name'].toString(),
                                              style: const TextStyle(
                                                  fontSize: 14),
                                            ),
                                          ))
                                      .toList(),
                                  onChanged: (val) =>
                                      setState(() => _selectedCategory = val),
                                ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton.icon(
                      onPressed: _showAddCategoryDialog,
                      icon: const Icon(Icons.add, size: 16),
                      label: const Text('Tambah',
                          style: TextStyle(fontSize: 12)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF3998FC),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 14),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                      ),
                    ),
                  ],
                ),
              ]),

              const SizedBox(height: 12),

              // ── Stok, Status, Harga ──
              _sectionCard(title: 'Detail Stok', children: [
                _fieldLabel('Stok'),
                TextFormField(
                  controller: _stockController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  decoration: _inputDeco('0'),
                ),
                const SizedBox(height: 14),
                _fieldLabel('Status / Kondisi'),
                DropdownButtonFormField<String>(
                  value: _selectedCondition,
                  decoration: _inputDeco(''),
                  items: _conditions
                      .map((c) => DropdownMenuItem(
                            value: c,
                            child: Text(c,
                                style: const TextStyle(fontSize: 14)),
                          ))
                      .toList(),
                  onChanged: (val) {
                    if (val != null) setState(() => _selectedCondition = val);
                  },
                ),
              ]),

              const SizedBox(height: 12),

              // ── Deskripsi ──
              _sectionCard(title: 'Deskripsi', children: [
                TextFormField(
                  controller: _descController,
                  maxLines: 4,
                  decoration: _inputDeco(
                      'Contoh: Laptop merek Asus ROG Core i9 dengan RAM 8 GB...'),
                ),
              ]),

              const SizedBox(height: 24),

              // ── Simpan button ──
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isSaving ? null : _saveItem,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF3998FC),
                    disabledBackgroundColor:
                        const Color(0xFF3998FC).withOpacity(0.5),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    padding: const EdgeInsets.symmetric(vertical: 15),
                  ),
                  child: _isSaving
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2.5,
                          ),
                        )
                      : const Text('Simpan',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                ),
              ),

              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  // ─────────────────────────────────────────────
  // HELPER WIDGETS
  // ─────────────────────────────────────────────

  Widget _sectionCard({String? title, required List<Widget> children}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 4,
              offset: const Offset(0, 1))
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null) ...[
            Text(title,
                style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1A1A1A))),
            const SizedBox(height: 12),
          ],
          ...children,
        ],
      ),
    );
  }

  Widget _fieldLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(text,
          style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: Color(0xFF444444))),
    );
  }

  InputDecoration _inputDeco(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: Color(0xFFAAAAAA), fontSize: 13),
      filled: true,
      fillColor: const Color(0xFFF8F8F8),
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Color(0xFFDDDDDD)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Color(0xFFDDDDDD)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide:
            const BorderSide(color: Color(0xFF3998FC), width: 1.5),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Colors.red),
      ),
    );
  }
}
