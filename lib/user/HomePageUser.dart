import 'package:flutter/material.dart';
class HomePageUser extends StatefulWidget {
	const HomePageUser({super.key});
	@override
	HomePageUserState createState() => HomePageUserState();
}
class HomePageUserState extends State<HomePageUser> {
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
										padding: const EdgeInsets.only( top: 80),
										child: Column(
											crossAxisAlignment: CrossAxisAlignment.start,
											children: [
												IntrinsicHeight(
													child: Container(
														margin: const EdgeInsets.only( bottom: 45),
														width: double.infinity,
														child: Column(
															children: [
																Text(
																	"Welcome, Sara",
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
												IntrinsicHeight(
													child: Container(
														margin: const EdgeInsets.only( bottom: 3),
														width: double.infinity,
														child: Column(
															children: [
																Container(
																	width: 293,
																	child: Text(
																		"Recycle today for a cleaner tomorrow!",
																		style: TextStyle(
																			color: Color(0xFF675F5A),
																			fontSize: 24,
																			fontWeight: FontWeight.bold,
																		),
																		textAlign: TextAlign.center,
																	),
																),
															]
														),
													),
												),
												Container(
													margin: const EdgeInsets.only( bottom: 16, left: 13, right: 13),
													height: 255,
													width: double.infinity,
													child: Image.network(
														"https://storage.googleapis.com/tagjs-prod.appspot.com/v1/eZXFHBRH4B/fc3yp63v_expires_30_days.png",
														fit: BoxFit.fill,
													)
												),
												IntrinsicHeight(
													child: Container(
														margin: const EdgeInsets.only( bottom: 19, left: 31, right: 31),
														width: double.infinity,
														child: Column(
															crossAxisAlignment: CrossAxisAlignment.start,
															children: [
																Container(
																	margin: const EdgeInsets.only( bottom: 23, left: 13),
																	child: Text(
																		"Activities",
																		style: TextStyle(
																			color: Color(0xFF675F5A),
																			fontSize: 30,
																			fontWeight: FontWeight.bold,
																		),
																	),
																),
																InkWell(
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
																			padding: const EdgeInsets.symmetric(vertical: 12),
																			margin: const EdgeInsets.only( bottom: 16),
																			width: double.infinity,
																			child: Column(
																				children: [
																					Text(
																						"Tips",
																						style: TextStyle(
																							color: Color(0xFFFFFFFF),
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
																			padding: const EdgeInsets.symmetric(vertical: 14),
																			margin: const EdgeInsets.only( bottom: 16),
																			width: double.infinity,
																			child: Column(
																				children: [
																					Text(
																						"Scan Trash",
																						style: TextStyle(
																							color: Color(0xFFFFFFFF),
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
																			padding: const EdgeInsets.symmetric(vertical: 14),
																			width: double.infinity,
																			child: Column(
																				children: [
																					Text(
																						"Location",
																						style: TextStyle(
																							color: Color(0xFFFFFFFF),
																							fontSize: 20,
																							fontWeight: FontWeight.bold,
																						),
																					),
																				]
																			),
																		),
																	),
																),
															]
														),
													),
												),
												InkWell(
													onTap: () { print('Pressed'); },
													child: IntrinsicWidth(
														child: IntrinsicHeight(
															child: Container(
																decoration: BoxDecoration(
																	borderRadius: BorderRadius.circular(142),
																	color: Color(0xFF8DC149),
																	boxShadow: [
																		BoxShadow(
																			color: Color(0x40000000),
																			blurRadius: 4,
																			offset: Offset(0, 4),
																		),
																	],
																),
																padding: const EdgeInsets.only( top: 10, bottom: 10, left: 9, right: 9),
																margin: const EdgeInsets.only( bottom: 17, left: 10),
																child: Column(
																	crossAxisAlignment: CrossAxisAlignment.start,
																	children: [
																		Container(
																			width: 40,
																			height: 40,
																			child: Image.network(
																				"https://storage.googleapis.com/tagjs-prod.appspot.com/v1/eZXFHBRH4B/m58pzf8y_expires_30_days.png",
																				fit: BoxFit.fill,
																			)
																		),
																	]
																),
															),
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
																								"https://storage.googleapis.com/tagjs-prod.appspot.com/v1/eZXFHBRH4B/sep7xhso_expires_30_days.png",
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
																								"https://storage.googleapis.com/tagjs-prod.appspot.com/v1/eZXFHBRH4B/ooib99q7_expires_30_days.png",
																								fit: BoxFit.fill,
																							)
																						),
																						Text(
																							"Camera",
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
																								"https://storage.googleapis.com/tagjs-prod.appspot.com/v1/eZXFHBRH4B/glazf56n_expires_30_days.png",
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
																								"https://storage.googleapis.com/tagjs-prod.appspot.com/v1/eZXFHBRH4B/96m86ems_expires_30_days.png",
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