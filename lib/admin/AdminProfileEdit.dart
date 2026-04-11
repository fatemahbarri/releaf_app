import 'package:flutter/material.dart';
class AdminProfileEdit extends StatefulWidget {
	const AdminProfileEdit({super.key});
	@override
	AdminProfileEditState createState() => AdminProfileEditState();
}
class AdminProfileEditState extends State<AdminProfileEdit> {
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
													padding: const EdgeInsets.only( top: 50),
													height: 852,
													width: double.infinity,
													child: Column(
														children: [
															IntrinsicHeight(
																child: Container(
																	margin: const EdgeInsets.only( bottom: 323, left: 8, right: 8),
																	width: double.infinity,
																	child: Row(
																		mainAxisAlignment: MainAxisAlignment.spaceBetween,
																		crossAxisAlignment: CrossAxisAlignment.start,
																		children: [
																			Container(
																				width: 47,
																				height: 41,
																				child: Image.network(
																					"https://storage.googleapis.com/tagjs-prod.appspot.com/v1/eZXFHBRH4B/onvfyj1j_expires_30_days.png",
																					fit: BoxFit.fill,
																				)
																			),
																			Container(
																				margin: const EdgeInsets.only( top: 31),
																				width: 162,
																				height: 162,
																				child: Image.network(
																					"https://storage.googleapis.com/tagjs-prod.appspot.com/v1/eZXFHBRH4B/r08n641v_expires_30_days.png",
																					fit: BoxFit.fill,
																				)
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
																			padding: const EdgeInsets.only( top: 16, bottom: 16, left: 60, right: 60),
																			margin: const EdgeInsets.only( bottom: 172),
																			child: Column(
																				crossAxisAlignment: CrossAxisAlignment.start,
																				children: [
																					Text(
																						"Done",
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
																	margin: const EdgeInsets.only( bottom: 1),
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
																											"https://storage.googleapis.com/tagjs-prod.appspot.com/v1/eZXFHBRH4B/5ne08vww_expires_30_days.png",
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
																											"https://storage.googleapis.com/tagjs-prod.appspot.com/v1/eZXFHBRH4B/i9zaygse_expires_30_days.png",
																											fit: BoxFit.fill,
																										)
																									),
																									Text(
																										"Users",
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
																											"https://storage.googleapis.com/tagjs-prod.appspot.com/v1/eZXFHBRH4B/fn4j8r0m_expires_30_days.png",
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
																											"https://storage.googleapis.com/tagjs-prod.appspot.com/v1/eZXFHBRH4B/kejsqxxd_expires_30_days.png",
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