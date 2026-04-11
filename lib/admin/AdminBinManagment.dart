import 'package:flutter/material.dart';
class AdminBinManagment extends StatefulWidget {
	const AdminBinManagment({super.key});
	@override
	AdminBinManagmentState createState() => AdminBinManagmentState();
}
class AdminBinManagmentState extends State<AdminBinManagment> {
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
											padding: const EdgeInsets.only( top: 47),
											child: Column(
												crossAxisAlignment: CrossAxisAlignment.start,
												children: [
													IntrinsicWidth(
														child: IntrinsicHeight(
															child: Container(
																margin: const EdgeInsets.only( bottom: 7, left: 12),
																child: Row(
																	children: [
																		Container(
																			width: 47,
																			height: 41,
																			child: Image.network(
																				"https://storage.googleapis.com/tagjs-prod.appspot.com/v1/eZXFHBRH4B/uxn0kdiw_expires_30_days.png",
																				fit: BoxFit.fill,
																			)
																		),
																		IntrinsicWidth(
																			child: IntrinsicHeight(
																				child: Container(
																					padding: const EdgeInsets.only( top: 4, bottom: 4, left: 29, right: 29),
																					child: Column(
																						crossAxisAlignment: CrossAxisAlignment.start,
																						children: [
																							Text(
																								"Bins Management",
																								style: TextStyle(
																									color: Color(0xFF7CA385),
																									fontSize: 28,
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
													),
													Container(
														color: Color(0xADB0B0B0),
														margin: const EdgeInsets.only( bottom: 17),
														height: 1,
														width: double.infinity,
														child: SizedBox(),
													),
													IntrinsicHeight(
														child: Container(
															margin: const EdgeInsets.only( bottom: 18, left: 30, right: 30),
															width: double.infinity,
															child: Row(
																children: [
																	Expanded(
																		child: IntrinsicHeight(
																			child: Container(
																				decoration: BoxDecoration(
																					border: Border.all(
																						color: Color(0xFFD9D9D9),
																						width: 1,
																					),
																					borderRadius: BorderRadius.circular(9999),
																					color: Color(0xFFFFFFFF),
																				),
																				padding: const EdgeInsets.only( top: 12, bottom: 12, left: 16, right: 16),
																				margin: const EdgeInsets.only( right: 20),
																				width: double.infinity,
																				child: Row(
																					mainAxisAlignment: MainAxisAlignment.spaceBetween,
																					children: [
																						Text(
																							"Search Location",
																							style: TextStyle(
																								color: Color(0xFFB3B3B3),
																								fontSize: 16,
																							),
																						),
																						Container(
																							decoration: BoxDecoration(
																								borderRadius: BorderRadius.circular(9999),
																							),
																							width: 16,
																							height: 16,
																							child: ClipRRect(
																								borderRadius: BorderRadius.circular(9999),
																								child: Image.network(
																									"https://storage.googleapis.com/tagjs-prod.appspot.com/v1/eZXFHBRH4B/l4qxdref_expires_30_days.png",
																									fit: BoxFit.fill,
																								)
																							)
																						),
																					]
																				),
																			),
																		),
																	),
																	Container(
																		width: 24,
																		height: 24,
																		child: Image.network(
																			"https://storage.googleapis.com/tagjs-prod.appspot.com/v1/eZXFHBRH4B/n72q8nrr_expires_30_days.png",
																			fit: BoxFit.fill,
																		)
																	),
																]
															),
														),
													),
													Container(
														margin: const EdgeInsets.only( bottom: 65, left: 13, right: 13),
														height: 225,
														width: double.infinity,
														child: Image.network(
															"https://storage.googleapis.com/tagjs-prod.appspot.com/v1/eZXFHBRH4B/vk4f94rx_expires_30_days.png",
															fit: BoxFit.fill,
														)
													),
													Container(
														margin: const EdgeInsets.only( bottom: 43, left: 32),
														child: Text(
															"Bins Category ",
															style: TextStyle(
																color: Color(0xFF675F5A),
																fontSize: 30,
																fontWeight: FontWeight.bold,
															),
														),
													),
													IntrinsicHeight(
														child: Container(
															margin: const EdgeInsets.only( bottom: 43, left: 8, right: 8),
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
																					padding: const EdgeInsets.symmetric(vertical: 35),
																					margin: const EdgeInsets.only( right: 18),
																					width: double.infinity,
																					child: Column(
																						children: [
																							Text(
																								"Cardboard",
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
																					padding: const EdgeInsets.symmetric(vertical: 35),
																					margin: const EdgeInsets.only( right: 16),
																					width: double.infinity,
																					child: Column(
																						children: [
																							Text(
																								"Glass",
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
																					padding: const EdgeInsets.symmetric(vertical: 35),
																					width: double.infinity,
																					child: Column(
																						children: [
																							Text(
																								"Metal",
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
																	),
																]
															),
														),
													),
													IntrinsicHeight(
														child: Container(
															margin: const EdgeInsets.only( bottom: 40, left: 8, right: 8),
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
																					padding: const EdgeInsets.symmetric(vertical: 34),
																					margin: const EdgeInsets.only( right: 18),
																					width: double.infinity,
																					child: Column(
																						children: [
																							Text(
																								"Paper",
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
																					padding: const EdgeInsets.symmetric(vertical: 35),
																					margin: const EdgeInsets.only( right: 16),
																					width: double.infinity,
																					child: Column(
																						children: [
																							Text(
																								"Plastic",
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
																					padding: const EdgeInsets.symmetric(vertical: 25),
																					width: double.infinity,
																					child: Column(
																						children: [
																							Text(
																								"Trash\n(non-recyclables)",
																								style: TextStyle(
																									color: Color(0xFFFFFFFF),
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
															child: Row(
																children: [
																	IntrinsicWidth(
																		child: IntrinsicHeight(
																			child: Container(
																				margin: const EdgeInsets.only( left: 14, right: 47),
																				child: Column(
																					crossAxisAlignment: CrossAxisAlignment.start,
																					children: [
																						Container(
																							margin: const EdgeInsets.only( bottom: 4),
																							width: 56,
																							height: 32,
																							child: Image.network(
																								"https://storage.googleapis.com/tagjs-prod.appspot.com/v1/eZXFHBRH4B/nry0xg7w_expires_30_days.png",
																								fit: BoxFit.fill,
																							)
																						),
																						Container(
																							margin: const EdgeInsets.only( left: 12),
																							child: Text(
																								"Home",
																								style: TextStyle(
																									color: Color(0xFF49454F),
																									fontSize: 12,
																								),
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
																				margin: const EdgeInsets.only( right: 23),
																				child: Column(
																					crossAxisAlignment: CrossAxisAlignment.start,
																					children: [
																						Container(
																							margin: const EdgeInsets.only( bottom: 4),
																							width: 56,
																							height: 32,
																							child: Image.network(
																								"https://storage.googleapis.com/tagjs-prod.appspot.com/v1/eZXFHBRH4B/yhy0uck6_expires_30_days.png",
																								fit: BoxFit.fill,
																							)
																						),
																						Container(
																							margin: const EdgeInsets.only( left: 12),
																							child: Text(
																								"Users",
																								style: TextStyle(
																									color: Color(0xFF49454F),
																									fontSize: 12,
																								),
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
																								"https://storage.googleapis.com/tagjs-prod.appspot.com/v1/eZXFHBRH4B/ab689835_expires_30_days.png",
																								fit: BoxFit.fill,
																							)
																						),
																						Text(
																							"Bins",
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