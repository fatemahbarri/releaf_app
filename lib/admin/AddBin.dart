import 'package:flutter/material.dart';
class AddBin extends StatefulWidget {
	const AddBin({super.key});
	@override
	AddBinState createState() => AddBinState();
}
class AddBinState extends State<AddBin> {
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
											padding: const EdgeInsets.only( top: 42),
											child: Column(
												crossAxisAlignment: CrossAxisAlignment.start,
												children: [
													IntrinsicHeight(
														child: Container(
															margin: const EdgeInsets.only( bottom: 65, left: 8, right: 29),
															width: double.infinity,
															child: Row(
																children: [
																	Container(
																		margin: const EdgeInsets.only( right: 26),
																		width: 47,
																		height: 41,
																		child: Image.network(
																			"https://storage.googleapis.com/tagjs-prod.appspot.com/v1/eZXFHBRH4B/8isibtnh_expires_30_days.png",
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
																						color: Color(0x667BA285),
																						boxShadow: [
																							BoxShadow(
																								color: Color(0x40000000),
																								blurRadius: 4,
																								offset: Offset(0, 4),
																							),
																						],
																					),
																					padding: const EdgeInsets.symmetric(vertical: 12),
																					margin: const EdgeInsets.symmetric(vertical: 27),
																					width: double.infinity,
																					child: Column(
																						children: [
																							Text(
																								"Add Bin",
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
															padding: const EdgeInsets.only( top: 11, bottom: 11, left: 22),
															margin: const EdgeInsets.only( bottom: 14, left: 47, right: 47),
															width: double.infinity,
															child: Column(
																crossAxisAlignment: CrossAxisAlignment.start,
																children: [
																	Text(
																		"Bin Name",
																		style: TextStyle(
																			color: Color(0xFF000000),
																			fontSize: 20,
																			fontWeight: FontWeight.bold,
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
															padding: const EdgeInsets.only( top: 11, bottom: 11, left: 22),
															margin: const EdgeInsets.only( bottom: 11, left: 47, right: 47),
															width: double.infinity,
															child: Column(
																crossAxisAlignment: CrossAxisAlignment.start,
																children: [
																	Text(
																		"City",
																		style: TextStyle(
																			color: Color(0xFF000000),
																			fontSize: 20,
																			fontWeight: FontWeight.bold,
																		),
																	),
																]
															),
														),
													),
													IntrinsicHeight(
														child: Container(
															margin: const EdgeInsets.only( bottom: 14, left: 46, right: 46),
															width: double.infinity,
															child: Column(
																crossAxisAlignment: CrossAxisAlignment.start,
																children: [
																	Text(
																		"Paper",
																		style: TextStyle(
																			color: Color(0xFFFFFFFF),
																			fontSize: 20,
																			fontWeight: FontWeight.bold,
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
																			padding: const EdgeInsets.only( top: 11, bottom: 11, left: 22),
																			width: double.infinity,
																			child: Column(
																				crossAxisAlignment: CrossAxisAlignment.start,
																				children: [
																					Text(
																						"Area",
																						style: TextStyle(
																							color: Color(0xFF000000),
																							fontSize: 20,
																							fontWeight: FontWeight.bold,
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
															padding: const EdgeInsets.only( top: 11, bottom: 11, left: 22),
															margin: const EdgeInsets.only( bottom: 12, left: 47, right: 47),
															width: double.infinity,
															decoration: BoxDecoration(
																image: DecorationImage(
																	image: NetworkImage("https://storage.googleapis.com/tagjs-prod.appspot.com/v1/eZXFHBRH4B/pr5mfat6_expires_30_days.png"),
																	fit: BoxFit.fill
																),
															),
															child: Column(
																crossAxisAlignment: CrossAxisAlignment.start,
																children: [
																	Text(
																		"Bin type",
																		style: TextStyle(
																			color: Color(0xFF000000),
																			fontSize: 20,
																			fontWeight: FontWeight.bold,
																		),
																	),
																]
															),
														),
													),
													IntrinsicWidth(
														child: IntrinsicHeight(
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
																padding: const EdgeInsets.only( top: 12, bottom: 12, left: 22, right: 22),
																margin: const EdgeInsets.only( bottom: 16, left: 49),
																child: Row(
																	children: [
																		Container(
																			margin: const EdgeInsets.only( right: 116),
																			child: Text(
																				"Select Address",
																				style: TextStyle(
																					color: Color(0xFF000000),
																					fontSize: 20,
																					fontWeight: FontWeight.bold,
																				),
																			),
																		),
																		SizedBox(
																			width: 25,
																			height: 25,
																			child: Image.network(
																				"https://storage.googleapis.com/tagjs-prod.appspot.com/v1/eZXFHBRH4B/v7cyi843_expires_30_days.png",
																				fit: BoxFit.fill,
																			)
																		),
																	]
																),
															),
														),
													),
													IntrinsicHeight(
														child: Container(
															margin: const EdgeInsets.only( bottom: 34),
															width: double.infinity,
															child: Column(
																children: [
																	SizedBox(
																		width: 247,
																		height: 167,
																		child: Image.network(
																			"https://storage.googleapis.com/tagjs-prod.appspot.com/v1/eZXFHBRH4B/be32aurn_expires_30_days.png",
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
																								"https://storage.googleapis.com/tagjs-prod.appspot.com/v1/eZXFHBRH4B/e9gjqfaw_expires_30_days.png",
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
																								"https://storage.googleapis.com/tagjs-prod.appspot.com/v1/eZXFHBRH4B/wm44cgdm_expires_30_days.png",
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
																								"https://storage.googleapis.com/tagjs-prod.appspot.com/v1/eZXFHBRH4B/emjzd9ki_expires_30_days.png",
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