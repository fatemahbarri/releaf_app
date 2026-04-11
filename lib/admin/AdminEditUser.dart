import 'package:flutter/material.dart';
class AdminEditUser extends StatefulWidget {
	const AdminEditUser({super.key});
	@override
	AdminEditUserState createState() => AdminEditUserState();
}
class AdminEditUserState extends State<AdminEditUser> {
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
											padding: const EdgeInsets.only( top: 50),
											child: Column(
												crossAxisAlignment: CrossAxisAlignment.start,
												children: [
													Container(
														margin: const EdgeInsets.only( bottom: 7, left: 8),
														width: 47,
														height: 41,
														child: Image.network(
															"https://storage.googleapis.com/tagjs-prod.appspot.com/v1/eZXFHBRH4B/8o43uemb_expires_30_days.png",
															fit: BoxFit.fill,
														)
													),
													IntrinsicHeight(
														child: Container(
															margin: const EdgeInsets.only( bottom: 2),
															width: double.infinity,
															child: Column(
																children: [
																	Container(
																		width: 162,
																		height: 162,
																		child: Image.network(
																			"https://storage.googleapis.com/tagjs-prod.appspot.com/v1/eZXFHBRH4B/7nuza0du_expires_30_days.png",
																			fit: BoxFit.fill,
																		)
																	),
																]
															),
														),
													),
													IntrinsicHeight(
														child: Container(
															margin: const EdgeInsets.only( bottom: 12),
															width: double.infinity,
															child: Column(
																children: [
																	Text(
																		"Sara Abdullah",
																		style: TextStyle(
																			color: Color(0xFF000000),
																			fontSize: 24,
																			fontWeight: FontWeight.bold,
																		),
																	),
																]
															),
														),
													),
													IntrinsicHeight(
														child: Container(
															margin: const EdgeInsets.only( bottom: 23),
															width: double.infinity,
															child: Column(
																children: [
																	Text(
																		"Active",
																		style: TextStyle(
																			color: Color(0xFFFFFFFF),
																			fontSize: 13,
																			fontWeight: FontWeight.bold,
																		),
																	),
																]
															),
														),
													),
													Container(
														color: Color(0xADB0B0B0),
														margin: const EdgeInsets.only( bottom: 40, left: 24, right: 24),
														height: 1,
														width: double.infinity,
														child: SizedBox(),
													),
													IntrinsicHeight(
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
															padding: const EdgeInsets.only( top: 12, bottom: 12, left: 10, right: 10),
															margin: const EdgeInsets.only( bottom: 14, left: 43, right: 43),
															width: double.infinity,
															child: Row(
																mainAxisAlignment: MainAxisAlignment.spaceBetween,
																children: [
																	Text(
																		"Sara",
																		style: TextStyle(
																			color: Color(0xFF000000),
																			fontSize: 20,
																			fontWeight: FontWeight.bold,
																		),
																	),
																	Container(
																		width: 25,
																		height: 25,
																		child: Image.network(
																			"https://storage.googleapis.com/tagjs-prod.appspot.com/v1/eZXFHBRH4B/9e7geh4r_expires_30_days.png",
																			fit: BoxFit.fill,
																		)
																	),
																]
															),
														),
													),
													IntrinsicHeight(
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
															padding: const EdgeInsets.only( top: 11, bottom: 11, left: 10, right: 10),
															margin: const EdgeInsets.only( bottom: 13, left: 43, right: 43),
															width: double.infinity,
															child: Row(
																mainAxisAlignment: MainAxisAlignment.spaceBetween,
																children: [
																	Text(
																		"Abdullah",
																		style: TextStyle(
																			color: Color(0xFF000000),
																			fontSize: 20,
																			fontWeight: FontWeight.bold,
																		),
																	),
																	Container(
																		width: 25,
																		height: 25,
																		child: Image.network(
																			"https://storage.googleapis.com/tagjs-prod.appspot.com/v1/eZXFHBRH4B/znnfe6np_expires_30_days.png",
																			fit: BoxFit.fill,
																		)
																	),
																]
															),
														),
													),
													IntrinsicHeight(
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
															padding: const EdgeInsets.only( top: 12, bottom: 12, left: 10, right: 10),
															margin: const EdgeInsets.only( bottom: 10, left: 43, right: 43),
															width: double.infinity,
															child: Row(
																mainAxisAlignment: MainAxisAlignment.spaceBetween,
																children: [
																	Text(
																		"saraabdu",
																		style: TextStyle(
																			color: Color(0xFF000000),
																			fontSize: 20,
																			fontWeight: FontWeight.bold,
																		),
																	),
																	Container(
																		width: 25,
																		height: 25,
																		child: Image.network(
																			"https://storage.googleapis.com/tagjs-prod.appspot.com/v1/eZXFHBRH4B/mlzbeaw5_expires_30_days.png",
																			fit: BoxFit.fill,
																		)
																	),
																]
															),
														),
													),
													IntrinsicHeight(
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
															padding: const EdgeInsets.only( top: 12, bottom: 12, left: 10, right: 10),
															margin: const EdgeInsets.only( bottom: 102, left: 43, right: 43),
															width: double.infinity,
															child: Row(
																mainAxisAlignment: MainAxisAlignment.spaceBetween,
																children: [
																	Text(
																		"sara@gmail.com",
																		style: TextStyle(
																			color: Color(0xFF000000),
																			fontSize: 20,
																			fontWeight: FontWeight.bold,
																		),
																	),
																	Container(
																		width: 25,
																		height: 25,
																		child: Image.network(
																			"https://storage.googleapis.com/tagjs-prod.appspot.com/v1/eZXFHBRH4B/u0mikeng_expires_30_days.png",
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
																					padding: const EdgeInsets.only( top: 16, bottom: 16, left: 59, right: 59),
																					child: Column(
																						crossAxisAlignment: CrossAxisAlignment.start,
																						children: [
																							Text(
																								"Save",
																								style: TextStyle(
																									color: Color(0xFF5B5656),
																									fontSize: 22,
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
															padding: const EdgeInsets.only( left: 4, right: 4),
															margin: const EdgeInsets.only( bottom: 3),
															width: double.infinity,
															child: Row(
																children: [
																	IntrinsicWidth(
																		child: IntrinsicHeight(
																			child: Container(
																				margin: const EdgeInsets.only( right: 47),
																				child: Column(
																					crossAxisAlignment: CrossAxisAlignment.start,
																					children: [
																						Container(
																							margin: const EdgeInsets.only( bottom: 4),
																							width: 56,
																							height: 32,
																							child: Image.network(
																								"https://storage.googleapis.com/tagjs-prod.appspot.com/v1/eZXFHBRH4B/qgs6veym_expires_30_days.png",
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
																								"https://storage.googleapis.com/tagjs-prod.appspot.com/v1/eZXFHBRH4B/l6sphlpu_expires_30_days.png",
																								fit: BoxFit.fill,
																							)
																						),
																						Container(
																							margin: const EdgeInsets.only( left: 12),
																							child: Text(
																								"Users",
																								style: TextStyle(
																									color: Color(0xFF625B71),
																									fontSize: 12,
																								),
																							),
																						),
																					]
																				),
																			),
																		),
																	),
																	Expanded(
																		child: IntrinsicHeight(
																			child: Container(
																				padding: const EdgeInsets.symmetric(vertical: 6),
																				width: double.infinity,
																				child: Column(
																					children: [
																						Container(
																							margin: const EdgeInsets.only( bottom: 4),
																							width: 56,
																							height: 32,
																							child: Image.network(
																								"https://storage.googleapis.com/tagjs-prod.appspot.com/v1/eZXFHBRH4B/8enrlnxp_expires_30_days.png",
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
																	Expanded(
																		child: IntrinsicHeight(
																			child: Container(
																				padding: const EdgeInsets.symmetric(vertical: 6),
																				width: double.infinity,
																				child: Column(
																					children: [
																						Container(
																							margin: const EdgeInsets.only( bottom: 4),
																							width: 56,
																							height: 32,
																							child: Image.network(
																								"https://storage.googleapis.com/tagjs-prod.appspot.com/v1/eZXFHBRH4B/9ih91rot_expires_30_days.png",
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