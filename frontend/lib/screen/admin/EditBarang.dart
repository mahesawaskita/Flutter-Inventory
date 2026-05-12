import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:frontend/service/api_service.dart';
import 'package:frontend/service/auth_service.dart';

class EditBarangAdmin extends StatefulWidget {
  final Map<String, dynamic> item;

  const EditBarangAdmin({super.key, required this.item});

  @override
  State<EditBarangAdmin> createState() => _EditBarangAdminState();
}

class _EditBarangAdminState extends State<EditBarangAdmin> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _stockController;
  late final TextEditingController _descController;

  List<Map<String, dynamic>> _categories = [];
  Map<String, dynamic>? _selectedCategory;
  String _selectedCondition = 'Tersedia';
  bool _isLoadingCategories = true;
  bool _isSaving = false;

  static const _conditions = [
    'Tersedia',
    'Dipinjam',
    'Rusak',
    'Perlu Perbaikan',
  ];

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.item['name']?.toString() ?? '');
    _stockController = TextEditingController(text: widget.item['stock']?.toString() ?? '0');
    _descController = TextEditingController(text: widget.item['description']?.toString() ?? '');

    final condition = widget.item['condition']?.toString() ?? 'Tersedia';
    _selectedCondition = _conditions.contains(condition) ? condition : 'Tersedia';

    _loadCategories();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _stockController.dispose();
    _descController.dispose();
    super.dispose();
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
            final itemCatId = widget.item['category_id'];
            _selectedCategory = cats.firstWhere(
              (c) => c['id'].toString() == itemCatId.toString(),
              orElse: () => cats.isNotEmpty ? cats.first : {},
            );
            if (_selectedCategory!.isEmpty) _selectedCategory = null;
          });
        }
      }
    } catch (_) {
      // kategori tetap kosong
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

      final id = (widget.item['id'] as num).toInt();
      final ok = await ApiService.updateItem(token, id, data);

      if (!mounted) return;
      if (ok) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Barang berhasil diperbarui!'),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.of(context).pop(true);
      } else {
        _showError('Gagal memperbarui barang. Periksa koneksi ke server.');
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
            child: const Text('Simpan', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F7),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A1A1A),
        foregroundColor: Colors.white,
        title: const Text(
          'Edit Barang',
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
                                  initialValue: _selectedCategory,
                                  decoration: _inputDeco('Pilih kategori'),
                                  items: _categories
                                      .map((cat) => DropdownMenuItem(
                                            value: cat,
                                            child: Text(
                                              cat['name'].toString(),
                                              style: const TextStyle(fontSize: 14),
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
                      label: const Text('Tambah', style: TextStyle(fontSize: 12)),
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
                  initialValue: _selectedCondition,
                  decoration: _inputDeco(''),
                  items: _conditions
                      .map((c) => DropdownMenuItem(
                            value: c,
                            child: Text(c, style: const TextStyle(fontSize: 14)),
                          ))
                      .toList(),
                  onChanged: (val) {
                    if (val != null) setState(() => _selectedCondition = val);
                  },
                ),
              ]),

              const SizedBox(height: 12),

              _sectionCard(title: 'Deskripsi', children: [
                TextFormField(
                  controller: _descController,
                  maxLines: 4,
                  decoration: _inputDeco('Masukkan deskripsi barang...'),
                ),
              ]),

              const SizedBox(height: 24),

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
                      : const Text('Simpan Perubahan',
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
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
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
        borderSide: const BorderSide(color: Color(0xFF3998FC), width: 1.5),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Colors.red),
      ),
    );
  }
}
