import 'package:flutter/material.dart';

class UserUi {
  static const background = Colors.white;
  static const frameFill = Color(0xFFE8DCEB);
  static const frameBorder = Color(0xFFB2A0B0);
  static const card = Color(0xFFF8F1F7);
  static const cardSoft = Color(0xFFF2EAF4);
  static const input = Color(0xFFF6F3F8);
  static const blue = Color(0xFF3B82F6);
  static const blueDark = Color(0xFF1F5AA8);
  static const green = Color(0xFF97D987);
  static const yellow = Color(0xFFF8E1A7);
  static const peach = Color(0xFFF8D9D2);
  static const softBorder = Color(0xFFC6B7C5);
  static const textMuted = Color(0xFF7E7484);
  static const textLight = Color(0xFFAEA4B0);
  static const productThumbBackground = Color(0xFFE4E8FF);
  static const productThumbIconColor = Color(0xFF4460C8);
}

class UserPageScaffold extends StatelessWidget {
  const UserPageScaffold({
    super.key,
    required this.child,
    this.showBack = true,
  });

  final Widget child;
  final bool showBack;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UserUi.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(8, 8, 8, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (showBack)
                Padding(
                  padding: const EdgeInsets.only(left: 4),
                  child: IconButton(
                    onPressed: () => Navigator.maybePop(context),
                    icon: const Icon(
                      Icons.arrow_back_rounded,
                      size: 38,
                      color: Colors.black,
                    ),
                  ),
                ),
              child,
            ],
          ),
        ),
      ),
    );
  }
}

class UserFramedPage extends StatelessWidget {
  const UserFramedPage({
    super.key,
    required this.title,
    required this.topIcon,
    required this.child,
    this.topTrailing,
  });

  final String title;
  final Widget topIcon;
  final Widget child;
  final Widget? topTrailing;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: double.infinity,
          margin: const EdgeInsets.only(top: 42),
          padding: const EdgeInsets.fromLTRB(12, 42, 12, 12),
          decoration: BoxDecoration(
            color: UserUi.frameFill,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: UserUi.frameBorder, width: 3),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  const Spacer(),
                  Expanded(
                    flex: 8,
                    child: Text(
                      title,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: topTrailing ?? const SizedBox.shrink(),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              child,
            ],
          ),
        ),
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Center(
            child: Container(
              width: 106,
              height: 78,
              decoration: BoxDecoration(
                color: UserUi.card,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: UserUi.frameBorder, width: 3),
              ),
              child: Center(child: topIcon),
            ),
          ),
        ),
      ],
    );
  }
}

class UserSectionCard extends StatelessWidget {
  const UserSectionCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(12),
    this.color = UserUi.card,
  });

  final Widget child;
  final EdgeInsetsGeometry padding;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: UserUi.softBorder),
      ),
      child: child,
    );
  }
}

class UserPrimaryButton extends StatelessWidget {
  const UserPrimaryButton({
    super.key,
    required this.text,
    this.onTap,
    this.icon,
    this.background = UserUi.blue,
  });

  final String text;
  final VoidCallback? onTap;
  final IconData? icon;
  final Color background;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: background,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          height: 46,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: background == UserUi.blue ? UserUi.blueDark : background,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (icon != null) ...[
                  Icon(icon, color: Colors.white, size: 18),
                  const SizedBox(width: 8),
                ],
                Text(
                  text,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class UserPill extends StatelessWidget {
  const UserPill({
    super.key,
    required this.text,
    required this.background,
    required this.foreground,
    this.padding = const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
  });

  final String text;
  final Color background;
  final Color foreground;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(12),
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

class UserInfoTile extends StatelessWidget {
  const UserInfoTile({
    super.key,
    required this.leading,
    required this.title,
    this.subtitle,
    this.trailing,
    this.padding = const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
  });

  final Widget leading;
  final String title;
  final String? subtitle;
  final Widget? trailing;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: const Color(0xFFF9F4F8),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: UserUi.softBorder),
      ),
      child: Row(
        children: [
          leading,
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                if (subtitle != null) ...[
                  const SizedBox(height: 2),
                  Text(
                    subtitle!,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ],
            ),
          ),
          if (trailing != null) trailing!,
        ],
      ),
    );
  }
}

class UserTextInputMock extends StatelessWidget {
  const UserTextInputMock({
    super.key,
    required this.text,
    this.icon,
    this.trailing,
    this.centerText = false,
    this.muted = false,
  });

  final String text;
  final Widget? icon;
  final Widget? trailing;
  final bool centerText;
  final bool muted;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 34,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: UserUi.input,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: UserUi.softBorder),
      ),
      child: Row(
        children: [
          if (icon != null) ...[icon!, const SizedBox(width: 8)],
          Expanded(
            child: Text(
              text,
              textAlign: centerText ? TextAlign.center : TextAlign.start,
              style: TextStyle(
                color: muted ? UserUi.textLight : Colors.black87,
                fontSize: 12,
              ),
            ),
          ),
          if (trailing != null) trailing!,
        ],
      ),
    );
  }
}

class UserProductThumb extends StatelessWidget {
  const UserProductThumb({
    super.key,
    required this.icon,
    this.background = UserUi.productThumbBackground,
    this.size = 44,
  });

  final IconData icon;
  final Color background;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Icon(icon, color: UserUi.productThumbIconColor, size: size * .62),
    );
  }
}

class UserHistoryRow extends StatelessWidget {
  const UserHistoryRow({
    super.key,
    required this.avatar,
    required this.name,
    required this.date,
    required this.status,
    required this.statusColor,
    this.subtitle,
  });

  final Widget avatar;
  final String name;
  final String date;
  final String status;
  final Color statusColor;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: UserUi.softBorder),
        ),
      ),
      child: Row(
        children: [
          avatar,
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: const TextStyle(fontWeight: FontWeight.w700)),
                if (subtitle != null)
                  Text(
                    subtitle!,
                    style: const TextStyle(fontSize: 11, color: UserUi.textMuted),
                  ),
                Text(
                  date,
                  style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w800),
                ),
              ],
            ),
          ),
          UserPill(
            text: status,
            background: statusColor.withValues(alpha: 0.22),
            foreground: statusColor,
          ),
        ],
      ),
    );
  }
}

class UserMockSearch extends StatelessWidget {
  const UserMockSearch({super.key, required this.hint});

  final String hint;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 34,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: const Color(0xFFF6ECF7),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: [
          Container(
            width: 18,
            height: 18,
            decoration: const BoxDecoration(
              color: Color(0xFF9DE8F2),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.search, size: 13, color: Colors.black54),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              hint,
              style: const TextStyle(fontSize: 12, color: UserUi.textLight),
            ),
          ),
        ],
      ),
    );
  }
}
