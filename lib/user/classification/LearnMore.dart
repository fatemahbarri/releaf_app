import 'package:flutter/material.dart';
import 'package:releaf_app/widgets/app_background.dart';
import 'package:releaf_app/widgets/app_top_bar.dart';
import 'package:releaf_app/widgets/releaf_ui.dart';
import 'package:releaf_app/user/llm/Chatbot.dart';

class LearnMorePage extends StatelessWidget {
  final String wasteType;

  const LearnMorePage({super.key, required this.wasteType});

  @override
  Widget build(BuildContext context) {
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

    final Color subTextColor =
        isDarkMode ? Colors.white70 : ReLeafColors.textDark.withOpacity(0.65);

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
        'Rinse plastic containers before recycling.',
        'Check the recycling symbol on the item.',
        'Make sure bottles are empty and caps are secured.',
        'Avoid placing plastic bags in recycling bins.',
        'Try to reduce single-use plastics.',
      ],
      'glass': [
        'Rinse glass containers before recycling.',
        'Separate broken glass carefully.',
        'Do not mix glass with other materials.',
        'Remove lids if required.',
        'Reuse glass containers when possible.',
      ],
      'metal': [
        'Rinse metal cans to remove food residue.',
        'Flatten cans if possible to save space.',
        'Avoid mixing metal with other waste.',
        'Recycle aluminum and steel separately if required.',
        'Reuse containers when possible.',
      ],
      'paper': [
        'Keep paper clean and dry.',
        'Avoid recycling oily or wet paper.',
        'Flatten paper to save space.',
        'Separate paper from plastic coatings.',
        'Reuse paper when possible.',
      ],
      'cardboard': [
        'Flatten cardboard boxes before recycling.',
        'Keep cardboard dry and clean.',
        'Remove tape and labels if possible.',
        'Do not recycle wet cardboard.',
        'Reuse boxes when possible.',
      ],
      'trash': [
        'This item is not recyclable.',
        'Dispose of it in general waste.',
        'Avoid mixing with recyclable materials.',
        'Reduce usage of non-recyclable items.',
        'Look for reusable alternatives.',
      ],
    };

    final List<String> tipsList = tips[wasteType.toLowerCase().trim()] ??
        [
          'No recycling tips are available for this item.',
          'Try to identify the material before disposal.',
          'Avoid mixing unknown waste with recyclable materials.',
          'Check local recycling instructions when possible.',
          'Ask the chatbot for more information.',
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
              /// ✅ TOP BAR
              AppTopBar(
                title: wasteType,
                subtitle: 'Recycling Tips',
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
                        text: 'Chat Bot',
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
