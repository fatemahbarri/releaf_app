import 'package:flutter/material.dart';
class AdminLogIn extends StatefulWidget {
	const AdminLogIn({super.key});
	@override
	AdminLogInState createState() => AdminLogInState();
}
class AdminLogInState extends State<AdminLogIn> {
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
													IntrinsicWidth(
														child: IntrinsicHeight(
															child: Container(
																margin: const EdgeInsets.only( bottom: 60, left: 25, right: 13),
																width: double.infinity,
																child: Row(
																	crossAxisAlignment: CrossAxisAlignment.start,
																	children: [
																		Container(
																			margin: const EdgeInsets.only( right: 17),
																			width: 47,
																			height: 41,
																			child: Image.network(
																				"https://storage.googleapis.com/tagjs-prod.appspot.com/v1/eZXFHBRH4B/sitteftp_expires_30_days.png",
																				fit: BoxFit.fill,
																			)
																		),
																		Container(
																			margin: const EdgeInsets.only( top: 11, right: 17),
																			child: Text(
																				"Admin Login",
																				style: TextStyle(
																					color: Color(0xFF498056),
																					fontSize: 40,
																					fontWeight: FontWeight.bold,
																				),
																			),
																		),
																		SizedBox(
																			width: 47,
																			height: 41,
																			child: SizedBox(),
																		),
																	]
																),
															),
														),
													),
													IntrinsicHeight(
														child: Container(
															margin: const EdgeInsets.only( bottom: 31),
															width: double.infinity,
															child: Column(
																children: [
																	SizedBox(
																		width: 178,
																		height: 163,
																		child: Image.network(
																			"https://storage.googleapis.com/tagjs-prod.appspot.com/v1/eZXFHBRH4B/n0k4ltxc_expires_30_days.png",
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
																margin: const EdgeInsets.only( bottom: 48, left: 48, right: 48),
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