import 'package:flutter/material.dart';

class AppTopBar extends StatelessWidget {
  final String title;
  final String? subtitle;

  final double titleSize; // 👈 تحكم بحجم العنوان
  final double subtitleSize; // 👈 تحكم بحجم الساب تايتل

  final IconData icon;
  final int? notifications;
  final bool showNotifications;
  final List<Color> gradientColors;
  final VoidCallback? onNotificationTap;
  final bool showBackButton;

  const AppTopBar({
    super.key,
    required this.title,
    this.subtitle,
    this.titleSize = 20, // 👈 الافتراضي لكل التطبيق
    this.subtitleSize = 13, // 👈 الافتراضي

    this.icon = Icons.eco,
    this.notifications,
    this.showNotifications = false,
    required this.gradientColors,
    this.onNotificationTap,
    this.showBackButton = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 18),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: gradientColors,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: const BorderRadius.vertical(
          bottom: Radius.circular(24),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: showBackButton ? () => Navigator.pop(context) : null,
            child: Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.18),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(
                showBackButton ? Icons.arrow_back_ios_new_rounded : icon,
                color: Colors.white,
                size: showBackButton ? 22 : 28,
              ),
            ),
          ),

          const SizedBox(width: 12),

          /// 👇 Title + Subtitle
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: titleSize, // 👈 هنا التحكم
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (subtitle != null) ...[
                  const SizedBox(height: 2),
                  Text(
                    subtitle!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.8),
                      fontSize: subtitleSize, // 👈 هنا التحكم
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ],
            ),
          ),

          if (showNotifications)
            GestureDetector(
              onTap: onNotificationTap,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  const Icon(
                    Icons.notifications_none_rounded,
                    color: Colors.white,
                    size: 30,
                  ),
                  if (notifications != null && notifications! > 0)
                    Positioned(
                      right: -5,
                      top: -5,
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        decoration: const BoxDecoration(
                          color: Color(0xFFE53935),
                          shape: BoxShape.circle,
                        ),
                        child: Text(
                          notifications.toString(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
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
}
