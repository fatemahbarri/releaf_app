import 'package:flutter/material.dart';
class TipsPage extends StatefulWidget {
	const TipsPage({super.key});
	@override
	TipsPageState createState() => TipsPageState();
}
class TipsPageState extends State<TipsPage> {
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
												IntrinsicWidth(
													child: IntrinsicHeight(
														child: Container(
															margin: const EdgeInsets.only( bottom: 37, left: 8),
															child: Row(
																children: [
																	Container(
																		margin: const EdgeInsets.only( right: 37),
																		width: 47,
																		height: 41,
																		child: Image.network(
																			"https://storage.googleapis.com/tagjs-prod.appspot.com/v1/eZXFHBRH4B/ilwqoib5_expires_30_days.png",
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
																						color: Color(0xFF499A64),
																						boxShadow: [
																							BoxShadow(
																								color: Color(0x40000000),
																								blurRadius: 4,
																								offset: Offset(0, 4),
																							),
																						],
																					),
																					padding: const EdgeInsets.only( top: 10, bottom: 10, left: 35, right: 35),
																					child: Column(
																						crossAxisAlignment: CrossAxisAlignment.start,
																						children: [
																							Text(
																								"Common Tips",
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
														padding: const EdgeInsets.symmetric(vertical: 30),
														margin: const EdgeInsets.only( bottom: 21, left: 31, right: 31),
														width: double.infinity,
														child: Row(
															mainAxisAlignment: MainAxisAlignment.spaceBetween,
															children: [
																Container(
																	margin: const EdgeInsets.only( left: 27),
																	child: Text(
																		"Cardboard",
																		style: TextStyle(
																			color: Color(0xFF000000),
																			fontSize: 22,
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
																				padding: const EdgeInsets.only( top: 12, bottom: 12, left: 20, right: 20),
																				margin: const EdgeInsets.only( right: 10),
																				child: Column(
																					crossAxisAlignment: CrossAxisAlignment.start,
																					children: [
																						Text(
																							"Learn More",
																							style: TextStyle(
																								color: Color(0xFFFFFFFF),
																								fontSize: 15,
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
														padding: const EdgeInsets.symmetric(vertical: 29),
														margin: const EdgeInsets.only( bottom: 22, left: 31, right: 31),
														width: double.infinity,
														child: Row(
															mainAxisAlignment: MainAxisAlignment.spaceBetween,
															children: [
																Container(
																	margin: const EdgeInsets.only( left: 27),
																	child: Text(
																		"Glass",
																		style: TextStyle(
																			color: Color(0xFF000000),
																			fontSize: 22,
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
																				padding: const EdgeInsets.only( top: 12, bottom: 12, left: 20, right: 20),
																				margin: const EdgeInsets.only( right: 10),
																				child: Column(
																					crossAxisAlignment: CrossAxisAlignment.start,
																					children: [
																						Text(
																							"Learn More",
																							style: TextStyle(
																								color: Color(0xFFFFFFFF),
																								fontSize: 15,
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
														padding: const EdgeInsets.symmetric(vertical: 29),
														margin: const EdgeInsets.only( bottom: 22, left: 31, right: 31),
														width: double.infinity,
														child: Row(
															mainAxisAlignment: MainAxisAlignment.spaceBetween,
															children: [
																Container(
																	margin: const EdgeInsets.only( left: 27),
																	child: Text(
																		"Metal",
																		style: TextStyle(
																			color: Color(0xFF000000),
																			fontSize: 22,
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
																				padding: const EdgeInsets.only( top: 12, bottom: 12, left: 20, right: 20),
																				margin: const EdgeInsets.only( right: 10),
																				child: Column(
																					crossAxisAlignment: CrossAxisAlignment.start,
																					children: [
																						Text(
																							"Learn More",
																							style: TextStyle(
																								color: Color(0xFFFFFFFF),
																								fontSize: 15,
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
														padding: const EdgeInsets.symmetric(vertical: 29),
														margin: const EdgeInsets.only( bottom: 23, left: 31, right: 31),
														width: double.infinity,
														child: Row(
															mainAxisAlignment: MainAxisAlignment.spaceBetween,
															children: [
																Container(
																	margin: const EdgeInsets.only( left: 27),
																	child: Text(
																		"Paper",
																		style: TextStyle(
																			color: Color(0xFF000000),
																			fontSize: 22,
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
																				padding: const EdgeInsets.only( top: 12, bottom: 12, left: 20, right: 20),
																				margin: const EdgeInsets.only( right: 10),
																				child: Column(
																					crossAxisAlignment: CrossAxisAlignment.start,
																					children: [
																						Text(
																							"Learn More",
																							style: TextStyle(
																								color: Color(0xFFFFFFFF),
																								fontSize: 15,
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
														padding: const EdgeInsets.symmetric(vertical: 29),
														margin: const EdgeInsets.only( bottom: 21, left: 31, right: 31),
														width: double.infinity,
														child: Row(
															mainAxisAlignment: MainAxisAlignment.spaceBetween,
															children: [
																Container(
																	margin: const EdgeInsets.only( left: 27),
																	child: Text(
																		"Plastic",
																		style: TextStyle(
																			color: Color(0xFF000000),
																			fontSize: 22,
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
																				padding: const EdgeInsets.only( top: 12, bottom: 12, left: 20, right: 20),
																				margin: const EdgeInsets.only( right: 10),
																				child: Column(
																					crossAxisAlignment: CrossAxisAlignment.start,
																					children: [
																						Text(
																							"Learn More",
																							style: TextStyle(
																								color: Color(0xFFFFFFFF),
																								fontSize: 15,
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
														padding: const EdgeInsets.symmetric(vertical: 17),
														margin: const EdgeInsets.only( bottom: 38, left: 31, right: 31),
														width: double.infinity,
														child: Row(
															children: [
																Expanded(
																	child: Container(
																		margin: const EdgeInsets.only( left: 26, right: 14),
																		width: double.infinity,
																		child: Text(
																			"Trash\n(non-recyclables)",
																			style: TextStyle(
																				color: Color(0xFF000000),
																				fontSize: 22,
																				fontWeight: FontWeight.bold,
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
																					color: Color(0xFF7ACD0E),
																					boxShadow: [
																						BoxShadow(
																							color: Color(0x40000000),
																							blurRadius: 4,
																							offset: Offset(0, 4),
																						),
																					],
																				),
																				padding: const EdgeInsets.only( top: 12, bottom: 12, left: 20, right: 20),
																				margin: const EdgeInsets.only( right: 10),
																				child: Column(
																					crossAxisAlignment: CrossAxisAlignment.start,
																					children: [
																						Text(
																							"Learn More",
																							style: TextStyle(
																								color: Color(0xFFFFFFFF),
																								fontSize: 15,
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
																								"https://storage.googleapis.com/tagjs-prod.appspot.com/v1/eZXFHBRH4B/137h72mp_expires_30_days.png",
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
																								"https://storage.googleapis.com/tagjs-prod.appspot.com/v1/eZXFHBRH4B/8uoh0fc1_expires_30_days.png",
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
																								"https://storage.googleapis.com/tagjs-prod.appspot.com/v1/eZXFHBRH4B/uw1q9uug_expires_30_days.png",
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
																								"https://storage.googleapis.com/tagjs-prod.appspot.com/v1/eZXFHBRH4B/16aa9ky9_expires_30_days.png",
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