import 'package:flutter/material.dart';
class UploadPhoto extends StatefulWidget {
	const UploadPhoto({super.key});
	@override
	UploadPhotoState createState() => UploadPhotoState();
}
class UploadPhotoState extends State<UploadPhoto> {
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
											padding: const EdgeInsets.only( top: 50),
											child: Column(
												crossAxisAlignment: CrossAxisAlignment.start,
												children: [
													IntrinsicHeight(
														child: Container(
															margin: const EdgeInsets.only( bottom: 8, left: 8, right: 8),
															width: double.infinity,
															child: Row(
																mainAxisAlignment: MainAxisAlignment.spaceBetween,
																children: [
																	Container(
																		width: 47,
																		height: 41,
																		child: Image.network(
																			"https://storage.googleapis.com/tagjs-prod.appspot.com/v1/eZXFHBRH4B/133t0caa_expires_30_days.png",
																			fit: BoxFit.fill,
																		)
																	),
																	Text(
																		"Upload Photo",
																		style: TextStyle(
																			color: Color(0xFF498056),
																			fontSize: 28,
																			fontWeight: FontWeight.bold,
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
															width: double.infinity,
															child: Column(
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
																				color: Color(0xFFE5F3D0),
																				boxShadow: [
																					BoxShadow(
																						color: Color(0x40000000),
																						blurRadius: 4,
																						offset: Offset(0, 4),
																					),
																				],
																			),
																			padding: const EdgeInsets.only( bottom: 1),
																			width: double.infinity,
																			child: Column(
																				crossAxisAlignment: CrossAxisAlignment.start,
																				children: [
																					Container(
																						height: 689,
																						width: double.infinity,
																						child: Image.network(
																							"https://storage.googleapis.com/tagjs-prod.appspot.com/v1/eZXFHBRH4B/1lvgd9xq_expires_30_days.png",
																							fit: BoxFit.fill,
																						)
																					),
																				]
																			),
																		),
																	),
																	IntrinsicHeight(
																		child: Container(
																			color: Color(0xFFCDE9C7),
																			padding: const EdgeInsets.symmetric(vertical: 6),
																			width: double.infinity,
																			child: Column(
																				crossAxisAlignment: CrossAxisAlignment.start,
																				children: [
																					IntrinsicWidth(
																						child: IntrinsicHeight(
																							child: Container(
																								margin: const EdgeInsets.only( bottom: 4, left: 23),
																								child: Row(
																									children: [
																										Container(
																											margin: const EdgeInsets.only( right: 47),
																											width: 56,
																											height: 32,
																											child: Image.network(
																												"https://storage.googleapis.com/tagjs-prod.appspot.com/v1/eZXFHBRH4B/4wo1xn6u_expires_30_days.png",
																												fit: BoxFit.fill,
																											)
																										),
																										Container(
																											margin: const EdgeInsets.only( right: 47),
																											width: 56,
																											height: 32,
																											child: Image.network(
																												"https://storage.googleapis.com/tagjs-prod.appspot.com/v1/eZXFHBRH4B/1snz16ad_expires_30_days.png",
																												fit: BoxFit.fill,
																											)
																										),
																										Container(
																											width: 56,
																											height: 32,
																											child: Image.network(
																												"https://storage.googleapis.com/tagjs-prod.appspot.com/v1/eZXFHBRH4B/4mkl2dvb_expires_30_days.png",
																												fit: BoxFit.fill,
																											)
																										),
																									]
																								),
																							),
																						),
																					),
																					IntrinsicWidth(
																						child: IntrinsicHeight(
																							child: Container(
																								margin: const EdgeInsets.only( left: 35),
																								child: Row(
																									children: [
																										Container(
																											margin: const EdgeInsets.only( right: 65),
																											child: Text(
																												"Home",
																												style: TextStyle(
																													color: Color(0xFF49454F),
																													fontSize: 12,
																												),
																											),
																										),
																										Container(
																											margin: const EdgeInsets.only( right: 69),
																											child: Text(
																												"Camera",
																												style: TextStyle(
																													color: Color(0xFF625B71),
																													fontSize: 12,
																												),
																											),
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