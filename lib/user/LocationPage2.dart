import 'package:flutter/material.dart';
class LocationPage2 extends StatefulWidget {
	const LocationPage2({super.key});
	@override
	LocationPage2State createState() => LocationPage2State();
}
class LocationPage2State extends State<LocationPage2> {
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
										padding: const EdgeInsets.only( top: 50),
										child: Column(
											crossAxisAlignment: CrossAxisAlignment.start,
											children: [
												IntrinsicHeight(
													child: Container(
														margin: const EdgeInsets.only( bottom: 14, left: 8, right: 8),
														width: double.infinity,
														child: Row(
															children: [
																Container(
																	margin: const EdgeInsets.only( right: 35),
																	width: 47,
																	height: 41,
																	child: Image.network(
																		"https://storage.googleapis.com/tagjs-prod.appspot.com/v1/sRTqd7cMrP/vnp05wii_expires_30_days.png",
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
																								"https://storage.googleapis.com/tagjs-prod.appspot.com/v1/sRTqd7cMrP/scq6yrrd_expires_30_days.png",
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
																		"https://storage.googleapis.com/tagjs-prod.appspot.com/v1/sRTqd7cMrP/v9muj9jj_expires_30_days.png",
																		fit: BoxFit.fill,
																	)
																),
															]
														),
													),
												),
												IntrinsicHeight(
													child: Container(
														padding: const EdgeInsets.only( top: 205, left: 28),
														margin: const EdgeInsets.only( bottom: 9, left: 13, right: 13),
														width: double.infinity,
														decoration: BoxDecoration(
															image: DecorationImage(
																image: NetworkImage("https://storage.googleapis.com/tagjs-prod.appspot.com/v1/sRTqd7cMrP/av8ew5ue_expires_30_days.png"),
																fit: BoxFit.fill
															),
														),
														child: Column(
															crossAxisAlignment: CrossAxisAlignment.start,
															children: [
																Container(
																	margin: const EdgeInsets.only( bottom: 2),
																	child: Text(
																		"Paper",
																		style: TextStyle(
																			color: Color(0xFFFFFFFF),
																			fontSize: 20,
																			fontWeight: FontWeight.bold,
																		),
																	),
																),
															]
														),
													),
												),
												IntrinsicHeight(
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
														padding: const EdgeInsets.only( top: 20, bottom: 20, left: 16, right: 16),
														margin: const EdgeInsets.only( bottom: 14, left: 22, right: 22),
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
																						margin: const EdgeInsets.only( bottom: 11),
																						child: Text(
																							"Khobar Recycling Center",
																							style: TextStyle(
																								color: Color(0xFF000000),
																								fontSize: 20,
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
																				padding: const EdgeInsets.only( top: 10, bottom: 10, left: 26, right: 26),
																				child: Column(
																					crossAxisAlignment: CrossAxisAlignment.start,
																					children: [
																						Text(
																							"Go",
																							style: TextStyle(
																								color: Color(0xFF5B5656),
																								fontSize: 18,
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
														padding: const EdgeInsets.only( top: 20, bottom: 20, left: 17, right: 17),
														margin: const EdgeInsets.only( bottom: 14, left: 22, right: 22),
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
																					margin: const EdgeInsets.only( bottom: 13),
																					child: Text(
																						"Eastern Eco Drop-Off",
																						style: TextStyle(
																							color: Color(0xFF000000),
																							fontSize: 20,
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
																				padding: const EdgeInsets.only( top: 10, bottom: 10, left: 26, right: 26),
																				child: Column(
																					crossAxisAlignment: CrossAxisAlignment.start,
																					children: [
																						Text(
																							"Go",
																							style: TextStyle(
																								color: Color(0xFF5B5656),
																								fontSize: 18,
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
														padding: const EdgeInsets.only( top: 20, bottom: 20, left: 16, right: 16),
														margin: const EdgeInsets.only( bottom: 14, left: 22, right: 22),
														width: double.infinity,
														child: Row(
															children: [
																Expanded(
																	child: IntrinsicHeight(
																		child: Container(
																			margin: const EdgeInsets.only( right: 44),
																			width: double.infinity,
																			child: Column(
																				crossAxisAlignment: CrossAxisAlignment.start,
																				children: [
																					Container(
																						margin: const EdgeInsets.only( bottom: 11),
																						child: Text(
																							"Corniche Waste Sorting",
																							style: TextStyle(
																								color: Color(0xFF000000),
																								fontSize: 20,
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
																				padding: const EdgeInsets.only( top: 10, bottom: 10, left: 26, right: 26),
																				child: Column(
																					crossAxisAlignment: CrossAxisAlignment.start,
																					children: [
																						Text(
																							"Go",
																							style: TextStyle(
																								color: Color(0xFF5B5656),
																								fontSize: 18,
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
														padding: const EdgeInsets.only( top: 20, bottom: 20, left: 16, right: 16),
														margin: const EdgeInsets.only( bottom: 11, left: 22, right: 22),
														width: double.infinity,
														child: Row(
															children: [
																Expanded(
																	child: IntrinsicHeight(
																		child: Container(
																			margin: const EdgeInsets.only( right: 36),
																			width: double.infinity,
																			child: Column(
																				crossAxisAlignment: CrossAxisAlignment.start,
																				children: [
																					Container(
																						margin: const EdgeInsets.only( bottom: 11),
																						child: Text(
																							"Bayfront Recycle Center",
																							style: TextStyle(
																								color: Color(0xFF000000),
																								fontSize: 20,
																								fontWeight: FontWeight.bold,
																							),
																						),
																					),
																					Text(
																						"Seaside Road, Al Khobar Corniche Extension",
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
																				padding: const EdgeInsets.only( top: 10, bottom: 10, left: 26, right: 26),
																				child: Column(
																					crossAxisAlignment: CrossAxisAlignment.start,
																					children: [
																						Text(
																							"Go",
																							style: TextStyle(
																								color: Color(0xFF5B5656),
																								fontSize: 18,
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
																								"https://storage.googleapis.com/tagjs-prod.appspot.com/v1/sRTqd7cMrP/3rcywlgs_expires_30_days.png",
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
																								"https://storage.googleapis.com/tagjs-prod.appspot.com/v1/sRTqd7cMrP/66g05rxh_expires_30_days.png",
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
																								"https://storage.googleapis.com/tagjs-prod.appspot.com/v1/sRTqd7cMrP/jualo717_expires_30_days.png",
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
																								"https://storage.googleapis.com/tagjs-prod.appspot.com/v1/sRTqd7cMrP/2b4zbuhk_expires_30_days.png",
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