import 'package:flutter/material.dart';
class AdminBinManagment3 extends StatefulWidget {
	const AdminBinManagment3({super.key});
	@override
	AdminBinManagment3State createState() => AdminBinManagment3State();
}
class AdminBinManagment3State extends State<AdminBinManagment3> {
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
											padding: const EdgeInsets.only( top: 66),
											child: Column(
												crossAxisAlignment: CrossAxisAlignment.start,
												children: [
													IntrinsicHeight(
														child: Container(
															margin: const EdgeInsets.only( bottom: 14, left: 11, right: 11),
															width: double.infinity,
															child: Row(
																children: [
																	Container(
																		margin: const EdgeInsets.only( right: 35),
																		width: 47,
																		height: 41,
																		child: Image.network(
																			"https://storage.googleapis.com/tagjs-prod.appspot.com/v1/eZXFHBRH4B/74z1gbmw_expires_30_days.png",
																			fit: BoxFit.fill,
																		)
																	),
																	Expanded(
																		child: InkWell(
																			onTap: () { print('Pressed'); },
																			child: IntrinsicHeight(
																				child: Container(
																					decoration: BoxDecoration(
																						borderRadius: BorderRadius.circular(27),
																						color: Color(0x667CA385),
																						boxShadow: [
																							BoxShadow(
																								color: Color(0x40000000),
																								blurRadius: 4,
																								offset: Offset(0, 4),
																							),
																						],
																					),
																					padding: const EdgeInsets.symmetric(vertical: 12),
																					margin: const EdgeInsets.only( right: 35),
																					width: double.infinity,
																					child: Column(
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
																	SizedBox(
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
															margin: const EdgeInsets.only( bottom: 6, left: 33, right: 33),
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
																									"https://storage.googleapis.com/tagjs-prod.appspot.com/v1/eZXFHBRH4B/xbamnd3u_expires_30_days.png",
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
																			"https://storage.googleapis.com/tagjs-prod.appspot.com/v1/eZXFHBRH4B/1y2hwipo_expires_30_days.png",
																			fit: BoxFit.fill,
																		)
																	),
																]
															),
														),
													),
													Container(
														margin: const EdgeInsets.only( bottom: 11, left: 33),
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
															margin: const EdgeInsets.only( bottom: 14, left: 19, right: 19),
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
																														"https://storage.googleapis.com/tagjs-prod.appspot.com/v1/eZXFHBRH4B/4jcos0wg_expires_30_days.png",
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
																			"https://storage.googleapis.com/tagjs-prod.appspot.com/v1/eZXFHBRH4B/6wfmla2j_expires_30_days.png",
																			fit: BoxFit.fill,
																		)
																	),
																]
															),
														),
													),
													IntrinsicHeight(
														child: Container(
															padding: const EdgeInsets.only( top: 4),
															margin: const EdgeInsets.only( bottom: 91, left: 19, right: 19),
															width: double.infinity,
															child: Column(
																crossAxisAlignment: CrossAxisAlignment.start,
																children: [
																	IntrinsicHeight(
																		child: Container(
																			margin: const EdgeInsets.only( bottom: 23, left: 22, right: 22),
																			width: double.infinity,
																			child: Stack(
																				clipBehavior: Clip.none,
																				children: [
																					Column(
																						crossAxisAlignment: CrossAxisAlignment.start,
																						children: [
																							IntrinsicHeight(
																								child: SizedBox(
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
																															padding: const EdgeInsets.only( top: 24, left: 24, right: 42),
																															width: double.infinity,
																															child: Column(
																																crossAxisAlignment: CrossAxisAlignment.start,
																																children: [
																																	IntrinsicHeight(
																																		child: Container(
																																			margin: const EdgeInsets.only( bottom: 12),
																																			width: double.infinity,
																																			child: Row(
																																				mainAxisAlignment: MainAxisAlignment.spaceBetween,
																																				children: [
																																					Text(
																																						"Delete ",
																																						style: TextStyle(
																																							color: Color(0xFF1D1B20),
																																							fontSize: 24,
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
																																													"https://storage.googleapis.com/tagjs-prod.appspot.com/v1/eZXFHBRH4B/5rqizd3b_expires_30_days.png",
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
																																	Container(
																																		margin: const EdgeInsets.only( bottom: 88),
																																		width: double.infinity,
																																		child: Text(
																																			"Are you sure you want to permanently delete the Khobar Recycling Center?",
																																			style: TextStyle(
																																				color: Color(0xFF49454F),
																																				fontSize: 14,
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
																												top: 28,
																												right: 0,
																												width: 30,
																												height: 31,
																												child: Container(
																													transform: Matrix4.translationValues(16, 0, 0),
																													width: 30,
																													height: 31,
																													child: Image.network(
																														"https://storage.googleapis.com/tagjs-prod.appspot.com/v1/eZXFHBRH4B/89thbz0v_expires_30_days.png",
																														fit: BoxFit.fill,
																													)
																												),
																											),
																											Positioned(
																												bottom: 23,
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
																																padding: const EdgeInsets.only( top: 21, bottom: 21, left: 14, right: 14),
																																transform: Matrix4.translationValues(-22, 0, 0),
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
																																									margin: const EdgeInsets.only( right: 34),
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
																																						IntrinsicWidth(
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
																																													"https://storage.googleapis.com/tagjs-prod.appspot.com/v1/eZXFHBRH4B/gwt8c2kl_expires_30_days.png",
																																													fit: BoxFit.fill,
																																												)
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
																											Positioned(
																												bottom: 36,
																												right: 0,
																												width: 30,
																												height: 31,
																												child: Container(
																													transform: Matrix4.translationValues(16, 0, 0),
																													width: 30,
																													height: 31,
																													child: Image.network(
																														"https://storage.googleapis.com/tagjs-prod.appspot.com/v1/eZXFHBRH4B/rldb4fyf_expires_30_days.png",
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
																															padding: const EdgeInsets.only( top: 20, left: 14, right: 14),
																															transform: Matrix4.translationValues(-22, 74, 0),
																															child: Column(
																																crossAxisAlignment: CrossAxisAlignment.start,
																																children: [
																																	IntrinsicWidth(
																																		child: IntrinsicHeight(
																																			child: Container(
																																				margin: const EdgeInsets.only( bottom: 9),
																																				child: Row(
																																					crossAxisAlignment: CrossAxisAlignment.start,
																																					children: [
																																						IntrinsicWidth(
																																							child: IntrinsicHeight(
																																								child: Container(
																																									padding: const EdgeInsets.only( right: 1),
																																									margin: const EdgeInsets.only( right: 25),
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
																																														"https://storage.googleapis.com/tagjs-prod.appspot.com/v1/eZXFHBRH4B/xolwe5em_expires_30_days.png",
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
																					Positioned(
																						top: 0,
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
																									padding: const EdgeInsets.only( top: 21, bottom: 21, left: 15, right: 119),
																									transform: Matrix4.translationValues(-22, -4, 0),
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
																											Text(
																												" King Fahd Street, Al Thuqbah District",
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
																					),
																				]
																			),
																		),
																	),
																	IntrinsicHeight(
																		child: SizedBox(
																			width: double.infinity,
																			child: Column(
																				crossAxisAlignment: CrossAxisAlignment.end,
																				children: [
																					SizedBox(
																						width: 30,
																						height: 31,
																						child: Image.network(
																							"https://storage.googleapis.com/tagjs-prod.appspot.com/v1/eZXFHBRH4B/1sb1ws9k_expires_30_days.png",
																							fit: BoxFit.fill,
																						)
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
															margin: const EdgeInsets.only( bottom: 92),
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
																					padding: const EdgeInsets.only( top: 16, bottom: 16, left: 42, right: 42),
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
																								"https://storage.googleapis.com/tagjs-prod.appspot.com/v1/eZXFHBRH4B/w2gg6jjg_expires_30_days.png",
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
																								"https://storage.googleapis.com/tagjs-prod.appspot.com/v1/eZXFHBRH4B/jy3aeskb_expires_30_days.png",
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
																								"https://storage.googleapis.com/tagjs-prod.appspot.com/v1/eZXFHBRH4B/7uq1xer6_expires_30_days.png",
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