import 'package:flutter/material.dart';
class AdminHomePage extends StatefulWidget {
	const AdminHomePage({super.key});
	@override
	AdminHomePageState createState() => AdminHomePageState();
}
class AdminHomePageState extends State<AdminHomePage> {
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
										padding: const EdgeInsets.only( top: 24),
										child: Column(
											crossAxisAlignment: CrossAxisAlignment.start,
											children: [
												Container(
													margin: const EdgeInsets.only( bottom: 50, left: 19),
													width: 48,
													height: 42,
													child: Image.network(
														"https://storage.googleapis.com/tagjs-prod.appspot.com/v1/eZXFHBRH4B/nnncwmix_expires_30_days.png",
														fit: BoxFit.fill,
													)
												),
												IntrinsicHeight(
													child: Container(
														margin: const EdgeInsets.only( bottom: 82),
														width: double.infinity,
														child: Column(
															children: [
																Text(
																	"Welcome, Admin",
																	style: TextStyle(
																		color: Color(0xFF7CA385),
																		fontSize: 36,
																		fontWeight: FontWeight.bold,
																	),
																),
															]
														),
													),
												),
												Container(
													margin: const EdgeInsets.only( bottom: 38, left: 45),
													child: Text(
														"Dashboard",
														style: TextStyle(
															color: Color(0xFF675F5A),
															fontSize: 32,
															fontWeight: FontWeight.bold,
														),
													),
												),
												IntrinsicHeight(
													child: Container(
														margin: const EdgeInsets.only( bottom: 45, left: 34, right: 34),
														width: double.infinity,
														child: Row(
															children: [
																Expanded(
																	child: InkWell(
																		onTap: () { print('Pressed'); },
																		child: IntrinsicHeight(
																			child: Container(
																				decoration: BoxDecoration(
																					borderRadius: BorderRadius.circular(27),
																					color: Color(0xFF499A64),
																					boxShadow: [
																						BoxShadow(
																							color: Color(0x40000000),
																							blurRadius: 4,
																							offset: Offset(0, 4),
																						),
																					],
																				),
																				padding: const EdgeInsets.symmetric(vertical: 31),
																				margin: const EdgeInsets.only( right: 24),
																				width: double.infinity,
																				child: Column(
																					children: [
																						Container(
																							margin: const EdgeInsets.only( bottom: 23),
																							child: Text(
																								"Total Users",
																								style: TextStyle(
																									color: Color(0xFFFFFFFF),
																									fontSize: 22,
																									fontWeight: FontWeight.bold,
																								),
																							),
																						),
																						Text(
																							"200",
																							style: TextStyle(
																								color: Color(0xFFFFFFFF),
																								fontSize: 24,
																								fontWeight: FontWeight.bold,
																							),
																						),
																					]
																				),
																			),
																		),
																	),
																),
																Expanded(
																	child: InkWell(
																		onTap: () { print('Pressed'); },
																		child: IntrinsicHeight(
																			child: Container(
																				decoration: BoxDecoration(
																					borderRadius: BorderRadius.circular(27),
																					color: Color(0xFF499A64),
																					boxShadow: [
																						BoxShadow(
																							color: Color(0x40000000),
																							blurRadius: 4,
																							offset: Offset(0, 4),
																						),
																					],
																				),
																				padding: const EdgeInsets.symmetric(vertical: 30),
																				width: double.infinity,
																				child: Column(
																					children: [
																						Container(
																							margin: const EdgeInsets.only( bottom: 24),
																							child: Text(
																								"Active Users",
																								style: TextStyle(
																									color: Color(0xFFFFFFFF),
																									fontSize: 22,
																									fontWeight: FontWeight.bold,
																								),
																							),
																						),
																						Text(
																							"115",
																							style: TextStyle(
																								color: Color(0xFFFFFFFF),
																								fontSize: 24,
																								fontWeight: FontWeight.bold,
																							),
																						),
																					]
																				),
																			),
																		),
																	),
																),
															]
														),
													),
												),
												IntrinsicHeight(
													child: Container(
														margin: const EdgeInsets.only( bottom: 214, left: 34, right: 34),
														width: double.infinity,
														child: Row(
															children: [
																Expanded(
																	child: IntrinsicHeight(
																		child: Container(
																			decoration: BoxDecoration(
																				borderRadius: BorderRadius.circular(27),
																				color: Color(0xFF499A64),
																				boxShadow: [
																					BoxShadow(
																						color: Color(0x40000000),
																						blurRadius: 4,
																						offset: Offset(0, 4),
																					),
																				],
																			),
																			padding: const EdgeInsets.only( top: 38),
																			margin: const EdgeInsets.only( right: 24),
																			width: double.infinity,
																			child: Column(
																				children: [
																					Container(
																						margin: const EdgeInsets.only( bottom: 24),
																						child: Text(
																							"Total Bins",
																							style: TextStyle(
																								color: Color(0xFFFFFFFF),
																								fontSize: 22,
																								fontWeight: FontWeight.bold,
																							),
																						),
																					),
																					Container(
																						margin: const EdgeInsets.only( bottom: 23),
																						child: Text(
																							"50",
																							style: TextStyle(
																								color: Color(0xFFFFFFFF),
																								fontSize: 24,
																								fontWeight: FontWeight.bold,
																							),
																						),
																					),
																				]
																			),
																		),
																	),
																),
																Expanded(
																	child: InkWell(
																		onTap: () { print('Pressed'); },
																		child: IntrinsicHeight(
																			child: Container(
																				decoration: BoxDecoration(
																					borderRadius: BorderRadius.circular(27),
																					color: Color(0xFF499A64),
																					boxShadow: [
																						BoxShadow(
																							color: Color(0x40000000),
																							blurRadius: 4,
																							offset: Offset(0, 4),
																						),
																					],
																				),
																				padding: const EdgeInsets.symmetric(vertical: 21),
																				width: double.infinity,
																				child: Column(
																					children: [
																						Container(
																							margin: const EdgeInsets.only( bottom: 13),
																							width: 88,
																							child: Text(
																								"Reported \nIssues",
																								style: TextStyle(
																									color: Color(0xFFFFFFFF),
																									fontSize: 22,
																									fontWeight: FontWeight.bold,
																								),
																								textAlign: TextAlign.center,
																							),
																						),
																						Text(
																							"4",
																							style: TextStyle(
																								color: Color(0xFF9C1111),
																								fontSize: 24,
																								fontWeight: FontWeight.bold,
																							),
																						),
																					]
																				),
																			),
																		),
																	),
																),
															]
														),
													),
												),
												IntrinsicHeight(
													child: Container(
														color: Color(0xFFCDE9C7),
														width: double.infinity,
														child: SingleChildScrollView(
															scrollDirection: Axis.horizontal,
															child: Row(
																crossAxisAlignment: CrossAxisAlignment.start,
																children: [
																	IntrinsicWidth(
																		child: IntrinsicHeight(
																			child: Container(
																				padding: const EdgeInsets.only( top: 6, bottom: 6, left: 23, right: 23),
																				child: Column(
																					children: [
																						Container(
																							margin: const EdgeInsets.only( bottom: 4),
																							width: 56,
																							height: 32,
																							child: Image.network(
																								"https://storage.googleapis.com/tagjs-prod.appspot.com/v1/eZXFHBRH4B/mr0p2evv_expires_30_days.png",
																								fit: BoxFit.fill,
																							)
																						),
																						Text(
																							"Home",
																							style: TextStyle(
																								color: Color(0xFF625B71),
																								fontSize: 12,
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
																				padding: const EdgeInsets.only( top: 6, bottom: 6, left: 23, right: 23),
																				child: Column(
																					children: [
																						Container(
																							margin: const EdgeInsets.only( bottom: 4),
																							width: 56,
																							height: 32,
																							child: Image.network(
																								"https://storage.googleapis.com/tagjs-prod.appspot.com/v1/eZXFHBRH4B/1gjjn8ia_expires_30_days.png",
																								fit: BoxFit.fill,
																							)
																						),
																						Text(
																							"Users",
																							style: TextStyle(
																								color: Color(0xFF49454F),
																								fontSize: 12,
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
																				padding: const EdgeInsets.only( top: 6, bottom: 6, left: 23, right: 23),
																				child: Column(
																					children: [
																						Container(
																							margin: const EdgeInsets.only( bottom: 4),
																							width: 56,
																							height: 32,
																							child: Image.network(
																								"https://storage.googleapis.com/tagjs-prod.appspot.com/v1/eZXFHBRH4B/kxpqy7l6_expires_30_days.png",
																								fit: BoxFit.fill,
																							)
																						),
																						Text(
																							"Bins",
																							style: TextStyle(
																								color: Color(0xFF49454F),
																								fontSize: 12,
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
																				padding: const EdgeInsets.only( top: 6, bottom: 6, left: 23, right: 23),
																				child: Column(
																					children: [
																						Container(
																							margin: const EdgeInsets.only( bottom: 4),
																							width: 56,
																							height: 32,
																							child: Image.network(
																								"https://storage.googleapis.com/tagjs-prod.appspot.com/v1/eZXFHBRH4B/avc82myt_expires_30_days.png",
																								fit: BoxFit.fill,
																							)
																						),
																						Text(
																							"Profile",
																							style: TextStyle(
																								color: Color(0xFF49454F),
																								fontSize: 12,
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