import 'package:flutter/material.dart';
class LearnMore extends StatefulWidget {
	const LearnMore({super.key});
	@override
	LearnMoreState createState() => LearnMoreState();
}
class LearnMoreState extends State<LearnMore> {
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
										child: Column(
											crossAxisAlignment: CrossAxisAlignment.start,
											children: [
												Container(
													padding: const EdgeInsets.only( top: 48),
													height: 852,
													width: double.infinity,
													child: Column(
														children: [
															IntrinsicHeight(
																child: Container(
																	margin: const EdgeInsets.only( bottom: 58, left: 8, right: 8),
																	width: double.infinity,
																	child: Row(
																		children: [
																			Container(
																				margin: const EdgeInsets.only( right: 36),
																				width: 47,
																				height: 41,
																				child: Image.network(
																					"https://storage.googleapis.com/tagjs-prod.appspot.com/v1/sRTqd7cMrP/si2fhp96_expires_30_days.png",
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
																							margin: const EdgeInsets.only( right: 36),
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
																	padding: const EdgeInsets.only( top: 34, bottom: 34, left: 18, right: 18),
																	margin: const EdgeInsets.only( bottom: 44, left: 31, right: 31),
																	width: double.infinity,
																	child: Column(
																		crossAxisAlignment: CrossAxisAlignment.start,
																		children: [
																			Container(
																				width: double.infinity,
																				child: Text(
																					"Always rinse plastic containers before recycling to remove any food or liquid. Check the recycling symbol on the item because not all types of plastic are accepted in every area. \nMake sure bottles are empty \nand caps are tightly secured. Avoid placing plastic bags or \nsoft plastics in regular recycling bins because they can get tangled in machines. Try to reduce \nsingle-use plastics whenever possible.",
																					style: TextStyle(
																						color: Color(0xFF1E1E1E),
																						fontSize: 20,
																						fontWeight: FontWeight.bold,
																					),
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
																			padding: const EdgeInsets.only( top: 16, bottom: 16, left: 40, right: 40),
																			margin: const EdgeInsets.only( bottom: 78),
																			child: Column(
																				crossAxisAlignment: CrossAxisAlignment.start,
																				children: [
																					Text(
																						" Chat Bot",
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
																											"https://storage.googleapis.com/tagjs-prod.appspot.com/v1/sRTqd7cMrP/e9epsjkv_expires_30_days.png",
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
																											"https://storage.googleapis.com/tagjs-prod.appspot.com/v1/sRTqd7cMrP/yunla7lp_expires_30_days.png",
																											fit: BoxFit.fill,
																										)
																									),
																									Text(
																										"Camera",
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
																											"https://storage.googleapis.com/tagjs-prod.appspot.com/v1/sRTqd7cMrP/di0qtiu5_expires_30_days.png",
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
																											"https://storage.googleapis.com/tagjs-prod.appspot.com/v1/sRTqd7cMrP/w7cch39g_expires_30_days.png",
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
														]
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