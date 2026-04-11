import 'package:flutter/material.dart';
class UserLogIn extends StatefulWidget {
	const UserLogIn({super.key});
	@override
	UserLogInState createState() => UserLogInState();
}
class UserLogInState extends State<UserLogIn> {
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
								child: IntrinsicHeight(
									child: Container(
										color: Color(0xFFF3FFE2),
										width: double.infinity,
										height: double.infinity,
										child: SingleChildScrollView(
											padding: const EdgeInsets.only( top: 51),
											child: Column(
												crossAxisAlignment: CrossAxisAlignment.start,
												children: [
													IntrinsicHeight(
														child: Container(
															margin: const EdgeInsets.only( bottom: 60, left: 25, right: 12),
															width: double.infinity,
															child: Row(
																mainAxisAlignment: MainAxisAlignment.spaceBetween,
																crossAxisAlignment: CrossAxisAlignment.start,
																children: [
																	Container(
																		width: 47,
																		height: 41,
																		child: Image.network(
																			"https://storage.googleapis.com/tagjs-prod.appspot.com/v1/eZXFHBRH4B/t7nr079k_expires_30_days.png",
																			fit: BoxFit.fill,
																		)
																	),
																	Container(
																		margin: const EdgeInsets.only( top: 11),
																		child: Text(
																			"User Login",
																			style: TextStyle(
																				color: Color(0xFF498056),
																				fontSize: 40,
																				fontWeight: FontWeight.bold,
																			),
																		),
																	),
																	Container(
																		width: 47,
																		height: 41,
																		child: SizedBox(),
																	),
																]
															),
														),
													),
													IntrinsicHeight(
														child: Container(
															margin: const EdgeInsets.only( bottom: 31),
															width: double.infinity,
															child: Column(
																children: [
																	Container(
																		width: 178,
																		height: 163,
																		child: Image.network(
																			"https://storage.googleapis.com/tagjs-prod.appspot.com/v1/eZXFHBRH4B/wl6fksg0_expires_30_days.png",
																			fit: BoxFit.fill,
																		)
																	),
																]
															),
														),
													),
													IntrinsicHeight(
														child: Container(
															margin: const EdgeInsets.only( bottom: 32),
															width: double.infinity,
															child: Column(
																children: [
																	Text(
																		"Welcome Back ",
																		style: TextStyle(
																			color: Color(0xFF7BA285),
																			fontSize: 35,
																			fontWeight: FontWeight.bold,
																		),
																	),
																]
															),
														),
													),
													IntrinsicHeight(
														child: Container(
															margin: const EdgeInsets.only( bottom: 40),
															width: double.infinity,
															child: Column(
																children: [
																	Text(
																		"Enter your credentials to continue ",
																		style: TextStyle(
																			color: Color(0xFF675F5A),
																			fontSize: 18,
																			fontWeight: FontWeight.bold,
																		),
																	),
																]
															),
														),
													),
													IntrinsicWidth(
														child: IntrinsicHeight(
															child: Container(
																decoration: BoxDecoration(
																	border: Border.all(
																		color: Color(0xFFC4C4C4),
																		width: 1,
																	),
																	color: Color(0xFFFFFFFF),
																	boxShadow: [
																		BoxShadow(
																			color: Color(0x40000000),
																			blurRadius: 4,
																			offset: Offset(0, 4),
																		),
																	],
																),
																padding: const EdgeInsets.only( top: 11, bottom: 11, left: 23, right: 115),
																margin: const EdgeInsets.only( bottom: 35, left: 49),
																child: Column(
																	crossAxisAlignment: CrossAxisAlignment.start,
																	children: [
																		Text(
																			"Email or Username",
																			style: TextStyle(
																				color: Color(0xFF000000),
																				fontSize: 20,
																				fontWeight: FontWeight.bold,
																			),
																		),
																	]
																),
															),
														),
													),
													IntrinsicWidth(
														child: IntrinsicHeight(
															child: Container(
																decoration: BoxDecoration(
																	border: Border.all(
																		color: Color(0xFFC4C4C4),
																		width: 1,
																	),
																	color: Color(0xFFFFFFFF),
																	boxShadow: [
																		BoxShadow(
																			color: Color(0x40000000),
																			blurRadius: 4,
																			offset: Offset(0, 4),
																		),
																	],
																),
																padding: const EdgeInsets.only( top: 11, bottom: 11, left: 23, right: 202),
																margin: const EdgeInsets.only( bottom: 34, left: 49),
																child: Column(
																	crossAxisAlignment: CrossAxisAlignment.start,
																	children: [
																		Text(
																			"Password",
																			style: TextStyle(
																				color: Color(0xFF000000),
																				fontSize: 20,
																				fontWeight: FontWeight.bold,
																			),
																		),
																	]
																),
															),
														),
													),
													InkWell(
														onTap: () { print('Pressed'); },
														child: IntrinsicHeight(
															child: Container(
																decoration: BoxDecoration(
																	borderRadius: BorderRadius.circular(142),
																	color: Color(0xFF499A64),
																	boxShadow: [
																		BoxShadow(
																			color: Color(0x40000000),
																			blurRadius: 4,
																			offset: Offset(0, 4),
																		),
																	],
																),
																padding: const EdgeInsets.symmetric(vertical: 5),
																margin: const EdgeInsets.only( bottom: 22, left: 48, right: 48),
																width: double.infinity,
																child: Column(
																	children: [
																		Text(
																			"Login",
																			style: TextStyle(
																				color: Color(0xFFFFFFFF),
																				fontSize: 26,
																				fontWeight: FontWeight.bold,
																			),
																		),
																	]
																),
															),
														),
													),
													IntrinsicHeight(
														child: Container(
															margin: const EdgeInsets.only( bottom: 48),
															width: double.infinity,
															child: Column(
																children: [
																	Text(
																		"Don’t have an account? Sign up",
																		style: TextStyle(
																			color: Color(0xFF4676AE),
																			fontSize: 18,
																			fontWeight: FontWeight.bold,
																		),
																	),
																]
															),
														),
													),
												],
											)
										),
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