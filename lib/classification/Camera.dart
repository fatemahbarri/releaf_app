import 'package:flutter/material.dart';
class Camera extends StatefulWidget {
	const Camera({super.key});
	@override
	CameraState createState() => CameraState();
}
class CameraState extends State<Camera> {
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
																			"https://storage.googleapis.com/tagjs-prod.appspot.com/v1/eZXFHBRH4B/vmaonxx3_expires_30_days.png",
																			fit: BoxFit.fill,
																		)
																	),
																	Text(
																		"Take Photo",
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
															padding: const EdgeInsets.only( top: 63),
															width: double.infinity,
															decoration: BoxDecoration(
																image: DecorationImage(
																	image: NetworkImage("https://storage.googleapis.com/tagjs-prod.appspot.com/v1/eZXFHBRH4B/7ojm6jgu_expires_30_days.png"),
																	fit: BoxFit.fill
																),
															),
															child: Column(
																crossAxisAlignment: CrossAxisAlignment.start,
																children: [
																	Container(
																		margin: const EdgeInsets.only( bottom: 188),
																		height: 438,
																		width: double.infinity,
																		child: Image.network(
																			"https://storage.googleapis.com/tagjs-prod.appspot.com/v1/eZXFHBRH4B/sb1ztkx1_expires_30_days.png",
																			fit: BoxFit.fill,
																		)
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
																												"https://storage.googleapis.com/tagjs-prod.appspot.com/v1/eZXFHBRH4B/oix16ndx_expires_30_days.png",
																												fit: BoxFit.fill,
																											)
																										),
																										Container(
																											margin: const EdgeInsets.only( right: 47),
																											width: 56,
																											height: 32,
																											child: Image.network(
																												"https://storage.googleapis.com/tagjs-prod.appspot.com/v1/eZXFHBRH4B/f8ld2j7i_expires_30_days.png",
																												fit: BoxFit.fill,
																											)
																										),
																										Container(
																											width: 56,
																											height: 32,
																											child: Image.network(
																												"https://storage.googleapis.com/tagjs-prod.appspot.com/v1/eZXFHBRH4B/rre6jc62_expires_30_days.png",
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
																											margin: const EdgeInsets.only( right: 71),
																											child: Text(
																												"Home",
																												style: TextStyle(
																													color: Color(0xFF49454F),
																													fontSize: 12,
																												),
																											),
																										),
																										Container(
																											margin: const EdgeInsets.only( right: 76),
																											child: Text(
																												"Users",
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