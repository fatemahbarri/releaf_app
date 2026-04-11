import 'package:flutter/material.dart';
class AdminProfile extends StatefulWidget {
	const AdminProfile({super.key});
	@override
	AdminProfileState createState() => AdminProfileState();
}
class AdminProfileState extends State<AdminProfile> {
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
											child: Column(
												crossAxisAlignment: CrossAxisAlignment.start,
												children: [
													IntrinsicHeight(
														child: Container(
															padding: const EdgeInsets.only( top: 50),
															width: double.infinity,
															child: Column(
																children: [
																	IntrinsicHeight(
																		child: Container(
																			margin: const EdgeInsets.only( bottom: 10, left: 8, right: 8),
																			width: double.infinity,
																			child: Row(
																				mainAxisAlignment: MainAxisAlignment.spaceBetween,
																				crossAxisAlignment: CrossAxisAlignment.start,
																				children: [
																					Container(
																						width: 47,
																						height: 41,
																						child: Image.network(
																							"https://storage.googleapis.com/tagjs-prod.appspot.com/v1/eZXFHBRH4B/5o77do5e_expires_30_days.png",
																							fit: BoxFit.fill,
																						)
																					),
																					Container(
																						margin: const EdgeInsets.only( top: 31),
																						width: 157,
																						height: 157,
																						child: Image.network(
																							"https://storage.googleapis.com/tagjs-prod.appspot.com/v1/eZXFHBRH4B/cmeqdf9u_expires_30_days.png",
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
																	Container(
																		margin: const EdgeInsets.only( bottom: 57),
																		child: Text(
																			"Fatemah Alyami",
																			style: TextStyle(
																				color: Color(0xFF7CA385),
																				fontSize: 35,
																				fontWeight: FontWeight.bold,
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
																				color: Color(0xFFCDE9C7),
																				boxShadow: [
																					BoxShadow(
																						color: Color(0x40000000),
																						blurRadius: 4,
																						offset: Offset(0, 4),
																					),
																				],
																			),
																			padding: const EdgeInsets.symmetric(vertical: 16),
																			margin: const EdgeInsets.only( bottom: 32, left: 24, right: 24),
																			width: double.infinity,
																			child: Column(
																				crossAxisAlignment: CrossAxisAlignment.start,
																				children: [
																					Container(
																						margin: const EdgeInsets.only( bottom: 12, left: 22),
																						child: Text(
																							"Email",
																							style: TextStyle(
																								color: Color(0xFF498056),
																								fontSize: 28,
																								fontWeight: FontWeight.bold,
																							),
																						),
																					),
																					Container(
																						margin: const EdgeInsets.only( left: 20),
																						child: Text(
																							"fatemah@releaf.com",
																							style: TextStyle(
																								color: Color(0xFF675F5A),
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
																				color: Color(0xFFCDE9C7),
																				boxShadow: [
																					BoxShadow(
																						color: Color(0x40000000),
																						blurRadius: 4,
																						offset: Offset(0, 4),
																					),
																				],
																			),
																			padding: const EdgeInsets.only( top: 16, bottom: 16, left: 21, right: 21),
																			margin: const EdgeInsets.only( bottom: 134, left: 24, right: 24),
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
																										margin: const EdgeInsets.only( bottom: 17),
																										child: Text(
																											"Password",
																											style: TextStyle(
																												color: Color(0xFF498056),
																												fontSize: 28,
																												fontWeight: FontWeight.bold,
																											),
																										),
																									),
																									Text(
																										"**************",
																										style: TextStyle(
																											color: Color(0xFF675F5A),
																											fontSize: 20,
																											fontWeight: FontWeight.bold,
																										),
																									),
																								]
																							),
																						),
																					),
																					Container(
																						width: 25,
																						height: 25,
																						child: Image.network(
																							"https://storage.googleapis.com/tagjs-prod.appspot.com/v1/eZXFHBRH4B/bakos57k_expires_30_days.png",
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
																					padding: const EdgeInsets.only( top: 14, bottom: 14, left: 46, right: 46),
																					margin: const EdgeInsets.only( bottom: 67),
																					child: Column(
																						crossAxisAlignment: CrossAxisAlignment.start,
																						children: [
																							Text(
																								"Log Out",
																								style: TextStyle(
																									color: Color(0xFF9C1111),
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
																								margin: const EdgeInsets.only( left: 16, right: 47),
																								child: Column(
																									crossAxisAlignment: CrossAxisAlignment.start,
																									children: [
																										Container(
																											margin: const EdgeInsets.only( bottom: 4),
																											width: 56,
																											height: 32,
																											child: Image.network(
																												"https://storage.googleapis.com/tagjs-prod.appspot.com/v1/eZXFHBRH4B/7irrjtnt_expires_30_days.png",
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
																												"https://storage.googleapis.com/tagjs-prod.appspot.com/v1/eZXFHBRH4B/zv5bkjbd_expires_30_days.png",
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
																												"https://storage.googleapis.com/tagjs-prod.appspot.com/v1/eZXFHBRH4B/qolvttj0_expires_30_days.png",
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
																				]
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