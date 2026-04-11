import 'package:flutter/material.dart';
class AdminUserManagment extends StatefulWidget {
	const AdminUserManagment({super.key});
	@override
	AdminUserManagmentState createState() => AdminUserManagmentState();
}
class AdminUserManagmentState extends State<AdminUserManagment> {
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
										padding: const EdgeInsets.only( top: 43),
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
																			"https://storage.googleapis.com/tagjs-prod.appspot.com/v1/eZXFHBRH4B/snbiizg7_expires_30_days.png",
																			fit: BoxFit.fill,
																		)
																	),
																	IntrinsicWidth(
																		child: IntrinsicHeight(
																			child: Container(
																				padding: const EdgeInsets.only( top: 5, bottom: 5, left: 21, right: 21),
																				child: Column(
																					crossAxisAlignment: CrossAxisAlignment.start,
																					children: [
																						Text(
																							"Users Management",
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
													margin: const EdgeInsets.only( bottom: 44),
													height: 1,
													width: double.infinity,
													child: SizedBox(),
												),
												IntrinsicHeight(
													child: Container(
														margin: const EdgeInsets.only( bottom: 33, left: 34, right: 34),
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
																						"Search User",
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
																								"https://storage.googleapis.com/tagjs-prod.appspot.com/v1/eZXFHBRH4B/5oqmyxxj_expires_30_days.png",
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
																		"https://storage.googleapis.com/tagjs-prod.appspot.com/v1/eZXFHBRH4B/h4419eii_expires_30_days.png",
																		fit: BoxFit.fill,
																	)
																),
															]
														),
													),
												),
												IntrinsicHeight(
													child: Container(
														margin: const EdgeInsets.only( bottom: 23, left: 35, right: 35),
														width: double.infinity,
														child: Row(
															children: [
																Expanded(
																	child: IntrinsicHeight(
																		child: Container(
																			decoration: BoxDecoration(
																				border: Border.all(
																					color: Color(0xFF989898),
																					width: 1,
																				),
																				borderRadius: BorderRadius.circular(14),
																				color: Color(0xFFFFFFFF),
																				boxShadow: [
																					BoxShadow(
																						color: Color(0x40000000),
																						blurRadius: 4,
																						offset: Offset(0, 4),
																					),
																				],
																			),
																			padding: const EdgeInsets.only( top: 16, bottom: 16, left: 15, right: 15),
																			margin: const EdgeInsets.only( right: 15),
																			width: double.infinity,
																			child: Row(
																				mainAxisAlignment: MainAxisAlignment.spaceBetween,
																				children: [
																					IntrinsicWidth(
																						child: IntrinsicHeight(
																							child: Column(
																								crossAxisAlignment: CrossAxisAlignment.start,
																								children: [
																									Container(
																										margin: const EdgeInsets.only( bottom: 25),
																										child: Text(
																											"Sara Abdullah",
																											style: TextStyle(
																												color: Color(0xFF000000),
																												fontSize: 18,
																												fontWeight: FontWeight.bold,
																											),
																										),
																									),
																									Text(
																										"sara@gmail.com",
																										style: TextStyle(
																											color: Color(0xFF000000),
																											fontSize: 15,
																											fontWeight: FontWeight.bold,
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
																										color: Color(0xFF7ACD0E),
																										boxShadow: [
																											BoxShadow(
																												color: Color(0x40000000),
																												blurRadius: 4,
																												offset: Offset(0, 4),
																											),
																										],
																									),
																									padding: const EdgeInsets.only( top: 12, bottom: 12, left: 31, right: 31),
																									child: Column(
																										crossAxisAlignment: CrossAxisAlignment.start,
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
																						),
																					),
																				]
																			),
																		),
																	),
																),
																Container(
																	width: 30,
																	height: 31,
																	child: Image.network(
																		"https://storage.googleapis.com/tagjs-prod.appspot.com/v1/eZXFHBRH4B/5erig15s_expires_30_days.png",
																		fit: BoxFit.fill,
																	)
																),
															]
														),
													),
												),
												IntrinsicHeight(
													child: Container(
														margin: const EdgeInsets.only( bottom: 23, left: 38, right: 22),
														width: double.infinity,
														child: Row(
															children: [
																Expanded(
																	child: IntrinsicHeight(
																		child: Container(
																			decoration: BoxDecoration(
																				border: Border.all(
																					color: Color(0xFF989898),
																					width: 1,
																				),
																				borderRadius: BorderRadius.circular(14),
																				color: Color(0xFFFFFFFF),
																				boxShadow: [
																					BoxShadow(
																						color: Color(0x40000000),
																						blurRadius: 4,
																						offset: Offset(0, 4),
																					),
																				],
																			),
																			padding: const EdgeInsets.only( top: 13, bottom: 13, right: 12),
																			margin: const EdgeInsets.only( right: 15),
																			width: double.infinity,
																			child: Column(
																				crossAxisAlignment: CrossAxisAlignment.start,
																				children: [
																					Container(
																						margin: const EdgeInsets.only( left: 9),
																						child: Text(
																							"Ahmad Ali",
																							style: TextStyle(
																								color: Color(0xFF000000),
																								fontSize: 18,
																								fontWeight: FontWeight.bold,
																							),
																						),
																					),
																					IntrinsicHeight(
																						child: Container(
																							margin: const EdgeInsets.only( left: 12),
																							width: double.infinity,
																							child: Row(
																								crossAxisAlignment: CrossAxisAlignment.start,
																								children: [
																									Expanded(
																										child: Container(
																											margin: const EdgeInsets.only( top: 25, right: 40),
																											width: double.infinity,
																											child: Text(
																												"Ahmad@gmail.com",
																												style: TextStyle(
																													color: Color(0xFF000000),
																													fontSize: 15,
																													fontWeight: FontWeight.bold,
																												),
																												textAlign: TextAlign.center,
																											),
																										),
																									),
																									Expanded(
																										child: InkWell(
																											onTap: () { print('Pressed'); },
																											child: IntrinsicHeight(
																												child: Container(
																													decoration: BoxDecoration(
																														borderRadius: BorderRadius.circular(142),
																														color: Color(0xFF7ACD0E),
																														boxShadow: [
																															BoxShadow(
																																color: Color(0x40000000),
																																blurRadius: 4,
																																offset: Offset(0, 4),
																															),
																														],
																													),
																													padding: const EdgeInsets.symmetric(vertical: 12),
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
																										),
																									),
																								]
																							),
																						),
																					),
																				]
																			),
																		),
																	),
																),
																Container(
																	width: 30,
																	height: 31,
																	child: Image.network(
																		"https://storage.googleapis.com/tagjs-prod.appspot.com/v1/eZXFHBRH4B/k5ea0s3a_expires_30_days.png",
																		fit: BoxFit.fill,
																	)
																),
															]
														),
													),
												),
												IntrinsicHeight(
													child: Container(
														margin: const EdgeInsets.only( bottom: 23, left: 38, right: 22),
														width: double.infinity,
														child: Row(
															children: [
																Expanded(
																	child: IntrinsicHeight(
																		child: Container(
																			decoration: BoxDecoration(
																				border: Border.all(
																					color: Color(0xFF989898),
																					width: 1,
																				),
																				borderRadius: BorderRadius.circular(14),
																				color: Color(0xFFFFFFFF),
																				boxShadow: [
																					BoxShadow(
																						color: Color(0x40000000),
																						blurRadius: 4,
																						offset: Offset(0, 4),
																					),
																				],
																			),
																			padding: const EdgeInsets.only( top: 13, bottom: 13, right: 12),
																			margin: const EdgeInsets.only( right: 15),
																			width: double.infinity,
																			child: Column(
																				crossAxisAlignment: CrossAxisAlignment.start,
																				children: [
																					Container(
																						margin: const EdgeInsets.only( left: 10),
																						child: Text(
																							"Fatima Ahmad",
																							style: TextStyle(
																								color: Color(0xFF000000),
																								fontSize: 18,
																								fontWeight: FontWeight.bold,
																							),
																						),
																					),
																					IntrinsicHeight(
																						child: Container(
																							margin: const EdgeInsets.only( left: 12),
																							width: double.infinity,
																							child: Row(
																								crossAxisAlignment: CrossAxisAlignment.start,
																								children: [
																									Expanded(
																										child: Container(
																											margin: const EdgeInsets.only( top: 25, right: 40),
																											width: double.infinity,
																											child: Text(
																												"fatima@Icloud.com",
																												style: TextStyle(
																													color: Color(0xFF000000),
																													fontSize: 15,
																													fontWeight: FontWeight.bold,
																												),
																												textAlign: TextAlign.center,
																											),
																										),
																									),
																									Expanded(
																										child: InkWell(
																											onTap: () { print('Pressed'); },
																											child: IntrinsicHeight(
																												child: Container(
																													decoration: BoxDecoration(
																														borderRadius: BorderRadius.circular(142),
																														color: Color(0xFFE47D0F),
																														boxShadow: [
																															BoxShadow(
																																color: Color(0x40000000),
																																blurRadius: 4,
																																offset: Offset(0, 4),
																															),
																														],
																													),
																													padding: const EdgeInsets.symmetric(vertical: 12),
																													width: double.infinity,
																													child: Column(
																														children: [
																															Text(
																																"Inactive",
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
																										),
																									),
																								]
																							),
																						),
																					),
																				]
																			),
																		),
																	),
																),
																Container(
																	width: 30,
																	height: 31,
																	child: Image.network(
																		"https://storage.googleapis.com/tagjs-prod.appspot.com/v1/eZXFHBRH4B/ct77hjnb_expires_30_days.png",
																		fit: BoxFit.fill,
																	)
																),
															]
														),
													),
												),
												IntrinsicHeight(
													child: Container(
														margin: const EdgeInsets.only( bottom: 166, left: 38, right: 22),
														width: double.infinity,
														child: Row(
															children: [
																Expanded(
																	child: IntrinsicHeight(
																		child: Container(
																			decoration: BoxDecoration(
																				border: Border.all(
																					color: Color(0xFF989898),
																					width: 1,
																				),
																				borderRadius: BorderRadius.circular(14),
																				color: Color(0xFFFFFFFF),
																				boxShadow: [
																					BoxShadow(
																						color: Color(0x40000000),
																						blurRadius: 4,
																						offset: Offset(0, 4),
																					),
																				],
																			),
																			padding: const EdgeInsets.only( top: 16, bottom: 16, left: 9, right: 9),
																			margin: const EdgeInsets.only( right: 15),
																			width: double.infinity,
																			child: Row(
																				children: [
																					Expanded(
																						child: IntrinsicHeight(
																							child: Container(
																								margin: const EdgeInsets.only( right: 38),
																								width: double.infinity,
																								child: Column(
																									crossAxisAlignment: CrossAxisAlignment.start,
																									children: [
																										Container(
																											margin: const EdgeInsets.only( bottom: 22),
																											child: Text(
																												"Layan Khalid",
																												style: TextStyle(
																													color: Color(0xFF000000),
																													fontSize: 18,
																													fontWeight: FontWeight.bold,
																												),
																											),
																										),
																										Container(
																											margin: const EdgeInsets.only( left: 2),
																											child: Text(
																												"layan@outlook.com",
																												style: TextStyle(
																													color: Color(0xFF000000),
																													fontSize: 15,
																													fontWeight: FontWeight.bold,
																												),
																											),
																										),
																									]
																								),
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
																										color: Color(0xFFD00000),
																										boxShadow: [
																											BoxShadow(
																												color: Color(0x40000000),
																												blurRadius: 4,
																												offset: Offset(0, 4),
																											),
																										],
																									),
																									padding: const EdgeInsets.only( top: 12, bottom: 12, left: 27, right: 27),
																									child: Column(
																										crossAxisAlignment: CrossAxisAlignment.start,
																										children: [
																											Text(
																												"Blocked",
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
																						),
																					),
																				]
																			),
																		),
																	),
																),
																Container(
																	width: 30,
																	height: 31,
																	child: Image.network(
																		"https://storage.googleapis.com/tagjs-prod.appspot.com/v1/eZXFHBRH4B/5blsw0qm_expires_30_days.png",
																		fit: BoxFit.fill,
																	)
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
																								"https://storage.googleapis.com/tagjs-prod.appspot.com/v1/eZXFHBRH4B/wkws44cz_expires_30_days.png",
																								fit: BoxFit.fill,
																							)
																						),
																						Text(
																							"Home",
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
																								"https://storage.googleapis.com/tagjs-prod.appspot.com/v1/eZXFHBRH4B/ffmi0jyg_expires_30_days.png",
																								fit: BoxFit.fill,
																							)
																						),
																						Text(
																							"Users",
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
																								"https://storage.googleapis.com/tagjs-prod.appspot.com/v1/eZXFHBRH4B/q3ew6in6_expires_30_days.png",
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
																								"https://storage.googleapis.com/tagjs-prod.appspot.com/v1/eZXFHBRH4B/b4xqxrfu_expires_30_days.png",
																								fit: BoxFit.fill,
																							)
																						),
																						Text(
																							"Profile",
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