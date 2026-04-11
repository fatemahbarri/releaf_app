import 'package:flutter/material.dart';
class ProfileEdit extends StatefulWidget {
	const ProfileEdit({super.key});
	@override
	ProfileEditState createState() => ProfileEditState();
}
class ProfileEditState extends State<ProfileEdit> {
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
																	margin: const EdgeInsets.only( bottom: 48, left: 8, right: 8),
																	width: double.infinity,
																	child: Row(
																		mainAxisAlignment: MainAxisAlignment.spaceBetween,
																		crossAxisAlignment: CrossAxisAlignment.start,
																		children: [
																			Container(
																				width: 47,
																				height: 41,
																				child: Image.network(
																					"https://storage.googleapis.com/tagjs-prod.appspot.com/v1/sRTqd7cMrP/78nky115_expires_30_days.png",
																					fit: BoxFit.fill,
																				)
																			),
																			Container(
																				margin: const EdgeInsets.only( top: 31),
																				width: 162,
																				height: 162,
																				child: Image.network(
																					"https://storage.googleapis.com/tagjs-prod.appspot.com/v1/sRTqd7cMrP/08ywuva9_expires_30_days.png",
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
																	padding: const EdgeInsets.only( top: 11, bottom: 11, left: 16),
																	margin: const EdgeInsets.only( bottom: 14, left: 42, right: 42),
																	width: double.infinity,
																	child: Column(
																		crossAxisAlignment: CrossAxisAlignment.start,
																		children: [
																			Text(
																				"First Name",
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
																	padding: const EdgeInsets.only( top: 11, bottom: 11, left: 18),
																	margin: const EdgeInsets.only( bottom: 13, left: 42, right: 42),
																	width: double.infinity,
																	child: Column(
																		crossAxisAlignment: CrossAxisAlignment.start,
																		children: [
																			Text(
																				"Last Name",
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
																	padding: const EdgeInsets.only( top: 11, bottom: 11, left: 16),
																	margin: const EdgeInsets.only( bottom: 10, left: 42, right: 42),
																	width: double.infinity,
																	child: Column(
																		crossAxisAlignment: CrossAxisAlignment.start,
																		children: [
																			Text(
																				"Username",
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
																	padding: const EdgeInsets.only( top: 11, bottom: 11, left: 18),
																	margin: const EdgeInsets.only( bottom: 10, left: 42, right: 42),
																	width: double.infinity,
																	child: Column(
																		crossAxisAlignment: CrossAxisAlignment.start,
																		children: [
																			Text(
																				"Email Address",
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
																	padding: const EdgeInsets.only( top: 11, bottom: 11, left: 16),
																	margin: const EdgeInsets.only( bottom: 80, left: 42, right: 42),
																	width: double.infinity,
																	child: Column(
																		crossAxisAlignment: CrossAxisAlignment.start,
																		children: [
																			Text(
																				"Password",
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
																			margin: const EdgeInsets.only( bottom: 71),
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
																											"https://storage.googleapis.com/tagjs-prod.appspot.com/v1/sRTqd7cMrP/6m1vw2vt_expires_30_days.png",
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
																											"https://storage.googleapis.com/tagjs-prod.appspot.com/v1/sRTqd7cMrP/69cn88j9_expires_30_days.png",
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
																											"https://storage.googleapis.com/tagjs-prod.appspot.com/v1/sRTqd7cMrP/hfnii33n_expires_30_days.png",
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
																											"https://storage.googleapis.com/tagjs-prod.appspot.com/v1/sRTqd7cMrP/372vt00w_expires_30_days.png",
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