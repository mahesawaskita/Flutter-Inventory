import 'package:flutter/material.dart';

class UserUi {
  static const bg = Color(0xFFF7EEF8);
  static const surface = Color(0xFFEDE2F0);
  static const surface2 = Color(0xFFFBF0F8);
  static const border = Color(0xFFAC9BAB);
  static const textMuted = Color(0xFF6D6D6D);
  static const primary = Color(0xFF3280FF);
  static const card = Color(0xFFFAF0F8);

  static const radius = 16.0;
}

class UserPageScaffold extends StatelessWidget {
  const UserPageScaffold({
    super.key,
    required this.title,
    required this.child,
    this.showBack = true,
    this.actions,
  });

  final String title;
  final Widget child;
  final bool showBack;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UserUi.bg,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: showBack
            ? IconButton(
                onPressed: () => Navigator.maybePop(context),
                icon: const Icon(Icons.arrow_back_ios_new_rounded),
              )
            : null,
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
        actions: actions,
      ),
      body: SafeArea(
        top: false,
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(12, 8, 12, 16),
          child: Column(
            children: [
              const _UserHeaderLogo(),
              const SizedBox(height: 12),
              UserSurface(
                child: child,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _UserHeaderLogo extends StatelessWidget {
  const _UserHeaderLogo();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 74,
      decoration: BoxDecoration(
        color: UserUi.surface2,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: UserUi.border, width: 2),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 14),
      child: Row(
        children: [
          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: UserUi.border.withValues(alpha: 0.5)),
            ),
            child: const Icon(Icons.inventory_2_outlined),
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Text(
              'Sistem Peminjaman\nInventaris',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                height: 1.1,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xFFD5D2DD),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Text(
              'User',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}

class UserSurface extends StatelessWidget {
  const UserSurface({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: UserUi.surface,
        borderRadius: BorderRadius.circular(UserUi.radius),
        border: Border.all(color: UserUi.border, width: 2),
      ),
      padding: const EdgeInsets.all(14),
      child: child,
    );
  }
}

class UserSearchField extends StatelessWidget {
  const UserSearchField({
    super.key,
    required this.hintText,
    this.onChanged,
  });

  final String hintText;
  final ValueChanged<String>? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: const Icon(Icons.search_rounded),
        filled: true,
        fillColor: const Color(0xFFF7EDF8),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}

class UserChip extends StatelessWidget {
  const UserChip({
    super.key,
    required this.text,
    required this.background,
    required this.foreground,
  });

  final String text;
  final Color background;
  final Color foreground;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: foreground,
          fontSize: 11,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class UserListCard extends StatelessWidget {
  const UserListCard({
    super.key,
    required this.title,
    required this.subtitle,
    this.trailingChip,
    this.onTap,
    this.leadingIcon = Icons.devices_other_rounded,
  });

  final String title;
  final String subtitle;
  final Widget? trailingChip;
  final VoidCallback? onTap;
  final IconData leadingIcon;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: UserUi.card,
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          child: Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(leadingIcon, color: UserUi.primary),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        fontSize: 12,
                        color: UserUi.textMuted,
                      ),
                    ),
                  ],
                ),
              ),
              if (trailingChip != null) ...[
                const SizedBox(width: 10),
                trailingChip!,
              ],
              const SizedBox(width: 8),
              const Icon(Icons.chevron_right_rounded),
            ],
          ),
        ),
      ),
    );
  }
}

