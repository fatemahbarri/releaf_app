import 'package:flutter/material.dart';
class ResultPage extends StatefulWidget {
	const ResultPage({super.key});
	@override
	ResultPageState createState() => ResultPageState();
}
class ResultPageState extends State<ResultPage> {
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
																	margin: const EdgeInsets.only( bottom: 78, left: 8, right: 8),
																	width: double.infinity,
																	child: Row(
																		children: [
																			Container(
																				margin: const EdgeInsets.only( right: 36),
																				width: 47,
																				height: 41,
																				child: Image.network(
																					"https://storage.googleapis.com/tagjs-prod.appspot.com/v1/eZXFHBRH4B/y5qbc72r_expires_30_days.png",
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
																										"Results",
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
															Container(
																margin: const EdgeInsets.only( bottom: 29),
																width: 258,
																height: 341,
																child: Image.network(
																	"https://storage.googleapis.com/tagjs-prod.appspot.com/v1/eZXFHBRH4B/xhbyrjmp_expires_30_days.png",
																	fit: BoxFit.fill,
																)
															),
															InkWell(
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
																			padding: const EdgeInsets.only( top: 26, bottom: 26, left: 54, right: 54),
																			margin: const EdgeInsets.only( bottom: 43),
																			child: Column(
																				crossAxisAlignment: CrossAxisAlignment.start,
																				children: [
																					Text(
																						"Plastic",
																						style: TextStyle(
																							color: Color(0xFF498056),
																							fontSize: 36,
																							fontWeight: FontWeight.bold,
																						),
																					),
																				]
																			),
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
																			padding: const EdgeInsets.only( top: 16, bottom: 16, left: 28, right: 28),
																			margin: const EdgeInsets.only( bottom: 75),
																			child: Column(
																				crossAxisAlignment: CrossAxisAlignment.start,
																				children: [
																					Text(
																						"Learn More",
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
																											"https://storage.googleapis.com/tagjs-prod.appspot.com/v1/eZXFHBRH4B/vcu04q0p_expires_30_days.png",
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
																											"https://storage.googleapis.com/tagjs-prod.appspot.com/v1/eZXFHBRH4B/q3syvc6u_expires_30_days.png",
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
																											"https://storage.googleapis.com/tagjs-prod.appspot.com/v1/eZXFHBRH4B/aul7uick_expires_30_days.png",
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
																											"https://storage.googleapis.com/tagjs-prod.appspot.com/v1/eZXFHBRH4B/5yetz3w8_expires_30_days.png",
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