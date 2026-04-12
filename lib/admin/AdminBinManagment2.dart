import 'package:flutter/material.dart';
class AdminBinManagment2 extends StatefulWidget {
	const AdminBinManagment2({super.key});
	@override
	AdminBinManagment2State createState() => AdminBinManagment2State();
}
class AdminBinManagment2State extends State<AdminBinManagment2> {
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
											padding: const EdgeInsets.only( top: 70),
											child: Column(
												crossAxisAlignment: CrossAxisAlignment.start,
												children: [
													IntrinsicWidth(
														child: IntrinsicHeight(
															child: Container(
																margin: const EdgeInsets.only( bottom: 14, left: 23),
																child: Row(
																	children: [
																		Container(
																			margin: const EdgeInsets.only( right: 35),
																			width: 47,
																			height: 41,
																			child: Image.network(
																				"https://storage.googleapis.com/tagjs-prod.appspot.com/v1/eZXFHBRH4B/qohdh7f7_expires_30_days.png",
																				fit: BoxFit.fill,
																			)
																		),
																		InkWell(
																			onTap: () { print('Pressed'); },
																			child: IntrinsicWidth(
																				child: IntrinsicHeight(
																					child: Container(
																						decoration: BoxDecoration(
																							borderRadius: BorderRadius.circular(27),
																							color: Color(0x667BA285),
																							boxShadow: [
																								BoxShadow(
																									color: Color(0x40000000),
																									blurRadius: 4,
																									offset: Offset(0, 4),
																								),
																							],
																						),
																						padding: const EdgeInsets.only( top: 12, bottom: 12, left: 68, right: 68),
																						child: Column(
																							crossAxisAlignment: CrossAxisAlignment.start,
																							children: [
																								Text(
																									"Plastic",
																									style: TextStyle(
																										color: Color(0xFFFFFFFF),
																										fontSize: 28,
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
													IntrinsicHeight(
														child: Container(
															margin: const EdgeInsets.only( bottom: 6, left: 45, right: 23),
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
																									"https://storage.googleapis.com/tagjs-prod.appspot.com/v1/eZXFHBRH4B/tjjkkcb7_expires_30_days.png",
																									fit: BoxFit.fill,
																								)
																							)
																						),
																					]
																				),
																			),
																		),
																	),
																	SizedBox(
																		width: 24,
																		height: 24,
																		child: Image.network(
																			"https://storage.googleapis.com/tagjs-prod.appspot.com/v1/eZXFHBRH4B/4kscjzx8_expires_30_days.png",
																			fit: BoxFit.fill,
																		)
																	),
																]
															),
														),
													),
													Container(
														margin: const EdgeInsets.only( bottom: 11, left: 45),
														child: Text(
															"Paper",
															style: TextStyle(
																color: Color(0xFFFFFFFF),
																fontSize: 20,
																fontWeight: FontWeight.bold,
															),
														),
													),
													IntrinsicHeight(
														child: Container(
															margin: const EdgeInsets.only( bottom: 14, left: 31, right: 11),
															width: double.infinity,
															child: Row(
																crossAxisAlignment: CrossAxisAlignment.start,
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
																				padding: const EdgeInsets.only( top: 20, bottom: 20, left: 14, right: 14),
																				margin: const EdgeInsets.only( right: 19),
																				width: double.infinity,
																				child: Row(
																					children: [
																						Expanded(
																							child: IntrinsicHeight(
																								child: Container(
																									margin: const EdgeInsets.only( right: 22),
																									width: double.infinity,
																									child: Column(
																										crossAxisAlignment: CrossAxisAlignment.start,
																										children: [
																											Container(
																												margin: const EdgeInsets.only( bottom: 13),
																												child: Text(
																													"Khobar Recycling Center",
																													style: TextStyle(
																														color: Color(0xFF000000),
																														fontSize: 18,
																														fontWeight: FontWeight.bold,
																													),
																												),
																											),
																											Text(
																												"Prince Faisal Bin Fahd Road, Al Khobar",
																												style: TextStyle(
																													color: Color(0xFF000000),
																													fontSize: 11,
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
																										padding: const EdgeInsets.only( top: 4, bottom: 4, left: 21, right: 21),
																										child: Column(
																											crossAxisAlignment: CrossAxisAlignment.start,
																											children: [
																												SizedBox(
																													width: 25,
																													height: 25,
																													child: Image.network(
																														"https://storage.googleapis.com/tagjs-prod.appspot.com/v1/eZXFHBRH4B/p142bblp_expires_30_days.png",
																														fit: BoxFit.fill,
																													)
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
																		margin: const EdgeInsets.only( top: 32),
																		width: 30,
																		height: 31,
																		child: Image.network(
																			"https://storage.googleapis.com/tagjs-prod.appspot.com/v1/eZXFHBRH4B/xyh9hjih_expires_30_days.png",
																			fit: BoxFit.fill,
																		)
																	),
																]
															),
														),
													),
													IntrinsicHeight(
														child: Container(
															margin: const EdgeInsets.only( bottom: 14, left: 31, right: 12),
															width: double.infinity,
															child: Row(
																crossAxisAlignment: CrossAxisAlignment.start,
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
																				padding: const EdgeInsets.only( left: 15, right: 15),
																				margin: const EdgeInsets.only( right: 18),
																				width: double.infinity,
																				child: Row(
																					crossAxisAlignment: CrossAxisAlignment.start,
																					children: [
																						Expanded(
																							child: IntrinsicHeight(
																								child: Container(
																									margin: const EdgeInsets.only( top: 20, bottom: 20, right: 31),
																									width: double.infinity,
																									child: Column(
																										crossAxisAlignment: CrossAxisAlignment.start,
																										children: [
																											Container(
																												margin: const EdgeInsets.only( bottom: 14),
																												child: Text(
																													"Eastern Eco Drop-Off",
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
																													" King Fahd Street, Al Thuqbah District",
																													style: TextStyle(
																														color: Color(0xFF000000),
																														fontSize: 11,
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
																											color: Color(0xFF8DC149),
																											boxShadow: [
																												BoxShadow(
																													color: Color(0x40000000),
																													blurRadius: 4,
																													offset: Offset(0, 4),
																												),
																											],
																										),
																										padding: const EdgeInsets.only( top: 3, bottom: 3, left: 20, right: 20),
																										margin: const EdgeInsets.only( top: 31),
																										child: Column(
																											crossAxisAlignment: CrossAxisAlignment.start,
																											children: [
																												SizedBox(
																													width: 25,
																													height: 25,
																													child: Image.network(
																														"https://storage.googleapis.com/tagjs-prod.appspot.com/v1/eZXFHBRH4B/7tvjs5p0_expires_30_days.png",
																														fit: BoxFit.fill,
																													)
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
																		margin: const EdgeInsets.only( top: 32),
																		width: 30,
																		height: 31,
																		child: Image.network(
																			"https://storage.googleapis.com/tagjs-prod.appspot.com/v1/eZXFHBRH4B/088tnsqi_expires_30_days.png",
																			fit: BoxFit.fill,
																		)
																	),
																]
															),
														),
													),
													IntrinsicHeight(
														child: Container(
															margin: const EdgeInsets.only( bottom: 14, left: 31, right: 12),
															width: double.infinity,
															child: Row(
																crossAxisAlignment: CrossAxisAlignment.start,
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
																				padding: const EdgeInsets.only( top: 20, bottom: 20, left: 14, right: 14),
																				margin: const EdgeInsets.only( right: 18),
																				width: double.infinity,
																				child: Row(
																					children: [
																						Expanded(
																							child: IntrinsicHeight(
																								child: Container(
																									margin: const EdgeInsets.only( right: 34),
																									width: double.infinity,
																									child: Column(
																										crossAxisAlignment: CrossAxisAlignment.start,
																										children: [
																											Container(
																												margin: const EdgeInsets.only( bottom: 13),
																												child: Text(
																													"Corniche Waste Sorting",
																													style: TextStyle(
																														color: Color(0xFF000000),
																														fontSize: 18,
																														fontWeight: FontWeight.bold,
																													),
																												),
																											),
																											Text(
																												"Khobar Corniche Road, Al Bahar Area",
																												style: TextStyle(
																													color: Color(0xFF000000),
																													fontSize: 11,
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
																										padding: const EdgeInsets.only( top: 3, bottom: 3, left: 20, right: 20),
																										child: Column(
																											crossAxisAlignment: CrossAxisAlignment.start,
																											children: [
																												SizedBox(
																													width: 25,
																													height: 25,
																													child: Image.network(
																														"https://storage.googleapis.com/tagjs-prod.appspot.com/v1/eZXFHBRH4B/qph8gibh_expires_30_days.png",
																														fit: BoxFit.fill,
																													)
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
																		margin: const EdgeInsets.only( top: 39),
																		width: 30,
																		height: 31,
																		child: Image.network(
																			"https://storage.googleapis.com/tagjs-prod.appspot.com/v1/eZXFHBRH4B/i9n01c16_expires_30_days.png",
																			fit: BoxFit.fill,
																		)
																	),
																]
															),
														),
													),
													IntrinsicHeight(
														child: Container(
															margin: const EdgeInsets.only( bottom: 71, left: 31, right: 12),
															width: double.infinity,
															child: Row(
																crossAxisAlignment: CrossAxisAlignment.start,
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
																				padding: const EdgeInsets.only( top: 20, bottom: 9, left: 14, right: 14),
																				margin: const EdgeInsets.only( right: 18),
																				width: double.infinity,
																				child: Row(
																					crossAxisAlignment: CrossAxisAlignment.start,
																					children: [
																						Expanded(
																							child: IntrinsicHeight(
																								child: Container(
																									margin: const EdgeInsets.only( right: 25),
																									width: double.infinity,
																									child: Column(
																										crossAxisAlignment: CrossAxisAlignment.start,
																										children: [
																											Container(
																												margin: const EdgeInsets.only( bottom: 13, left: 1),
																												child: Text(
																													"Bayfront Recycle Center",
																													style: TextStyle(
																														color: Color(0xFF000000),
																														fontSize: 18,
																														fontWeight: FontWeight.bold,
																													),
																												),
																											),
																											SizedBox(
																												width: 166,
																												child: Text(
																													"Seaside Road, Al Khobar Corniche Extension",
																													style: TextStyle(
																														color: Color(0xFF000000),
																														fontSize: 11,
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
																											color: Color(0xFF8DC149),
																											boxShadow: [
																												BoxShadow(
																													color: Color(0x40000000),
																													blurRadius: 4,
																													offset: Offset(0, 4),
																												),
																											],
																										),
																										padding: const EdgeInsets.only( top: 3, bottom: 3, left: 20, right: 20),
																										child: Column(
																											crossAxisAlignment: CrossAxisAlignment.start,
																											children: [
																												SizedBox(
																													width: 25,
																													height: 25,
																													child: Image.network(
																														"https://storage.googleapis.com/tagjs-prod.appspot.com/v1/eZXFHBRH4B/f1d8dlt2_expires_30_days.png",
																														fit: BoxFit.fill,
																													)
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
																		margin: const EdgeInsets.only( top: 32),
																		width: 30,
																		height: 31,
																		child: Image.network(
																			"https://storage.googleapis.com/tagjs-prod.appspot.com/v1/eZXFHBRH4B/ths68r7n_expires_30_days.png",
																			fit: BoxFit.fill,
																		)
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
																	padding: const EdgeInsets.only( top: 16, bottom: 16, left: 42, right: 42),
																	margin: const EdgeInsets.only( bottom: 88, left: 138),
																	child: Column(
																		crossAxisAlignment: CrossAxisAlignment.start,
																		children: [
																			Text(
																				"Add Bin",
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
																								"https://storage.googleapis.com/tagjs-prod.appspot.com/v1/eZXFHBRH4B/qy6a3sba_expires_30_days.png",
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
																								"https://storage.googleapis.com/tagjs-prod.appspot.com/v1/eZXFHBRH4B/p2rh9fx3_expires_30_days.png",
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
																								"https://storage.googleapis.com/tagjs-prod.appspot.com/v1/eZXFHBRH4B/ff3beuy5_expires_30_days.png",
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