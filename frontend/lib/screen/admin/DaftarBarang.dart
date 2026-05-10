import 'package:flutter/material.dart';
import 'package:frontend/constants/app_assets.dart';
import 'package:frontend/screen/admin/EditBarang.dart';

class DaftarBarangPage extends StatefulWidget {
  const DaftarBarangPage({super.key});

  @override
  State<DaftarBarangPage> createState() => _DaftarBarangPageState();
}

class _DaftarBarangPageState extends State<DaftarBarangPage> {
  static const _darkBg = Color(0xFF1A1A1A);
  static const _panelBg = Color(0xFFF7F7F7);
  static const _blue = Color(0xFF1976D2);
  static const _blueLight = Color(0xFF64B5F6);
  static const _amberDark = Color(0xFFF9A825);
  static const _red = Color(0xFFE53935);

  int _activeTab = 0;
  final _tabs = const [
    'Semua',
    'Elektronik',
    'Aksesoris',
    '+ Tambah Kategori',
  ];

  Widget _asset(
    String path, {
    double? width,
    double? height,
    BoxFit fit = BoxFit.contain,
  }) {
    final w = width ?? 24;
    final h = height ?? 24;
    return Image.asset(
      path,
      width: width,
      height: height,
      fit: fit,
      errorBuilder: (_, __, ___) => SizedBox(
        width: w,
        height: h,
        child: Icon(
          Icons.broken_image_outlined,
          size: w * 0.55,
          color: Colors.grey,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _darkBg,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // —— Bar atas: kembali + ikon judul di tengah ——
            SizedBox(
              height: 52,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () => Navigator.of(context).maybePop(),
                    ),
                  ),
                  Container(
                    width: 72,
                    height: 72,
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: Colors.grey.shade400, width: 1),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.12),
                          blurRadius: 6,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: _asset(AppAssets.dfJudul, fit: BoxFit.contain),
                  ),
                ],
              ),
            ),

            // —— Panel putih utama ——
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: _panelBg,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
                ),
                clipBehavior: Clip.antiAlias,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 18, 12, 0),
                      child: Row(
                        children: [
                          const SizedBox(width: 40),
                          const Expanded(
                            child: Text(
                              'Daftar Barang',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w800,
                                color: Colors.black87,
                              ),
                            ),
                          ),
                          Material(
                            color: Colors.grey.shade300,
                            shape: const CircleBorder(),
                            clipBehavior: Clip.antiAlias,
                            child: InkWell(
                              onTap: () {},
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Icon(
                                  Icons.settings_outlined,
                                  size: 22,
                                  color: Colors.grey.shade700,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 16),

                    // —— Kartu ringkasan ——
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: IntrinsicHeight(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Expanded(
                              child: _summaryCard(
                                borderColor: _blue,
                                subtitleColor: _blueLight,
                                title: 'Total Barang',
                                value: '225',
                                subtitle: '+55 sejak minggu lalu',
                                asset: AppAssets.dfTotal,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: _summaryCard(
                                borderColor: _amberDark,
                                subtitleColor: _amberDark,
                                title: 'Barang Hampir Habis',
                                value: '10',
                                subtitle: '3 minggu lalu',
                                asset: AppAssets.dfHampirHabis,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: _summaryCard(
                                borderColor: _red,
                                subtitleColor: _red,
                                title: 'Barang Habis',
                                value: '5',
                                subtitle: '2 minggu lalu',
                                asset: AppAssets.dfBarangHabis,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 14),

                    // —— Tab kategori (garis bawah biru jika aktif) ——
                    SizedBox(
                      height: 40,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        itemCount: _tabs.length + 1,
                        separatorBuilder: (_, __) => const SizedBox(width: 4),
                        itemBuilder: (context, i) {
                          if (i == _tabs.length) {
                            return IconButton(
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(
                                minWidth: 36,
                                minHeight: 36,
                              ),
                              icon: Icon(
                                Icons.more_horiz,
                                color: Colors.grey.shade700,
                              ),
                              onPressed: () {},
                            );
                          }
                          final active = i == _activeTab;
                          return GestureDetector(
                            onTap: () => setState(() => _activeTab = i),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    _tabs[i],
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: active
                                          ? FontWeight.w700
                                          : FontWeight.w500,
                                      color: active
                                          ? Colors.black87
                                          : Colors.grey.shade600,
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  Container(
                                    height: 3,
                                    width: active ? 36 : 0,
                                    decoration: BoxDecoration(
                                      color: _blue,
                                      borderRadius: BorderRadius.circular(2),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),

                    const SizedBox(height: 12),

                    // —— Cari + Filter + Sortir ——
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: TextField(
                              style: const TextStyle(fontSize: 14),
                              decoration: InputDecoration(
                                hintText: 'Cari nama barang...',
                                hintStyle: TextStyle(
                                  color: Colors.grey.shade500,
                                  fontSize: 14,
                                ),
                                prefixIcon: Icon(
                                  Icons.search,
                                  color: Colors.grey.shade600,
                                  size: 22,
                                ),
                                isDense: true,
                                filled: true,
                                fillColor: Colors.white,
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 12,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(24),
                                  borderSide: BorderSide(
                                    color: Colors.grey.shade300,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(24),
                                  borderSide: BorderSide(
                                    color: Colors.grey.shade300,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(24),
                                  borderSide: const BorderSide(color: _blue),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          _pillAction(
                            label: 'Filter',
                            icon: Icons.filter_list_rounded,
                          ),
                          const SizedBox(width: 6),
                          _pillAction(
                            label: 'Sortir',
                            icon: Icons.sort_rounded,
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 14),

                    // —— Header tabel ——
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 22,
                              child: _headerCell('Nama Barang'),
                            ),
                            Expanded(
                              flex: 14,
                              child: _headerCell('Kategori'),
                            ),
                            Expanded(
                              flex: 10,
                              child: _headerCell('Stok', trailing: ' ↗'),
                            ),
                            Expanded(
                              flex: 16,
                              child: _headerCell('Status'),
                            ),
                            Expanded(
                              flex: 14,
                              child: _headerCell('Tindakan'),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 8),

                    // —— Daftar baris ——
                    Expanded(
                      child: ListView(
                        padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
                        children: [
                          _dataRow(
                            name: 'Laptop',
                            kategori: 'Elektronik',
                            stok: 8,
                            status: _RowStatus.tersedia,
                            thumb: AppAssets.dfLaptop,
                          ),
                          const SizedBox(height: 8),
                          _dataRow(
                            name: 'Monitor',
                            kategori: 'Elektronik',
                            stok: 4,
                            status: _RowStatus.hampirHabis,
                            stockPercent: 0.1,
                            thumb: AppAssets.dfMonitor,
                          ),
                          const SizedBox(height: 8),
                          _dataRow(
                            name: 'Mouse',
                            kategori: 'Aksesoris',
                            stok: 3,
                            status: _RowStatus.hampirHabis,
                            stockPercent: 0.1,
                            thumb: AppAssets.dfMouse,
                          ),
                        ],
                      ),
                    ),

                    // —— Paginasi ——
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 4, 16, 14),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              'Menampilkan 3 dari 225 barang',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey.shade700,
                              ),
                            ),
                          ),
                          _pageNavBtn(icon: Icons.chevron_left),
                          _pageNum('1', active: true),
                          _pageNum('2'),
                          _pageNum('3'),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4),
                            child: Text(
                              '...',
                              style: TextStyle(
                                color: Colors.grey.shade600,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          _pageNum('13'),
                          _pageNavBtn(icon: Icons.chevron_right),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // —— Logo ESDM ——
            Padding(
              padding: const EdgeInsets.only(top: 8, bottom: 10),
              child: Center(
                child: SizedBox(
                  height: 52,
                  width: 52,
                  child: Image.asset(
                    AppAssets.splash,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _headerCell(String text, {String trailing = ''}) {
    return Center(
      child: Text(
        '$text$trailing',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: Colors.grey.shade800,
        ),
      ),
    );
  }

  Widget _summaryCard({
    required Color borderColor,
    required Color subtitleColor,
    required String title,
    required String value,
    required String subtitle,
    required String asset,
  }) {
    return Container(
      padding: const EdgeInsets.fromLTRB(8, 10, 8, 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: borderColor, width: 2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            height: 28,
            child: _asset(asset, width: 28, height: 28),
          ),
          const SizedBox(height: 6),
          Text(
            title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 10,
              height: 1.2,
              color: Colors.grey.shade800,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w800,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            subtitle,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 9,
              color: subtitleColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _pillAction({required String label, required IconData icon}) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(22),
      elevation: 0,
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(22),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(22),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 18, color: Colors.grey.shade800),
              const SizedBox(width: 4),
              Text(
                label,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _dataRow({
    required String name,
    required String kategori,
    required int stok,
    required _RowStatus status,
    required String thumb,
    double? stockPercent,
  }) {
    final isAksesoris = kategori == 'Aksesoris';
    final katBg = isAksesoris
        ? const Color(0xFFFFF9C4)
        : const Color(0xFFE3F2FD);
    final katFg = isAksesoris
        ? const Color(0xFFF57F17)
        : _blue;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 4,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 22,
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: _asset(
                    thumb,
                    width: 40,
                    height: 40,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 8),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 13,
                          color: Colors.black87,
                        ),
                      ),
                      Text(
                        'Informasi',
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 14,
            child: Center(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: katBg,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  kategori,
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: katFg,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 10,
            child: Center(
              child: Text(
                '$stok',
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 13,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 16,
            child: Center(child: _statusBadge(status, stockPercent)),
          ),
          Expanded(
            flex: 14,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Material(
                  color: _blue,
                  shape: const CircleBorder(),
                  clipBehavior: Clip.antiAlias,
                  child: InkWell(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const EditBarangAdmin(),
                      ),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(8),
                      child: Icon(
                        Icons.edit_outlined,
                        size: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 6),
                Material(
                  color: _red,
                  shape: const CircleBorder(),
                  clipBehavior: Clip.antiAlias,
                  child: InkWell(
                    onTap: () {},
                    child: const Padding(
                      padding: EdgeInsets.all(8),
                      child: Icon(
                        Icons.delete_outline,
                        size: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _statusBadge(_RowStatus status, double? stockPercent) {
    switch (status) {
      case _RowStatus.tersedia:
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: const Color(0xFFE8F5E9),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: const Color(0xFF43A047)),
          ),
          child: const Text(
            'Tersedia',
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w600,
              color: Color(0xFF2E7D32),
            ),
          ),
        );
      case _RowStatus.hampirHabis:
        return SizedBox(
          width: 88,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF8E1),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: _amberDark),
                ),
                child: const Text(
                  'Hampir Habis',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 9,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFFE65100),
                  ),
                ),
              ),
              if (stockPercent != null) ...[
                const SizedBox(height: 4),
                ClipRRect(
                  borderRadius: BorderRadius.circular(3),
                  child: LinearProgressIndicator(
                    value: stockPercent,
                    minHeight: 4,
                    backgroundColor: Colors.grey.shade300,
                    color: _amberDark,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  '${(stockPercent * 100).round()}%',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 9,
                    color: Colors.grey.shade700,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ],
          ),
        );
      case _RowStatus.habis:
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: const Color(0xFFFFEBEE),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: _red),
          ),
          child: const Text(
            'Habis',
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w600,
              color: Color(0xFFC62828),
            ),
          ),
        );
    }
  }

  Widget _pageNavBtn({required IconData icon}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2),
      child: Material(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(6),
        child: InkWell(
          onTap: () {},
          borderRadius: BorderRadius.circular(6),
          child: Padding(
            padding: const EdgeInsets.all(4),
            child: Icon(icon, size: 18, color: Colors.grey.shade800),
          ),
        ),
      ),
    );
  }

  Widget _pageNum(String n, {bool active = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 3),
      child: Material(
        color: active ? Colors.white : Colors.grey.shade200,
        borderRadius: BorderRadius.circular(6),
        child: InkWell(
          onTap: () {},
          borderRadius: BorderRadius.circular(6),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              border: Border.all(
                color: active ? _blue : Colors.transparent,
                width: 2,
              ),
            ),
            child: Text(
              n,
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 13,
                color: active ? _blue : Colors.black87,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

enum _RowStatus { tersedia, hampirHabis, habis }
