import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_markdown_plus/flutter_markdown_plus.dart';

import 'package:releaf_app/widgets/app_top_bar.dart';

class Chatbot extends StatefulWidget {
  const Chatbot({super.key});

  @override
  State<Chatbot> createState() => _ChatbotState();
}

class _ChatbotState extends State<Chatbot> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  bool _isLoading = false;

  final String _baseUrl = 'http://192.168.8.182:3000';

  final List<String> _quickQuestions = [
    'Where do I throw a plastic bottle?',
    'Can glass be recycled?',
    'How do I sort cardboard?',
    'What should I do with food waste?',
  ];

  final List<ChatMessage> _messages = [
    ChatMessage(
      text:
          "Hello! I’m ReLeaf Assistant 🌱\nI can help you sort waste, answer recycling questions, and guide you to the right disposal choice.",
      isUser: false,
    ),
  ];

  Future<void> _sendMessage({String? customMessage}) async {
    final String userMessage = customMessage ?? _messageController.text.trim();

    if (userMessage.isEmpty || _isLoading) return;

    setState(() {
      _messages.add(ChatMessage(text: userMessage, isUser: true));
      _isLoading = true;
    });

    _messageController.clear();
    _scrollToBottom();

    try {
      final Uri url = Uri.parse('$_baseUrl/ask-ai');

      final response = await http
          .post(
            url,
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode({'message': userMessage}),
          )
          .timeout(const Duration(seconds: 20));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        final String botReply =
            (data['reply'] ?? 'Sorry, I could not understand the response.')
                .toString();

        setState(() {
          _messages.add(ChatMessage(text: botReply, isUser: false));
        });
      } else {
        setState(() {
          _messages.add(
            ChatMessage(
              text:
                  "Sorry, I couldn’t connect to the server. (Error ${response.statusCode})",
              isUser: false,
              isError: true,
            ),
          );
        });
      }
    } catch (e) {
      setState(() {
        _messages.add(
          ChatMessage(
            text:
                "Connection error. Please make sure the backend is running and the API URL is correct.",
            isUser: false,
            isError: true,
          ),
        );
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
      _scrollToBottom();
    }
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent + 120,
          duration: const Duration(milliseconds: 350),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor:
          isDark ? const Color(0xFF101815) : const Color(0xFFF7FBF2),
      body: SafeArea(
        child: Column(
          children: [
            AppTopBar(
              title: 'ReLeaf Chatbot',
              subtitle: 'Your recycling assistant',
              icon: Icons.eco_rounded,
              showBackButton: true,
              showNotifications: false,
              gradientColors: isDark
                  ? const [
                      Color(0xFF1B3A31),
                      Color(0xFF2F5D50),
                    ]
                  : const [
                      Color(0xFF7FB77E),
                      Color(0xFF5E9C76),
                    ],
            ),
            Expanded(
              child: ListView(
                controller: _scrollController,
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                children: [
                  _buildWelcomeCard(),
                  const SizedBox(height: 14),
                  _buildQuickQuestions(),
                  const SizedBox(height: 12),
                  ..._messages.map((message) => _buildMessageBubble(message)),
                  if (_isLoading) _buildTypingBubble(),
                ],
              ),
            ),
            _buildInputArea(),
          ],
        ),
      ),
    );
  }

  Widget _buildWelcomeCard() {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1C2A24) : const Color(0xFFEAF6E3),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isDark ? const Color(0xFF2F5D50) : const Color(0xFFD6EBCF),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CircleAvatar(
            radius: 22,
            backgroundColor: Color(0xFF7FB77E),
            child: Icon(Icons.smart_toy_outlined, color: Colors.white),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hi there! 🌿',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white : const Color(0xFF2F5D50),
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'Ask me how to sort waste, what materials can be recycled, or where an item should go.',
                  style: TextStyle(
                    fontSize: 13.5,
                    color: isDark ? Colors.white70 : const Color(0xFF4E6A57),
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickQuestions() {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Try asking',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: isDark ? Colors.white70 : const Color(0xFF4D6655),
          ),
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: _quickQuestions.map((question) {
            return InkWell(
              borderRadius: BorderRadius.circular(20),
              onTap: () => _sendMessage(customMessage: question),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                decoration: BoxDecoration(
                  color: isDark ? const Color(0xFF1C2A24) : Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: isDark
                        ? const Color(0xFF2F5D50)
                        : const Color(0xFFD9E7D2),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(isDark ? 0.18 : 0.03),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Text(
                  question,
                  style: TextStyle(
                    fontSize: 12.5,
                    color: isDark ? Colors.white70 : const Color(0xFF41614C),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildMessageBubble(ChatMessage message) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final bool isUser = message.isUser;

    final Color botBubbleColor = message.isError
        ? (isDark ? const Color(0xFF3A2020) : const Color(0xFFFFEEEE))
        : (isDark ? const Color(0xFF1C2A24) : Colors.white);

    final Color botTextColor =
        isDark ? Colors.white.withOpacity(0.9) : const Color(0xFF263328);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment:
            isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (!isUser) ...[
            CircleAvatar(
              radius: 16,
              backgroundColor: message.isError
                  ? const Color(0xFFFFD6D6)
                  : isDark
                      ? const Color(0xFF244337)
                      : const Color(0xFFCEE8C9),
              child: Icon(
                message.isError ? Icons.error_outline : Icons.eco,
                size: 17,
                color: message.isError
                    ? Colors.redAccent
                    : const Color(0xFF7FB77E),
              ),
            ),
            const SizedBox(width: 8),
          ],
          Flexible(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              decoration: BoxDecoration(
                color: isUser ? const Color(0xFF7FB77E) : botBubbleColor,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(18),
                  topRight: const Radius.circular(18),
                  bottomLeft: Radius.circular(isUser ? 18 : 6),
                  bottomRight: Radius.circular(isUser ? 6 : 18),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(isDark ? 0.18 : 0.05),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: isUser
                  ? Text(
                      message.text,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14.5,
                        height: 1.45,
                      ),
                    )
                  : MarkdownBody(
                      data: message.text,
                      selectable: true,
                      shrinkWrap: true,
                      styleSheet: MarkdownStyleSheet(
                        p: TextStyle(
                          color: botTextColor,
                          fontSize: 14.5,
                          height: 1.45,
                        ),
                        strong: TextStyle(
                          color: botTextColor,
                          fontSize: 14.5,
                          height: 1.45,
                          fontWeight: FontWeight.bold,
                        ),
                        em: TextStyle(
                          color: botTextColor,
                          fontSize: 14.5,
                          height: 1.45,
                          fontStyle: FontStyle.italic,
                        ),
                        listBullet: TextStyle(
                          color: botTextColor,
                          fontSize: 14.5,
                          height: 1.45,
                        ),
                        h1: TextStyle(
                          color:
                              isDark ? Colors.white : const Color(0xFF2F5D50),
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        h2: TextStyle(
                          color:
                              isDark ? Colors.white : const Color(0xFF2F5D50),
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        h3: TextStyle(
                          color:
                              isDark ? Colors.white : const Color(0xFF2F5D50),
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                        blockSpacing: 10,
                        listIndent: 20,
                      ),
                    ),
            ),
          ),
          if (isUser) ...[
            const SizedBox(width: 8),
            CircleAvatar(
              radius: 16,
              backgroundColor:
                  isDark ? const Color(0xFF244337) : const Color(0xFFDDEFD7),
              child: const Icon(
                Icons.person,
                size: 17,
                color: Color(0xFF7FB77E),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildTypingBubble() {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          CircleAvatar(
            radius: 16,
            backgroundColor:
                isDark ? const Color(0xFF244337) : const Color(0xFFCEE8C9),
            child: const Icon(
              Icons.eco,
              size: 17,
              color: Color(0xFF7FB77E),
            ),
          ),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF1C2A24) : Colors.white,
              borderRadius: BorderRadius.circular(18),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(isDark ? 0.18 : 0.05),
                  blurRadius: 8,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(strokeWidth: 2.2),
                ),
                const SizedBox(width: 10),
                Text(
                  'ReLeaf is thinking...',
                  style: TextStyle(
                    fontSize: 13.5,
                    color: isDark ? Colors.white70 : const Color(0xFF4E6A57),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInputArea() {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.fromLTRB(14, 10, 14, 14),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF18221E) : Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(isDark ? 0.22 : 0.06),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(24),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color:
                    isDark ? const Color(0xFF101815) : const Color(0xFFF5F7F2),
                borderRadius: BorderRadius.circular(22),
                border: Border.all(
                  color: isDark
                      ? const Color(0xFF2F5D50)
                      : const Color(0xFFDCE8D7),
                ),
              ),
              child: TextField(
                controller: _messageController,
                minLines: 1,
                maxLines: 4,
                style: TextStyle(
                  color: isDark ? Colors.white : const Color(0xFF263328),
                  fontSize: 14,
                ),
                textInputAction: TextInputAction.send,
                onSubmitted: (_) => _sendMessage(),
                decoration: InputDecoration(
                  hintText: 'Ask about recycling or waste sorting...',
                  hintStyle: TextStyle(
                    color: isDark ? Colors.white38 : const Color(0xFF8A9A8C),
                    fontSize: 13.5,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 13,
                  ),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          GestureDetector(
            onTap: _isLoading ? null : () => _sendMessage(),
            child: Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF7FB77E), Color(0xFF5E9C76)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(18),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF7FB77E).withOpacity(0.35),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Icon(
                _isLoading ? Icons.hourglass_top_rounded : Icons.send_rounded,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ChatMessage {
  final String text;
  final bool isUser;
  final bool isError;

  ChatMessage({
    required this.text,
    required this.isUser,
    this.isError = false,
  });
}
