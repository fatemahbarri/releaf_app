import 'package:flutter/material.dart';
class AdminDeleteUser extends StatefulWidget {
	const AdminDeleteUser({super.key});
	@override
	AdminDeleteUserState createState() => AdminDeleteUserState();
}
class AdminDeleteUserState extends State<AdminDeleteUser> {
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
										padding: const EdgeInsets.only( top: 46),
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
																			"https://storage.googleapis.com/tagjs-prod.appspot.com/v1/eZXFHBRH4B/t4eg769y_expires_30_days.png",
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
													margin: const EdgeInsets.only( bottom: 32),
													height: 1,
													width: double.infinity,
													child: SizedBox(),
												),
												IntrinsicHeight(
													child: Container(
														margin: const EdgeInsets.only( bottom: 33, left: 30, right: 30),
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
																								"https://storage.googleapis.com/tagjs-prod.appspot.com/v1/eZXFHBRH4B/mzbtifwj_expires_30_days.png",
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
																		"https://storage.googleapis.com/tagjs-prod.appspot.com/v1/eZXFHBRH4B/oq4c4j24_expires_30_days.png",
																		fit: BoxFit.fill,
																	)
																),
															]
														),
													),
												),
												IntrinsicHeight(
													child: Container(
														padding: const EdgeInsets.only( top: 28),
														margin: const EdgeInsets.only( bottom: 47, left: 31, right: 31),
														width: double.infinity,
														child: Column(
															crossAxisAlignment: CrossAxisAlignment.start,
															children: [
																IntrinsicHeight(
																	child: Container(
																		margin: const EdgeInsets.only( bottom: 21),
																		width: double.infinity,
																		child: Column(
																			crossAxisAlignment: CrossAxisAlignment.end,
																			children: [
																				Container(
																					width: 30,
																					height: 31,
																					child: Image.network(
																						"https://storage.googleapis.com/tagjs-prod.appspot.com/v1/eZXFHBRH4B/14tj2avb_expires_30_days.png",
																						fit: BoxFit.fill,
																					)
																				),
																			]
																		),
																	),
																),
																IntrinsicHeight(
																	child: Container(
																		margin: const EdgeInsets.symmetric(horizontal: 10),
																		width: double.infinity,
																		child: Stack(
																			clipBehavior: Clip.none,
																			children: [
																				Column(
																					crossAxisAlignment: CrossAxisAlignment.start,
																					children: [
																						IntrinsicHeight(
																							child: Container(
																								width: double.infinity,
																								child: Stack(
																									clipBehavior: Clip.none,
																									children: [
																										Column(
																											crossAxisAlignment: CrossAxisAlignment.start,
																											children: [
																												IntrinsicHeight(
																													child: Container(
																														decoration: BoxDecoration(
																															border: Border.all(
																																color: Color(0xFF797878),
																																width: 1,
																															),
																															borderRadius: BorderRadius.circular(28),
																															color: Color(0xFFFFFFFF),
																															boxShadow: [
																																BoxShadow(
																																	color: Color(0x40000000),
																																	blurRadius: 4,
																																	offset: Offset(0, 4),
																																),
																															],
																														),
																														padding: const EdgeInsets.only( top: 24, left: 24),
																														width: double.infinity,
																														child: Column(
																															crossAxisAlignment: CrossAxisAlignment.start,
																															children: [
																																Container(
																																	margin: const EdgeInsets.only( bottom: 144),
																																	child: Text(
																																		"Delete ",
																																		style: TextStyle(
																																			color: Color(0xFF1D1B20),
																																			fontSize: 24,
																																		),
																																	),
																																),
																															]
																														),
																													),
																												),
																											]
																										),
																										Positioned(
																											top: 29,
																											left: 0,
																											child: IntrinsicWidth(
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
																														padding: const EdgeInsets.only( top: 13, bottom: 13, left: 9, right: 12),
																														transform: Matrix4.translationValues(-7, 0, 0),
																														child: Column(
																															crossAxisAlignment: CrossAxisAlignment.start,
																															children: [
																																Text(
																																	"Ahmad Ali",
																																	style: TextStyle(
																																		color: Color(0xFF000000),
																																		fontSize: 18,
																																		fontWeight: FontWeight.bold,
																																	),
																																),
																																IntrinsicWidth(
																																	child: IntrinsicHeight(
																																		child: Row(
																																			crossAxisAlignment: CrossAxisAlignment.start,
																																			children: [
																																				Container(
																																					margin: const EdgeInsets.only( top: 25, right: 40),
																																					child: Text(
																																						"Ahmad@gmail.com",
																																						style: TextStyle(
																																							color: Color(0xFF000000),
																																							fontSize: 15,
																																							fontWeight: FontWeight.bold,
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
																															]
																														),
																													),
																												),
																											),
																										),
																										Positioned(
																											top: 57,
																											right: 0,
																											width: 30,
																											height: 31,
																											child: Container(
																												transform: Matrix4.translationValues(14, 0, 0),
																												width: 30,
																												height: 31,
																												child: Image.network(
																													"https://storage.googleapis.com/tagjs-prod.appspot.com/v1/eZXFHBRH4B/95s4pmgg_expires_30_days.png",
																													fit: BoxFit.fill,
																												)
																											),
																										),
																										Positioned(
																											bottom: 0,
																											left: 0,
																											child: IntrinsicWidth(
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
																														padding: const EdgeInsets.only( top: 13, bottom: 13, left: 10, right: 12),
																														transform: Matrix4.translationValues(-7, 24, 0),
																														child: Column(
																															crossAxisAlignment: CrossAxisAlignment.start,
																															children: [
																																Text(
																																	"Fatima Ahmad",
																																	style: TextStyle(
																																		color: Color(0xFF000000),
																																		fontSize: 18,
																																		fontWeight: FontWeight.bold,
																																	),
																																),
																																IntrinsicWidth(
																																	child: IntrinsicHeight(
																																		child: Row(
																																			crossAxisAlignment: CrossAxisAlignment.start,
																																			children: [
																																				Container(
																																					margin: const EdgeInsets.only( top: 25, right: 40),
																																					child: Text(
																																						"fatima@Icloud.com",
																																						style: TextStyle(
																																							color: Color(0xFF000000),
																																							fontSize: 15,
																																							fontWeight: FontWeight.bold,
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
																																									color: Color(0xFFE47D0F),
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
																										),
																										Positioned(
																											bottom: 3,
																											right: 0,
																											width: 30,
																											height: 31,
																											child: Container(
																												transform: Matrix4.translationValues(14, 0, 0),
																												width: 30,
																												height: 31,
																												child: Image.network(
																													"https://storage.googleapis.com/tagjs-prod.appspot.com/v1/eZXFHBRH4B/gk2gfnu1_expires_30_days.png",
																													fit: BoxFit.fill,
																												)
																											),
																										),
																									]
																								),
																							),
																						),
																					]
																				),
																				Positioned(
																					top: 0,
																					left: 0,
																					child: InkWell(
																						onTap: () { print('Pressed'); },
																						child: IntrinsicWidth(
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
																									transform: Matrix4.translationValues(-10, -80, 0),
																									child: Column(
																										crossAxisAlignment: CrossAxisAlignment.start,
																										children: [
																											IntrinsicWidth(
																												child: IntrinsicHeight(
																													child: Row(
																														children: [
																															IntrinsicWidth(
																																child: IntrinsicHeight(
																																	child: Container(
																																		margin: const EdgeInsets.only( right: 52),
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
																															),
																															IntrinsicWidth(
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
																														]
																													),
																												),
																											),
																										]
																									),
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
												IntrinsicHeight(
													child: Container(
														margin: const EdgeInsets.only( bottom: 175, left: 34, right: 34),
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
																		"https://storage.googleapis.com/tagjs-prod.appspot.com/v1/eZXFHBRH4B/e0p4zs02_expires_30_days.png",
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
																								"https://storage.googleapis.com/tagjs-prod.appspot.com/v1/eZXFHBRH4B/lmf6j7kb_expires_30_days.png",
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
																								"https://storage.googleapis.com/tagjs-prod.appspot.com/v1/eZXFHBRH4B/aya9qi6c_expires_30_days.png",
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
																								"https://storage.googleapis.com/tagjs-prod.appspot.com/v1/eZXFHBRH4B/2tvkmi61_expires_30_days.png",
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
																								"https://storage.googleapis.com/tagjs-prod.appspot.com/v1/eZXFHBRH4B/syft7bvm_expires_30_days.png",
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