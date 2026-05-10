import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:frontend/constants/app_assets.dart';
import 'package:frontend/service/api_service.dart';
import 'package:frontend/service/auth_service.dart';

class DetailPenambahanBarangAdmin extends StatefulWidget {
  const DetailPenambahanBarangAdmin({super.key});

  @override
  State<DetailPenambahanBarangAdmin> createState() =>
      _DetailPenambahanBarangAdminState();
}

class _DetailPenambahanBarangAdminState
    extends State<DetailPenambahanBarangAdmin> {
  final _nameController = TextEditingController();
  final _stockController = TextEditingController();
  final _priceController = TextEditingController();
  final _descController = TextEditingController();

  List<Map<String, dynamic>> _categories = [];
  String? _selectedCategoryId;
  String _selectedCategoryName = 'Pilih Kategori';
  String _selectedCondition = 'Tersedia';

  bool _isLoadingCategories = false;
  bool _isSaving = false;
  bool _nameError = false;

  static const _conditions = ['Tersedia', 'Dipinjam', 'Rusak', 'Perlu Perbaikan'];

  @override
  void initState() {
    super.initState();
    _loadCategories();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _stockController.dispose();
    _priceController.dispose();
    _descController.dispose();
    super.dispose();
  }

  Future<void> _loadCategories() async {
    setState(() => _isLoadingCategories = true);
    try {
      final token = await AuthService.getToken();
      if (token != null) {
        final result = await ApiService.getCategories(token);
        final cats = result.map((e) => Map<String, dynamic>.from(e)).toList();
        setState(() {
          _categories = cats;
          if (cats.isNotEmpty) {
            _selectedCategoryId = cats[0]['id'].toString();
            _selectedCategoryName = cats[0]['name'];
          }
        });
      }
    } catch (_) {
      // tampilkan kosong, user bisa coba lagi
    } finally {
      if (mounted) setState(() => _isLoadingCategories = false);
    }
  }

  void _showCategoryPicker() {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF2A2A2A),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: Text('Pilih Kategori',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold)),
            ),
            if (_isLoadingCategories)
              const Padding(
                padding: EdgeInsets.all(24),
                child: CircularProgressIndicator(color: Color(0xFF3998FC)),
              )
            else if (_categories.isEmpty)
              const Padding(
                padding: EdgeInsets.all(24),
                child: Text('Belum ada kategori',
                    style: TextStyle(color: Colors.grey)),
              )
            else
              ..._categories.map((cat) => ListTile(
                    title: Text(cat['name'],
                        style: const TextStyle(color: Colors.white)),
                    trailing: _selectedCategoryId == cat['id'].toString()
                        ? const Icon(Icons.check, color: Color(0xFF3998FC))
                        : null,
                    onTap: () {
                      setState(() {
                        _selectedCategoryId = cat['id'].toString();
                        _selectedCategoryName = cat['name'];
                      });
                      Navigator.pop(context);
                    },
                  )),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  void _showConditionPicker() {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF2A2A2A),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: Text('Pilih Status Barang',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold)),
            ),
            ..._conditions.map((cond) => ListTile(
                  title: Text(cond,
                      style: const TextStyle(color: Colors.white)),
                  trailing: _selectedCondition == cond
                      ? const Icon(Icons.check, color: Color(0xFF3998FC))
                      : null,
                  onTap: () {
                    setState(() => _selectedCondition = cond);
                    Navigator.pop(context);
                  },
                )),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  void _showAddCategoryDialog() {
    final ctrl = TextEditingController();
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF2A2A2A),
        title: const Text('Tambah Kategori',
            style: TextStyle(color: Colors.white)),
        content: TextField(
          controller: ctrl,
          autofocus: true,
          style: const TextStyle(color: Colors.black),
          decoration: const InputDecoration(
            hintText: 'Nama kategori baru',
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Batal', style: TextStyle(color: Colors.grey)),
          ),
          TextButton(
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
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('Kategori berhasil ditambahkan'),
                    backgroundColor: Colors.green,
                  ));
                }
              }
            },
            child: const Text('Simpan',
                style: TextStyle(color: Color(0xFF3998FC))),
          ),
        ],
      ),
    );
  }

  Future<void> _saveItem() async {
    final name = _nameController.text.trim();
    if (name.isEmpty) {
      setState(() => _nameError = true);
      return;
    }

    setState(() {
      _nameError = false;
      _isSaving = true;
    });

    try {
      final token = await AuthService.getToken();
      if (token == null) throw Exception('Sesi berakhir, silakan login ulang');

      final data = {
        'name': name,
        'category_id':
            _selectedCategoryId != null ? int.tryParse(_selectedCategoryId!) : null,
        'stock': int.tryParse(_stockController.text.trim()) ?? 0,
        'price': double.tryParse(_priceController.text.trim()) ?? 0,
        'description': _descController.text.trim(),
        'condition': _selectedCondition,
      };

      final ok = await ApiService.createItem(token, data);

      if (!mounted) return;
      if (ok) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Barang berhasil ditambahkan!'),
          backgroundColor: Colors.green,
        ));
        Navigator.of(context).pop();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Gagal menambahkan barang. Coba lagi.'),
          backgroundColor: Colors.red,
        ));
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error: $e'),
        backgroundColor: Colors.red,
      ));
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  // TextField transparan yang dioverlay di atas kotak input Figma
  Widget _inputField({
    required TextEditingController controller,
    required String hint,
    TextInputType keyboardType = TextInputType.text,
    List<TextInputFormatter>? inputFormatters,
    int maxLines = 1,
    void Function(String)? onChanged,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      maxLines: maxLines,
      onChanged: onChanged,
      style: const TextStyle(
          fontSize: 13, color: Color(0xFF1A1A1A), fontFamily: 'Phetsarath'),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(fontSize: 13, color: Color(0xFF7F7F7F)),
        border: InputBorder.none,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        isDense: true,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          child: SizedBox(
            width: constraints.maxWidth,
            child: FittedBox(
              fit: BoxFit.fitWidth,
              alignment: Alignment.topCenter,
              child: SizedBox(
                width: 414,
                height: 896,
                child: Container(
                  clipBehavior: Clip.antiAlias,
                  decoration:
                      const BoxDecoration(color: Color(0xFF1A1A1A)),
                  child: Stack(
                    children: [
                      // ── Visual: back arrow rotated container ──
                      Positioned(
                        left: 55.80,
                        top: 78.75,
                        child: Container(
                          transform: Matrix4.identity()
                            ..translate(0.0, 0.0)
                            ..rotateZ(3.11),
                          width: 32.77,
                          height: 32.77,
                          child: const Stack(),
                        ),
                      ),
                      // ── Visual: splash/logo bottom ──
                      Positioned(
                        left: 161,
                        top: 773,
                        child: Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(AppAssets.splash),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      // ── Visual: main white card ──
                      Positioned(
                        left: 6,
                        top: 115,
                        child: Container(
                          width: 402,
                          height: 652,
                          decoration: ShapeDecoration(
                            color: const Color(0xFFFFFBFB),
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(
                                  width: 6, color: Color(0xFFB0A0A0)),
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                      ),
                      // ── Visual: dark blue button bg ──
                      Positioned(
                        left: 117,
                        top: 710,
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
                      // ── Visual: foto area ──
                      Positioned(
                        left: 145,
                        top: 611,
                        child: Container(
                          width: 124,
                          height: 69,
                          decoration: ShapeDecoration(
                            color: const Color(0xFFF5F3F8),
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(
                                  width: 1, color: Color(0xFFABABAB)),
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ),
                      // ── Visual: kategori picker top (blue) ──
                      Positioned(
                        left: 23,
                        top: 308,
                        child: Container(
                          width: 171,
                          height: 39,
                          decoration: ShapeDecoration(
                            color: const Color(0xFFE0E8FA),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                          ),
                        ),
                      ),
                      // ── Visual: tambah kategori box (gray) ──
                      Positioned(
                        left: 201,
                        top: 308,
                        child: Container(
                          width: 192,
                          height: 39,
                          decoration: ShapeDecoration(
                            color: const Color(0xFFEFEEF3),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                          ),
                        ),
                      ),
                      // ── Visual: kategori dropdown field (left) ──
                      Positioned(
                        left: 23,
                        top: 379,
                        child: Container(
                          width: 178,
                          height: 34,
                          decoration: ShapeDecoration(
                            color: const Color(0xFFF5F3F8),
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(
                                  width: 1, color: Color(0xFFB1B1B1)),
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ),
                      // ── Visual: stok input box ──
                      Positioned(
                        left: 23,
                        top: 444,
                        child: Container(
                          width: 178,
                          height: 34,
                          decoration: ShapeDecoration(
                            color: const Color(0xFFF5F3F8),
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(
                                  width: 1, color: Color(0xFFB1B1B1)),
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ),
                      // ── Visual: harga input box ──
                      Positioned(
                        left: 215,
                        top: 444,
                        child: Container(
                          width: 178,
                          height: 34,
                          decoration: ShapeDecoration(
                            color: const Color(0xFFF5F3F8),
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(
                                  width: 1, color: Color(0xFFB1B1B1)),
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ),
                      // ── Visual: status dropdown field (right, white) ──
                      Positioned(
                        left: 215,
                        top: 379,
                        child: Container(
                          width: 178,
                          height: 34,
                          decoration: ShapeDecoration(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(
                                  width: 1, color: Color(0xFFB1B1B1)),
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ),
                      // ── Visual: blue save button overlay ──
                      Positioned(
                        left: 117,
                        top: 710,
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
                      // ── Visual: deskripsi textarea box ──
                      Positioned(
                        left: 23,
                        top: 509,
                        child: Container(
                          width: 370,
                          height: 66,
                          decoration: ShapeDecoration(
                            color: const Color(0xFFF5F3F8),
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(
                                  width: 1, color: Color(0xFFB1B1B1)),
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ),
                      // ── Visual: inside tambah kategori white pill ──
                      Positioned(
                        left: 217,
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
                      // ── Visual: header card border ──
                      Positioned(
                        left: 151,
                        top: 69,
                        child: Container(
                          width: 108,
                          height: 78,
                          decoration: ShapeDecoration(
                            color: const Color(0xFFFFFBFB),
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(
                                  width: 3, color: Color(0xFFB0A0A0)),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                      // ── Visual: validation error box (red bg) ──
                      Positioned(
                        left: 23,
                        top: 197,
                        child: Container(
                          width: 370,
                          height: 101,
                          decoration: ShapeDecoration(
                            color: const Color(0xFFFCE3E6),
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(
                                  width: 1, color: Color(0xFFFD8F8F)),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                      // ── Visual: nama input box ──
                      Positioned(
                        left: 36,
                        top: 241,
                        child: Container(
                          width: 347,
                          height: 27,
                          decoration: ShapeDecoration(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(
                                  width: 1, color: Color(0xFFA7A7A7)),
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                        ),
                      ),
                      // ── Visual: empty clip ──
                      Positioned(
                        left: 186,
                        top: 50,
                        child: Container(
                          width: 73,
                          height: 66,
                          clipBehavior: Clip.antiAlias,
                          decoration: const BoxDecoration(),
                        ),
                      ),
                      // ── Visual: settings circle ──
                      Positioned(
                        left: 349,
                        top: 134,
                        child: Container(
                          width: 44,
                          height: 40,
                          decoration: const ShapeDecoration(
                              color: Color(0xFFD9D9D9), shape: OvalBorder()),
                        ),
                      ),
                      // ── Visual: settings icon ──
                      const Positioned(
                        left: 357,
                        top: 139,
                        child: SizedBox(
                          width: 29,
                          height: 31,
                          child: Icon(Icons.settings,
                              size: 26, color: Color(0xFF8D8D8D)),
                        ),
                      ),
                      // ── Visual: divider lines ──
                      Positioned(
                        left: 387,
                        top: 593,
                        child: Container(
                          transform: Matrix4.identity()
                            ..translate(0.0, 0.0)
                            ..rotateZ(3.14),
                          width: 250,
                          decoration: const ShapeDecoration(
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                  width: 1,
                                  strokeAlign:
                                      BorderSide.strokeAlignCenter,
                                  color: Color(0xFF9E9E9E)),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 387,
                        top: 696,
                        child: Container(
                          transform: Matrix4.identity()
                            ..translate(0.0, 0.0)
                            ..rotateZ(3.14),
                          width: 364,
                          decoration: const ShapeDecoration(
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                  width: 1,
                                  strokeAlign:
                                      BorderSide.strokeAlignCenter,
                                  color: Color(0xFF9E9E9E)),
                            ),
                          ),
                        ),
                      ),
                      // ── Visual: foto oval plus circle ──
                      Positioned(
                        left: 190,
                        top: 622,
                        child: Container(
                          width: 33,
                          height: 33,
                          decoration: ShapeDecoration(
                            color: const Color(0xFFD9D9D9),
                            shape: OvalBorder(
                              side: const BorderSide(
                                  width: 1, color: Color(0xFFB1B1B1)),
                            ),
                          ),
                        ),
                      ),

                      // ── LABELS (text permanent) ──
                      Positioned(
                        left: 89,
                        top: 158,
                        child: const SizedBox(
                          width: 232,
                          height: 31,
                          child: Text('Penambahan Barang',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontFamily: 'Paytone One',
                                  fontWeight: FontWeight.w400)),
                        ),
                      ),
                      Positioned(
                        left: 78,
                        top: 209,
                        child: const SizedBox(
                          width: 107,
                          height: 23,
                          child: Text('Nama Barang',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontFamily: 'Phetsarath',
                                  fontWeight: FontWeight.w700)),
                        ),
                      ),
                      Positioned(
                        left: 27,
                        top: 318,
                        child: const SizedBox(
                          width: 113,
                          height: 23,
                          child: Text('Kategori',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 13,
                                  fontFamily: 'Phetsarath',
                                  fontWeight: FontWeight.w400)),
                        ),
                      ),
                      Positioned(
                        left: 249,
                        top: 318,
                        child: const SizedBox(
                          width: 113,
                          height: 23,
                          child: Text('Tambah Kategori',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 13,
                                  fontFamily: 'Phetsarath',
                                  fontWeight: FontWeight.w700)),
                        ),
                      ),
                      Positioned(
                        left: 1,
                        top: 356,
                        child: const SizedBox(
                          width: 113,
                          height: 23,
                          child: Text('Kategori',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400)),
                        ),
                      ),
                      Positioned(
                        left: 179,
                        top: 356,
                        child: const SizedBox(
                          width: 113,
                          height: 23,
                          child: Text('Status',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 13,
                                  fontFamily: 'Phetsarath',
                                  fontWeight: FontWeight.w700)),
                        ),
                      ),
                      Positioned(
                        left: -16,
                        top: 421,
                        child: const SizedBox(
                          width: 113,
                          height: 23,
                          child: Text('Stok',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400)),
                        ),
                      ),
                      Positioned(
                        left: 177,
                        top: 421,
                        child: const SizedBox(
                          width: 113,
                          height: 23,
                          child: Text('Harga',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 13,
                                  fontFamily: 'Phetsarath',
                                  fontWeight: FontWeight.w700)),
                        ),
                      ),
                      Positioned(
                        left: 27,
                        top: 486,
                        child: const SizedBox(
                          width: 113,
                          height: 23,
                          child: Text('Deskripsi',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 13,
                                  fontFamily: 'Phetsarath',
                                  fontWeight: FontWeight.w400)),
                        ),
                      ),
                      Positioned(
                        left: 36,
                        top: 583,
                        child: const SizedBox(
                          width: 113,
                          height: 23,
                          child: Text('Foto Barang',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 13,
                                  fontFamily: 'Phetsarath',
                                  fontWeight: FontWeight.w400)),
                        ),
                      ),
                      Positioned(
                        left: 112,
                        top: 657,
                        child: const SizedBox(
                          width: 190,
                          height: 23,
                          child: Text('+ Tambah Foto',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Color(0xFF494949),
                                  fontSize: 13,
                                  fontFamily: 'Phetsarath',
                                  fontWeight: FontWeight.w400)),
                        ),
                      ),
                      // "Simpan" button label
                      Positioned(
                        left: 144,
                        top: 715,
                        child: SizedBox(
                          width: 119,
                          height: 30,
                          child: _isSaving
                              ? const Center(
                                  child: SizedBox(
                                    width: 18,
                                    height: 18,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                      strokeWidth: 2,
                                    ),
                                  ),
                                )
                              : const Text('Simpan',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontFamily: 'Phetsarath',
                                      fontWeight: FontWeight.w700)),
                        ),
                      ),
                      // Decorative "+" icons
                      Positioned(
                        left: 190,
                        top: 55,
                        child: const SizedBox(
                          width: 81,
                          height: 23,
                          child: Text('+',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Color(0xFF00FFD0),
                                  fontSize: 48,
                                  fontFamily: 'Phetsarath',
                                  fontWeight: FontWeight.w700)),
                        ),
                      ),
                      Positioned(
                        left: 166,
                        top: 606,
                        child: const SizedBox(
                          width: 81,
                          height: 23,
                          child: Text('+',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Color(0xFF04CCFF),
                                  fontSize: 48,
                                  fontFamily: 'Phetsarath',
                                  fontWeight: FontWeight.w700)),
                        ),
                      ),
                      Positioned(
                        left: 194,
                        top: 306,
                        child: const SizedBox(
                          width: 81,
                          height: 23,
                          child: Text('+',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Color(0xFF4DDBFF),
                                  fontSize: 32,
                                  fontFamily: 'Phetsarath',
                                  fontWeight: FontWeight.w700)),
                        ),
                      ),
                      // Arrow icons
                      const Positioned(
                        left: 358,
                        top: 207,
                        child: SizedBox(
                          width: 25,
                          height: 25,
                          child: Icon(Icons.arrow_drop_down,
                              size: 22, color: Color(0xFF3998FC)),
                        ),
                      ),
                      // Category picker ">" arrow
                      Positioned(
                        left: 93,
                        top: 316,
                        child: const SizedBox(
                          width: 174,
                          height: 23,
                          child: Text('>',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Color(0xFF393939),
                                  fontSize: 15,
                                  fontFamily: 'Phetsarath',
                                  fontWeight: FontWeight.w400)),
                        ),
                      ),
                      // Images from AppAssets
                      Positioned(
                        left: 174,
                        top: 74,
                        child: Container(
                          width: 66,
                          height: 68,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(AppAssets.dpbJudul),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 32,
                        top: 206,
                        child: Container(
                          width: 47,
                          height: 31,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(AppAssets.dpbNama),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 33,
                        top: 273,
                        child: Container(
                          width: 18,
                          height: 18,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(AppAssets.dpbTambahKategori),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 29,
                        top: 314,
                        child: Container(
                          width: 23,
                          height: 23,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(AppAssets.dpbKategori),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 29,
                        top: 385,
                        child: Container(
                          width: 22,
                          height: 22,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(AppAssets.dpbTersedia),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 172,
                        top: 448,
                        child: Container(
                          width: 26,
                          height: 26,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(AppAssets.dpbStok),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 222,
                        top: 385,
                        child: Container(
                          width: 23,
                          height: 23,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(AppAssets.dpbElektronik),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 27,
                        top: 484,
                        child: Container(
                          width: 25,
                          height: 25,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(AppAssets.dpbDeskripsi),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 23,
                        top: 578,
                        child: Container(
                          width: 29,
                          height: 29,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(AppAssets.dpbFotoBarang),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),

                      // ── ERROR MESSAGE (conditional) ──
                      if (_nameError)
                        Positioned(
                          left: 35,
                          top: 275,
                          child: const SizedBox(
                            width: 174,
                            height: 23,
                            child: Text('Nama barang harus diisi!',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Color(0xFFFF0000),
                                    fontSize: 11,
                                    fontFamily: 'Phetsarath',
                                    fontWeight: FontWeight.w400)),
                          ),
                        ),

                      // ── DYNAMIC: selected category label in top picker ──
                      Positioned(
                        left: 62,
                        top: 320,
                        child: SizedBox(
                          width: 130,
                          height: 23,
                          child: Text(
                            _isLoadingCategories
                                ? 'Memuat...'
                                : _selectedCategoryName,
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                color: Color(0xFF393939),
                                fontSize: 12,
                                fontFamily: 'Phetsarath',
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ),

                      // ── DYNAMIC: selected category in dropdown field ──
                      Positioned(
                        left: 32,
                        top: 387,
                        child: SizedBox(
                          width: 160,
                          height: 23,
                          child: Text(
                            _selectedCategoryName,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 13,
                                fontFamily: 'Phetsarath',
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                      ),

                      // ── DYNAMIC: selected condition in dropdown field ──
                      Positioned(
                        left: 220,
                        top: 387,
                        child: SizedBox(
                          width: 160,
                          height: 23,
                          child: Text(
                            _selectedCondition,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 13,
                                fontFamily: 'Phetsarath',
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                      ),

                      // ── INPUT: Nama Barang TextField ──
                      Positioned(
                        left: 36,
                        top: 237,
                        child: SizedBox(
                          width: 320,
                          height: 32,
                          child: _inputField(
                            controller: _nameController,
                            hint: 'Masukkan nama barang...',
                            onChanged: (_) {
                              if (_nameError) {
                                setState(() => _nameError = false);
                              }
                            },
                          ),
                        ),
                      ),

                      // ── INPUT: Stok TextField ──
                      Positioned(
                        left: 23,
                        top: 444,
                        child: SizedBox(
                          width: 160,
                          height: 34,
                          child: _inputField(
                            controller: _stockController,
                            hint: 'Jumlah stok',
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                          ),
                        ),
                      ),

                      // ── INPUT: Harga TextField ──
                      Positioned(
                        left: 215,
                        top: 444,
                        child: SizedBox(
                          width: 160,
                          height: 34,
                          child: _inputField(
                            controller: _priceController,
                            hint: 'Harga barang',
                            keyboardType:
                                const TextInputType.numberWithOptions(
                                    decimal: true),
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'^\d+\.?\d{0,2}'))
                            ],
                          ),
                        ),
                      ),

                      // ── INPUT: Deskripsi TextField ──
                      Positioned(
                        left: 23,
                        top: 509,
                        child: SizedBox(
                          width: 370,
                          height: 66,
                          child: _inputField(
                            controller: _descController,
                            hint: 'Masukkan deskripsi barang...',
                            maxLines: 3,
                          ),
                        ),
                      ),

                      // ── INTERACTIVE: Back button ──
                      Positioned(
                        left: 0,
                        top: 50,
                        child: GestureDetector(
                          onTap: () => Navigator.of(context).maybePop(),
                          child: Container(
                            width: 80,
                            height: 60,
                            color: Colors.transparent,
                          ),
                        ),
                      ),

                      // ── INTERACTIVE: Kategori picker (top row, left) ──
                      Positioned(
                        left: 23,
                        top: 308,
                        child: GestureDetector(
                          onTap: _showCategoryPicker,
                          child: Container(
                            width: 171,
                            height: 39,
                            color: Colors.transparent,
                          ),
                        ),
                      ),

                      // ── INTERACTIVE: Tambah Kategori button (top row, right) ──
                      Positioned(
                        left: 201,
                        top: 308,
                        child: GestureDetector(
                          onTap: _showAddCategoryDialog,
                          child: Container(
                            width: 192,
                            height: 39,
                            color: Colors.transparent,
                          ),
                        ),
                      ),

                      // ── INTERACTIVE: Kategori dropdown field ──
                      Positioned(
                        left: 23,
                        top: 379,
                        child: GestureDetector(
                          onTap: _showCategoryPicker,
                          child: Container(
                            width: 178,
                            height: 34,
                            color: Colors.transparent,
                          ),
                        ),
                      ),

                      // ── INTERACTIVE: Status/Kondisi dropdown field ──
                      Positioned(
                        left: 215,
                        top: 379,
                        child: GestureDetector(
                          onTap: _showConditionPicker,
                          child: Container(
                            width: 178,
                            height: 34,
                            color: Colors.transparent,
                          ),
                        ),
                      ),

                      // ── INTERACTIVE: Simpan button ──
                      Positioned(
                        left: 117,
                        top: 710,
                        child: GestureDetector(
                          onTap: _isSaving ? null : _saveItem,
                          child: Container(
                            width: 175,
                            height: 40,
                            color: Colors.transparent,
                          ),
                        ),
                      ),

                      // ── INTERACTIVE: Foto (placeholder — belum ada upload) ──
                      Positioned(
                        left: 145,
                        top: 611,
                        child: GestureDetector(
                          onTap: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Fitur upload foto segera hadir'),
                              ),
                            );
                          },
                          child: Container(
                            width: 124,
                            height: 69,
                            color: Colors.transparent,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
