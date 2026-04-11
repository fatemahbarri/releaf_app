import 'package:flutter/material.dart';
class Profile extends StatefulWidget {
	const Profile({super.key});
	@override
	ProfileState createState() => ProfileState();
}
class ProfileState extends State<Profile> {
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
																	margin: const EdgeInsets.only( bottom: 12, left: 8, right: 8),
																	width: double.infinity,
																	child: Row(
																		mainAxisAlignment: MainAxisAlignment.spaceBetween,
																		crossAxisAlignment: CrossAxisAlignment.start,
																		children: [
																			Container(
																				width: 47,
																				height: 41,
																				child: Image.network(
																					"https://storage.googleapis.com/tagjs-prod.appspot.com/v1/sRTqd7cMrP/bt224cby_expires_30_days.png",
																					fit: BoxFit.fill,
																				)
																			),
																			Container(
																				margin: const EdgeInsets.only( top: 31),
																				width: 157,
																				height: 157,
																				child: Image.network(
																					"https://storage.googleapis.com/tagjs-prod.appspot.com/v1/sRTqd7cMrP/ujufvow6_expires_30_days.png",
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
																margin: const EdgeInsets.only( bottom: 63),
																child: Text(
																	"Sara",
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
																	padding: const EdgeInsets.symmetric(vertical: 15),
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
																					"sara@gmail.com",
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
																	padding: const EdgeInsets.only( top: 19, bottom: 19, left: 21),
																	margin: const EdgeInsets.only( bottom: 134, left: 24, right: 24),
																	width: double.infinity,
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
																											"https://storage.googleapis.com/tagjs-prod.appspot.com/v1/sRTqd7cMrP/up3lml43_expires_30_days.png",
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
																											"https://storage.googleapis.com/tagjs-prod.appspot.com/v1/sRTqd7cMrP/qwyxo406_expires_30_days.png",
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
																											"https://storage.googleapis.com/tagjs-prod.appspot.com/v1/sRTqd7cMrP/hxy75h7q_expires_30_days.png",
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
																											"https://storage.googleapis.com/tagjs-prod.appspot.com/v1/sRTqd7cMrP/rnq4p0vj_expires_30_days.png",
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