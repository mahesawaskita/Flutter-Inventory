import 'package:flutter/material.dart';
import 'package:frontend/service/api_service.dart';
import 'package:frontend/service/auth_service.dart';
import 'package:qr_flutter/qr_flutter.dart';

import 'user_ui.dart';

class GenerateQrUser extends StatefulWidget {
  const GenerateQrUser({super.key, this.item});

  final Map<String, dynamic>? item;

  @override
  State<GenerateQrUser> createState() => _GenerateQrUserState();
}

class _GenerateQrUserState extends State<GenerateQrUser> {
  List<Map<String, dynamic>> _items = [];
  Map<String, dynamic>? _selectedItem;
  bool _isLoading = true;
  String? _loadError;

  @override
  void initState() {
    super.initState();
    if (widget.item != null) {
      _selectedItem = widget.item;
      _isLoading = false;
    } else {
      _loadItems();
    }
  }

  Future<void> _loadItems() async {
    if (mounted) setState(() { _isLoading = true; _loadError = null; });
    try {
      final token = await AuthService.getToken();
      if (token == null) {
        if (mounted) setState(() { _isLoading = false; _loadError = 'Silakan login ulang.'; });
        return;
      }
      final items = await ApiService.getItems(token)
          .timeout(const Duration(seconds: 12), onTimeout: () => []);
      if (!mounted) return;
      setState(() {
        _items = items.map((e) => Map<String, dynamic>.from(e as Map)).toList();
        if (_items.isNotEmpty) _selectedItem = _items.first;
        _isLoading = false;
        if (_items.isEmpty) _loadError = 'Tidak ada barang. Periksa koneksi server.';
      });
    } catch (_) {
      if (mounted) setState(() { _isLoading = false; _loadError = 'Gagal memuat data barang.'; });
    }
  }

  @override
  Widget build(BuildContext context) {
    final item = _selectedItem;
    final itemId = item != null ? item['id']?.toString() ?? '' : '';

    return UserPageScaffold(
      child: UserFramedPage(
        title: 'Generate QR Scanner',
        topIcon: const Icon(Icons.qr_code_2_rounded, size: 46, color: Color(0xFF545163)),
        child: _isLoading
            ? const Center(
                child: Padding(
                  padding: EdgeInsets.all(32),
                  child: CircularProgressIndicator(color: UserUi.blue),
                ),
              )
            : _loadError != null && _selectedItem == null
                ? Center(
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        children: [
                          const Icon(Icons.cloud_off_rounded,
                              size: 48, color: UserUi.textMuted),
                          const SizedBox(height: 12),
                          Text(_loadError!,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  color: UserUi.textMuted, fontSize: 13)),
                          const SizedBox(height: 16),
                          OutlinedButton.icon(
                            onPressed: _loadItems,
                            icon: const Icon(Icons.refresh_rounded, size: 16),
                            label: const Text('Coba Lagi'),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: UserUi.blue,
                              side: const BorderSide(color: UserUi.blue),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
            : Column(
                children: [
                  // ── Item selector (only shown when not passed directly) ──
                  if (widget.item == null && _items.isNotEmpty) ...[
                    UserSectionCard(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          isExpanded: true,
                          value: _selectedItem?['id']?.toString(),
                          hint: const Text('Pilih barang', style: TextStyle(fontSize: 13)),
                          style: const TextStyle(fontSize: 13, color: Colors.black87),
                          items: _items.map((i) {
                            return DropdownMenuItem<String>(
                              value: i['id']?.toString(),
                              child: Text(i['name']?.toString() ?? '-'),
                            );
                          }).toList(),
                          onChanged: (val) {
                            setState(() {
                              _selectedItem = _items.firstWhere(
                                  (i) => i['id']?.toString() == val,
                                  orElse: () => _items.first);
                            });
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                  ],

                  if (item != null) ...[
                    // ── Item info card ──
                    UserSectionCard(
                      padding: EdgeInsets.zero,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: UserInfoTile(
                              leading: const UserProductThumb(icon: Icons.inventory_2_rounded),
                              title: item['name']?.toString() ?? '-',
                              subtitle: item['category_name']?.toString() ?? '-',
                            ),
                          ),
                          Container(height: 1, color: UserUi.softBorder),
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: Row(
                              children: [
                                const Icon(Icons.layers_rounded, color: Color(0xFF52B2F1)),
                                const SizedBox(width: 8),
                                Text(
                                  'Stok: ${item['stock'] ?? 0}',
                                  style: const TextStyle(fontSize: 13),
                                ),
                                const SizedBox(width: 16),
                                const Icon(Icons.info_outline_rounded, color: Color(0xFF52B2F1)),
                                const SizedBox(width: 8),
                                Text(
                                  item['condition']?.toString() ?? '-',
                                  style: const TextStyle(fontSize: 13),
                                ),
                              ],
                            ),
                          ),
                          if ((item['description']?.toString() ?? '').isNotEmpty) ...[
                            Container(height: 1, color: UserUi.softBorder),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                              child: UserTextInputMock(
                                text: item['description']?.toString() ?? '',
                                muted: true,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),

                    // ── QR Code ──
                    Container(
                      width: 90,
                      height: 66,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF8F2F7),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: UserUi.frameBorder, width: 3),
                      ),
                      child: const Icon(Icons.inventory_2_rounded,
                          size: 40, color: Color(0xFF4460C8)),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      width: 160,
                      height: 160,
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: UserUi.softBorder),
                      ),
                      child: itemId.isNotEmpty
                          ? QrImageView(
                              data: itemId,
                              version: QrVersions.auto,
                              backgroundColor: Colors.white,
                            )
                          : const Center(
                              child: Icon(Icons.qr_code_2_rounded,
                                  size: 80, color: UserUi.textLight)),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'QR code untuk barang ${item['name'] ?? '-'}',
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 13, color: UserUi.textMuted),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'ID Barang: $itemId',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontSize: 11, color: UserUi.textLight, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 16),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 60),
                      child: UserPrimaryButton(
                        text: 'Cetak QR Code',
                        icon: Icons.print_rounded,
                        background: const Color(0xFF7060C7),
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Fitur cetak akan segera tersedia'),
                              duration: Duration(seconds: 2),
                            ),
                          );
                        },
                      ),
                    ),
                  ] else ...[
                    const Padding(
                      padding: EdgeInsets.all(32),
                      child: Text(
                        'Tidak ada barang tersedia',
                        style: TextStyle(color: UserUi.textMuted),
                      ),
                    ),
                  ],
                ],
              ),
      ),
    );
  }
}
