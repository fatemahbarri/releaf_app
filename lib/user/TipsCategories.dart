import 'package:flutter/material.dart';
class TipsCategories extends StatefulWidget {
	const TipsCategories({super.key});
	@override
	TipsCategoriesState createState() => TipsCategoriesState();
}
class TipsCategoriesState extends State<TipsCategories> {
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
														margin: const EdgeInsets.only( bottom: 31, left: 8, right: 8),
														width: double.infinity,
														child: Row(
															children: [
																Container(
																	margin: const EdgeInsets.only( right: 35),
																	width: 47,
																	height: 41,
																	child: Image.network(
																		"https://storage.googleapis.com/tagjs-prod.appspot.com/v1/eZXFHBRH4B/6zs7xebx_expires_30_days.png",
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
																							"Cardboard",
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
														margin: const EdgeInsets.only( bottom: 38, left: 31, right: 31),
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
																				padding: const EdgeInsets.only( top: 39, left: 22, right: 22),
																				width: double.infinity,
																				child: Column(
																					crossAxisAlignment: CrossAxisAlignment.start,
																					children: [
																						Container(
																							margin: const EdgeInsets.only( bottom: 78),
																							width: double.infinity,
																							child: Text(
																								"1. Remove Food Residue Make sure boxes are clean and dry. Pizza boxes with grease or cheese cannot be recycled.\n\n2. Flatten Boxes Break down all cardboard boxes to save space in recycling bins.\n\n3. Remove Tape and Labels Peel off large pieces of tape, stickers, or plastic before recycling.\n\n4. Avoid Wet or Dirty Cardboard Wet, oily, or stained cardboard \nshould not be \nplaced in the \nrecycling bin.",
																								style: TextStyle(
																									color: Color(0xFF498057),
																									fontSize: 20,
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
																	bottom: 0,
																	right: 0,
																	width: 166,
																	height: 166,
																	child: Container(
																		transform: Matrix4.translationValues(2, 7, 0),
																		width: 166,
																		height: 166,
																		child: Image.network(
																			"https://storage.googleapis.com/tagjs-prod.appspot.com/v1/eZXFHBRH4B/agemz9g9_expires_30_days.png",
																			fit: BoxFit.fill,
																		)
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
																								"https://storage.googleapis.com/tagjs-prod.appspot.com/v1/eZXFHBRH4B/xsw8oe5h_expires_30_days.png",
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
																								"https://storage.googleapis.com/tagjs-prod.appspot.com/v1/eZXFHBRH4B/9csslt2d_expires_30_days.png",
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
																								"https://storage.googleapis.com/tagjs-prod.appspot.com/v1/eZXFHBRH4B/39436zst_expires_30_days.png",
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
																								"https://storage.googleapis.com/tagjs-prod.appspot.com/v1/eZXFHBRH4B/j2qj043b_expires_30_days.png",
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