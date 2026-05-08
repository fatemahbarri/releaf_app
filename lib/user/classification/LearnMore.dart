import 'package:flutter/material.dart';
import 'package:releaf_app/widgets/app_background.dart';
import 'package:releaf_app/widgets/app_top_bar.dart';
import 'package:releaf_app/widgets/releaf_ui.dart';
import 'package:releaf_app/user/llm/Chatbot.dart';
import 'package:releaf_app/l10n/app_localizations.dart';

class LearnMorePage extends StatelessWidget {
  final String wasteType;

  const LearnMorePage({
    super.key,
    required this.wasteType,
  });

  String _translateCategory(String category, AppLocalizations l) {
    switch (category.toLowerCase().trim()) {
      case 'plastic':
        return l.locationCategoryPlastic;
      case 'glass':
        return l.locationCategoryGlass;
      case 'metal':
        return l.locationCategoryMetal;
      case 'paper':
        return l.locationCategoryPaper;
      case 'cardboard':
        return l.locationCategoryCardboard;
      case 'trash':
        return l.locationCategoryTrash;
      default:
        return category;
    }
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;

    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    final Color cardColor =
        isDarkMode ? const Color(0xFF1F2F2A) : Colors.white.withOpacity(0.96);

    final Color borderColor = isDarkMode
        ? Colors.white.withOpacity(0.08)
        : Colors.white.withOpacity(0.8);

    final Color shadowColor = isDarkMode
        ? Colors.black.withOpacity(0.25)
        : Colors.black.withOpacity(0.06);

    final Color mainTextColor =
        isDarkMode ? Colors.white : ReLeafColors.textDark;

    final List<Color> topBarGradient = isDarkMode
        ? const [
            Color(0xFF1B3A31),
            Color(0xFF2F5D50),
          ]
        : const [
            Color(0xFF7FB77E),
            Color(0xFF5E9C76),
          ];

    final Map<String, List<String>> tips = {
      'plastic': [
        l.plasticTip1,
        l.plasticTip2,
        l.plasticTip3,
        l.plasticTip4,
        l.plasticTip5,
      ],
      'glass': [
        l.glassTip1,
        l.glassTip2,
        l.glassTip3,
        l.glassTip4,
        l.glassTip5,
      ],
      'metal': [
        l.metalTip1,
        l.metalTip2,
        l.metalTip3,
        l.metalTip4,
        l.metalTip5,
      ],
      'paper': [
        l.paperTip1,
        l.paperTip2,
        l.paperTip3,
        l.paperTip4,
        l.paperTip5,
      ],
      'cardboard': [
        l.cardboardTip1,
        l.cardboardTip2,
        l.cardboardTip3,
        l.cardboardTip4,
        l.cardboardTip5,
      ],
      'trash': [
        l.trashTip1,
        l.trashTip2,
        l.trashTip3,
        l.trashTip4,
        l.trashTip5,
      ],
    };

    final List<String> tipsList = tips[wasteType.toLowerCase().trim()] ??
        [
          l.defaultTip1,
          l.defaultTip2,
          l.defaultTip3,
          l.defaultTip4,
          l.defaultTip5,
        ];

    Widget customCard({required Widget child}) {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 26,
        ),
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(22),
          border: Border.all(color: borderColor),
          boxShadow: [
            BoxShadow(
              color: shadowColor,
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: child,
      );
    }

    return AppBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Column(
            children: [
              AppTopBar(
                title: _translateCategory(wasteType, l),
                subtitle: l.learnMoreSubtitle,
                icon: Icons.eco_rounded,
                showBackButton: true,
                gradientColors: topBarGradient,
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(16, 18, 16, 20),
                  child: Column(
                    children: [
                      Center(
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.9,
                          child: customCard(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: tipsList.map((tip) {
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 16),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Icon(
                                        Icons.check_circle_outline,
                                        color: isDarkMode
                                            ? Colors.white70
                                            : ReLeafColors.primary,
                                        size: 22,
                                      ),
                                      const SizedBox(width: 12),
                                      Expanded(
                                        child: Text(
                                          tip,
                                          style: ReLeafTextStyles.body.copyWith(
                                            fontSize: 16,
                                            height: 1.5,
                                            color: mainTextColor,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      ReLeafButton(
                        text: l.chatBot,
                        icon: Icons.chat_bubble_outline,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const Chatbot(),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 30),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
