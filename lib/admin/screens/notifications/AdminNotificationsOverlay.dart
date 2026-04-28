import 'package:flutter/material.dart';
import '../../theme/admin_theme.dart';

class AdminNotificationsOverlay extends StatelessWidget {
  final int newNotifications;

  const AdminNotificationsOverlay({
    super.key,
    required this.newNotifications,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black.withOpacity(0.35), // 🔥 تعتيم الخلفية
      child: SafeArea(
        child: Align(
          alignment: Alignment.topCenter,
          child: Container(
            width: double.infinity,
            margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AdminTheme.backgroundDark, // 🔥 أوضح من gradient
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.25),
                  blurRadius: 15,
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                /// 🔥 Header (العنوان + زر X)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: const [
                        Icon(
                          Icons.notifications,
                          color: AdminTheme.textDark,
                        ),
                        SizedBox(width: 8),
                        Text(
                          "Notifications",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: AdminTheme.textDark,
                          ),
                        ),
                      ],
                    ),

                    /// ❌ زر الإغلاق
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.close,
                          size: 20,
                          color: AdminTheme.textDark,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 10),

                /// 🔥 النص
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    newNotifications == 0
                        ? 'No new issues'
                        : 'You have $newNotifications new issue(s)',
                    style: const TextStyle(
                      fontSize: 14,
                      color: AdminTheme.textMedium, // 🔥 واضح الآن
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                /// 🔥 القائمة
                if (newNotifications == 0)
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: Text(
                      'No notifications',
                      style: TextStyle(
                        color: AdminTheme.textMedium,
                        fontSize: 14,
                      ),
                    ),
                  )
                else
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: newNotifications,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white, // 🔥 كارد أبيض واضح
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: AdminTheme.primary.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Icon(
                                Icons.report_problem,
                                color: AdminTheme.primary,
                              ),
                            ),
                            const SizedBox(width: 10),
                            const Expanded(
                              child: Text(
                                'New issue reported',
                                style: TextStyle(
                                  color: AdminTheme.textDark,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
