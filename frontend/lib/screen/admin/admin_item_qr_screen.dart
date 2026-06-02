import 'dart:ui' as ui;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:qr_flutter/qr_flutter.dart';

class AdminItemQrScreen extends StatefulWidget {
  final Map<String, dynamic> item;
  const AdminItemQrScreen({super.key, required this.item});

  @override
  State<AdminItemQrScreen> createState() => _AdminItemQrScreenState();
}

class _AdminItemQrScreenState extends State<AdminItemQrScreen> {
  bool _isDownloading = false;

  // Key to capture the white QR card widget as PNG
  final GlobalKey _qrBoundaryKey = GlobalKey();

  String get _itemId => widget.item['id']?.toString() ?? '';
  String get _itemName => widget.item['name']?.toString() ?? '-';
  String get _itemCategory =>
      widget.item['category_name']?.toString() ?? '-';
  String get _itemStock => widget.item['stock']?.toString() ?? '0';
  String get _itemCondition =>
      widget.item['condition']?.toString() ?? '-';

  Future<void> _downloadQr() async {
    if (_isDownloading) return;
    setState(() => _isDownloading = true);

    final messenger = ScaffoldMessenger.of(context);

    try {
      // 1. Capture the white QR card as a PNG image
      final boundary = _qrBoundaryKey.currentContext?.findRenderObject()
          as RenderRepaintBoundary?;
      if (boundary == null) throw Exception('Widget QR tidak ditemukan');

      final image = await boundary.toImage(pixelRatio: 3.0);
      final byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);
      if (byteData == null) throw Exception('Gagal mengkonversi gambar');

      final pngBytes = byteData.buffer.asUint8List();

      // 2. Show native "Save As" dialog (uses Android Storage Access Framework)
      final safeName =
          'QR_${_itemName.replaceAll(RegExp(r'[^\w]'), '_')}_$_itemId.png';
      final savedPath = await FilePicker.platform.saveFile(
        dialogTitle: 'Simpan QR Code',
        fileName: safeName,
        bytes: pngBytes,
      );

      if (savedPath != null) {
        messenger.showSnackBar(const SnackBar(
          content: Text('QR Code berhasil disimpan!'),
          backgroundColor: Color(0xFF2DB55D),
          duration: Duration(seconds: 3),
        ));
      }
    } catch (e) {
      messenger.showSnackBar(SnackBar(
        content: Text('Gagal menyimpan: $e'),
        backgroundColor: Colors.red,
      ));
    } finally {
      if (mounted) setState(() => _isDownloading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1E1E1E),
        foregroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'QR Code Barang',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        actions: [
          TextButton.icon(
            onPressed: _isDownloading ? null : _downloadQr,
            icon: const Icon(Icons.download_rounded,
                color: Color(0xFF3998FC), size: 18),
            label: const Text('Simpan',
                style: TextStyle(
                    color: Color(0xFF3998FC),
                    fontSize: 13,
                    fontWeight: FontWeight.w700)),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // ── Sukses banner ────────────────────────────────
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: const Color(0xFF1A3A2A),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                    color: const Color(0xFF2DB55D).withValues(alpha: .4)),
              ),
              child: Row(
                children: [
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color:
                          const Color(0xFF2DB55D).withValues(alpha: .2),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.check_rounded,
                        color: Color(0xFF2DB55D), size: 20),
                  ),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Barang Berhasil Ditambahkan!',
                            style: TextStyle(
                                color: Color(0xFF2DB55D),
                                fontSize: 13,
                                fontWeight: FontWeight.w800)),
                        SizedBox(height: 2),
                        Text(
                            'Download QR code, cetak, dan tempel di barang.',
                            style: TextStyle(
                                color: Color(0xFF7AB89A),
                                fontSize: 11)),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // ── Item info card ───────────────────────────────
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF1E1E1E),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Row(
                children: [
                  Container(
                    width: 46,
                    height: 46,
                    decoration: BoxDecoration(
                      color: const Color(0xFF3998FC)
                          .withValues(alpha: .15),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(Icons.inventory_2_rounded,
                        color: Color(0xFF3998FC), size: 24),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(_itemName,
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.bold)),
                        const SizedBox(height: 6),
                        Wrap(
                          spacing: 6,
                          runSpacing: 4,
                          children: [
                            _chip(_itemCategory,
                                const Color(0xFF3998FC)),
                            _chip('Stok: $_itemStock',
                                const Color(0xFF2DB55D)),
                            _chip(_itemCondition,
                                const Color(0xFFAAAAAA)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // ── White QR card (captured for download) ────────
            RepaintBoundary(
              key: _qrBoundaryKey,
              child: Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: .4),
                      blurRadius: 24,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    if (_itemId.isNotEmpty)
                      QrImageView(
                        data: _itemId,
                        version: QrVersions.auto,
                        size: 220,
                        backgroundColor: Colors.white,
                      )
                    else
                      const SizedBox(
                        width: 220,
                        height: 220,
                        child: Center(
                          child: Icon(Icons.qr_code_2_rounded,
                              size: 80, color: Colors.grey),
                        ),
                      ),
                    const SizedBox(height: 14),
                    Text(
                      _itemName,
                      style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1A1A1A)),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'ID Barang: $_itemId',
                      style: const TextStyle(
                          fontSize: 11, color: Color(0xFF888888)),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 14),

            const Text(
              'Scan QR ini dengan scanner di aplikasi user\nuntuk melihat detail & riwayat peminjaman barang',
              textAlign: TextAlign.center,
              style: TextStyle(color: Color(0xFF777777), fontSize: 12),
            ),

            const SizedBox(height: 28),

            // ── Download button ──────────────────────────────
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _isDownloading ? null : _downloadQr,
                icon: _isDownloading
                    ? const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(
                            color: Colors.white, strokeWidth: 2),
                      )
                    : const Icon(Icons.download_rounded, size: 20),
                label: Text(
                  _isDownloading ? 'Menyimpan...' : 'Download QR Code',
                  style: const TextStyle(
                      fontSize: 15, fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF3998FC),
                  disabledBackgroundColor:
                      const Color(0xFF3998FC).withValues(alpha: .5),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
              ),
            ),

            const SizedBox(height: 16),

            // ── Selesai button ───────────────────────────────
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () => Navigator.of(context).pop(),
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.white70,
                  side: const BorderSide(color: Color(0xFF444444)),
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text(
                  'Selesai',
                  style: TextStyle(
                      fontSize: 15, fontWeight: FontWeight.bold),
                ),
              ),
            ),

            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  Widget _chip(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
      decoration: BoxDecoration(
        color: color.withValues(alpha: .15),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: color.withValues(alpha: .35)),
      ),
      child: Text(text,
          style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w600,
              color: color)),
    );
  }
}
