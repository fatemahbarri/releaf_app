import 'package:flutter/material.dart';
class ChatBox extends StatefulWidget {
	const ChatBox({super.key});
	@override
	ChatBoxState createState() => ChatBoxState();
}
class ChatBoxState extends State<ChatBox> {
	@override
	Widget build(BuildContext context) {
		return Scaffold(
			body: SafeArea(
				child: Container(
					constraints: const BoxConstraints.expand(),
					color: Color(0xFFFFFFFF),
					child: Column(
						crossAxisAlignment: CrossAxisAlignment.start,
						children: [
							Expanded(
								child: Container(
									color: Color(0xFFF3FFE2),
									width: double.infinity,
									height: double.infinity,
									child: SingleChildScrollView(
										child: Column(
											crossAxisAlignment: CrossAxisAlignment.start,
											children: [
											],
										)
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