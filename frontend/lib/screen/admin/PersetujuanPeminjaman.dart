import 'package:flutter/material.dart';
import 'package:frontend/service/api_service.dart';
import 'package:frontend/service/auth_service.dart';

class PersetujuanPeminjamanAdmin extends StatefulWidget {
  const PersetujuanPeminjamanAdmin({super.key});

  @override
  State<PersetujuanPeminjamanAdmin> createState() => _PersetujuanPeminjamanAdminState();
}

class _PersetujuanPeminjamanAdminState extends State<PersetujuanPeminjamanAdmin> {
  List<Map<String, dynamic>> _loans = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadLoans();
  }

  Future<void> _loadLoans() async {
    if (mounted) setState(() => _isLoading = true);
    try {
      final token = await AuthService.getToken();
      if (token == null) return;
      final result = await ApiService.getPendingLoans(token);
      if (mounted) {
        setState(() => _loans = result.map((e) => Map<String, dynamic>.from(e as Map)).toList());
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _approve(int id) async {
    final token = await AuthService.getToken();
    if (token == null) return;
    final res = await ApiService.approveLoan(token, id);
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(res['message'] ?? ''),
      backgroundColor: res['success'] == true ? Colors.green : Colors.red,
    ));
    if (res['success'] == true) _loadLoans();
  }

  Future<void> _reject(int id) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Tolak Pengajuan'),
        content: const Text('Apakah kamu yakin ingin menolak pengajuan ini?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Batal')),
          ElevatedButton(
            onPressed: () => Navigator.pop(ctx, true),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red, foregroundColor: Colors.white),
            child: const Text('Tolak'),
          ),
        ],
      ),
    );
    if (confirm != true) return;
    final token = await AuthService.getToken();
    if (token == null) return;
    final res = await ApiService.rejectLoan(token, id);
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(res['message'] ?? ''),
      backgroundColor: res['success'] == true ? Colors.orange : Colors.red,
    ));
    if (res['success'] == true) _loadLoans();
  }

  String _fmtDate(String? s) {
    if (s == null) return '-';
    try {
      final d = DateTime.parse(s);
      const m = ['Jan','Feb','Mar','Apr','Mei','Jun','Jul','Agu','Sep','Okt','Nov','Des'];
      return '${d.day} ${m[d.month - 1]} ${d.year}';
    } catch (_) {
      return s;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F7),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A1A1A),
        foregroundColor: Colors.white,
        title: const Text(
          'Persetujuan Peminjaman',
          style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh_rounded),
            onPressed: _loadLoans,
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator(color: Color(0xFF3998FC)))
          : _loans.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.check_circle_outline_rounded, size: 64, color: Colors.green),
                      const SizedBox(height: 12),
                      const Text(
                        'Tidak ada pengajuan\nyang menunggu persetujuan',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 15, color: Colors.grey),
                      ),
                    ],
                  ),
                )
              : RefreshIndicator(
                  onRefresh: _loadLoans,
                  child: ListView.separated(
                    padding: const EdgeInsets.all(16),
                    itemCount: _loans.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 10),
                    itemBuilder: (context, index) => _LoanCard(
                      loan: _loans[index],
                      fmtDate: _fmtDate,
                      onApprove: () => _approve(_loans[index]['id'] as int),
                      onReject: () => _reject(_loans[index]['id'] as int),
                    ),
                  ),
                ),
    );
  }
}

class _LoanCard extends StatelessWidget {
  const _LoanCard({
    required this.loan,
    required this.fmtDate,
    required this.onApprove,
    required this.onReject,
  });

  final Map<String, dynamic> loan;
  final String Function(String?) fmtDate;
  final VoidCallback onApprove;
  final VoidCallback onReject;

  @override
  Widget build(BuildContext context) {
    final itemName = loan['item_name']?.toString() ?? '-';
    final username = loan['username']?.toString() ?? '-';
    final qty = loan['quantity']?.toString() ?? '1';
    final borrowDate = fmtDate(loan['borrow_date']?.toString());
    final dueDate = fmtDate(loan['due_date']?.toString());
    final category = loan['category_name']?.toString() ?? '-';
    final stock = loan['item_stock']?.toString() ?? '-';

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: const BoxDecoration(
              color: Color(0xFFFFF8E1),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            child: Row(
              children: [
                const Icon(Icons.pending_actions_rounded, size: 18, color: Color(0xFFE6A817)),
                const SizedBox(width: 8),
                Text(
                  'Menunggu Persetujuan',
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFE6A817),
                  ),
                ),
                const Spacer(),
                Text(
                  '#${loan['id']}',
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Item info
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: const Color(0xFFE8F4FD),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(Icons.inventory_2_rounded, color: Color(0xFF3998FC), size: 24),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(itemName,
                              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                          Text(category,
                              style: const TextStyle(fontSize: 12, color: Colors.grey)),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE8F4FD),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        'Stok: $stock',
                        style: const TextStyle(fontSize: 12, color: Color(0xFF3998FC), fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 10),
                const Divider(height: 1),
                const SizedBox(height: 10),

                // User & details
                _InfoRow(icon: Icons.person_rounded, label: 'Peminjam', value: username),
                const SizedBox(height: 6),
                _InfoRow(icon: Icons.layers_rounded, label: 'Jumlah', value: '$qty unit'),
                const SizedBox(height: 6),
                _InfoRow(icon: Icons.calendar_today_rounded, label: 'Tgl Pinjam', value: borrowDate),
                const SizedBox(height: 6),
                _InfoRow(icon: Icons.event_rounded, label: 'Tgl Kembali', value: dueDate),

                const SizedBox(height: 14),

                // Action buttons
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: onReject,
                        icon: const Icon(Icons.close_rounded, size: 16),
                        label: const Text('Tolak'),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.red,
                          side: const BorderSide(color: Colors.red),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          padding: const EdgeInsets.symmetric(vertical: 10),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: onApprove,
                        icon: const Icon(Icons.check_rounded, size: 16),
                        label: const Text('Setujui'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF28A745),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          elevation: 0,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.icon, required this.label, required this.value});
  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 15, color: const Color(0xFF3998FC)),
        const SizedBox(width: 6),
        Text('$label: ', style: const TextStyle(fontSize: 12, color: Colors.grey)),
        Expanded(
          child: Text(value, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
        ),
      ],
    );
  }
}
