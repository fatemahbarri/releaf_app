import 'package:flutter/material.dart';

class ReLeafColors {
  static const Color primary = Color(0xFF7FB77E);
  static const Color secondary = Color(0xFF5E9C76);
  static const Color background = Color(0xFFF7FBF2);
  static const Color lightGreen = Color(0xFFEAF6E3);
  static const Color border = Color(0xFFDCE8D7);
  static const Color textDark = Color(0xFF2F5D50);
  static const Color textMedium = Color(0xFF4E6A57);
}

class ReLeafTextStyles {
  static const TextStyle title = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: ReLeafColors.textDark,
  );

  static const TextStyle subtitle = TextStyle(
    fontSize: 14,
    color: ReLeafColors.textMedium,
  );

  static const TextStyle body = TextStyle(
    fontSize: 13.5,
    color: ReLeafColors.textMedium,
    height: 1.4,
  );

  static const TextStyle button = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );
}

class ReLeafHeader extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final bool showBackButton;
  final VoidCallback? onBack;

  const ReLeafHeader({
    super.key,
    required this.title,
    required this.subtitle,
    this.icon = Icons.eco_rounded,
    this.showBackButton = false,
    this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 18),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [ReLeafColors.primary, ReLeafColors.secondary],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(24)),
      ),
      child: Row(
        children: [
          if (showBackButton) ...[
            IconButton(
              onPressed: onBack ?? () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
            ),
          ],
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.18),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(icon, color: Colors.white, size: 28),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: ReLeafTextStyles.title.copyWith(color: Colors.white),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: ReLeafTextStyles.subtitle.copyWith(
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ReLeafCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;
  final Color color;

  const ReLeafCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(16),
    this.margin = const EdgeInsets.symmetric(vertical: 6),
    this.color = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: margin,
      padding: padding,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: ReLeafColors.border),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: child,
    );
  }
}

class ReLeafButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final IconData? icon;
  final bool small;

  const ReLeafButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.icon,
    this.small = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Opacity(
        opacity: onPressed == null ? 0.55 : 1,
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: small ? 14 : 18,
            vertical: small ? 9 : 12,
          ),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [ReLeafColors.primary, ReLeafColors.secondary],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(small ? 18 : 22),
            boxShadow: [
              BoxShadow(
                color: ReLeafColors.primary.withOpacity(0.3),
                blurRadius: 8,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (icon != null) ...[
                Icon(icon, color: Colors.white, size: small ? 16 : 18),
                const SizedBox(width: 6),
              ],
              Text(text, style: ReLeafTextStyles.button),
            ],
          ),
        ),
      ),
    );
  }
}

class ReLeafSearchBar extends StatelessWidget {
  final TextEditingController? controller;
  final String hintText;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onTap;
  final IconData icon;

  const ReLeafSearchBar({
    super.key,
    this.controller,
    this.hintText = 'Search...',
    this.onChanged,
    this.onTap,
    this.icon = Icons.search,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: onChanged,
      onTap: onTap,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(color: Color(0xFF8A9A8C)),
        prefixIcon: Icon(icon, color: ReLeafColors.textMedium),
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(22),
          borderSide: const BorderSide(color: ReLeafColors.border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(22),
          borderSide: const BorderSide(color: ReLeafColors.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(22),
          borderSide: const BorderSide(color: ReLeafColors.primary, width: 1.4),
        ),
      ),
    );
  }
}

class ReLeafInfoBox extends StatelessWidget {
  final String text;
  final IconData icon;

  const ReLeafInfoBox({
    super.key,
    required this.text,
    this.icon = Icons.info_outline,
  });

  @override
  Widget build(BuildContext context) {
    return ReLeafCard(
      color: ReLeafColors.lightGreen,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      child: Row(
        children: [
          Icon(icon, color: ReLeafColors.textMedium, size: 20),
          const SizedBox(width: 10),
          Expanded(
            child: Text(text, style: ReLeafTextStyles.body),
          ),
        ],
      ),
    );
  }
}

class ReLeafBottomBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int)? onTap;

  const ReLeafBottomBar({
    super.key,
    this.selectedIndex = 0,
    this.onTap,
  });

  Widget _buildItem({
    required IconData icon,
    required String label,
    required int index,
  }) {
    final bool selected = index == selectedIndex;

    return Expanded(
      child: GestureDetector(
        onTap: () => onTap?.call(index),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
              decoration: BoxDecoration(
                color: selected
                    ? ReLeafColors.primary.withOpacity(0.25)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Icon(
                icon,
                color: selected
                    ? ReLeafColors.textDark
                    : ReLeafColors.textMedium,
                size: 27,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: selected
                    ? ReLeafColors.textDark
                    : ReLeafColors.textMedium,
                fontWeight: selected ? FontWeight.bold : FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ReLeafColors.lightGreen,

       
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(22),
        ),

        // ✨ optional shadow (makes it look modern)
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      child: Row(
        children: [
          _buildItem(icon: Icons.home_outlined, label: 'Home', index: 0),
          _buildItem(icon: Icons.camera_alt_outlined, label: 'Camera', index: 1),
          _buildItem(icon: Icons.location_on_outlined, label: 'Bins', index: 2),
          _buildItem(icon: Icons.settings_outlined, label: 'Profile', index: 3),
        ],
      ),
    );
  }
}