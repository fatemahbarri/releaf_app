import 'package:flutter/material.dart';
class SignUp extends StatefulWidget {
	const SignUp({super.key});
	@override
	SignUpState createState() => SignUpState();
}
class SignUpState extends State<SignUp> {
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
											padding: const EdgeInsets.symmetric(vertical: 42),
											child: Column(
												crossAxisAlignment: CrossAxisAlignment.start,
												children: [
													IntrinsicHeight(
														child: Container(
															margin: const EdgeInsets.only( bottom: 39, left: 25, right: 25),
															width: double.infinity,
															child: Row(
																crossAxisAlignment: CrossAxisAlignment.start,
																children: [
																	Container(
																		margin: const EdgeInsets.only( right: 34),
																		width: 47,
																		height: 41,
																		child: Image.network(
																			"https://storage.googleapis.com/tagjs-prod.appspot.com/v1/eZXFHBRH4B/92e1b7xh_expires_30_days.png",
																			fit: BoxFit.fill,
																		)
																	),
																	Expanded(
																		child: Container(
																			margin: const EdgeInsets.only( right: 34),
																			height: 163,
																			width: double.infinity,
																			child: Image.network(
																				"https://storage.googleapis.com/tagjs-prod.appspot.com/v1/eZXFHBRH4B/hb3u0pfj_expires_30_days.png",
																				fit: BoxFit.fill,
																			)
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
														margin: const EdgeInsets.only( bottom: 21, left: 68),
														child: Text(
															"Create Account ",
															style: TextStyle(
																color: Color(0xFF498056),
																fontSize: 40,
																fontWeight: FontWeight.bold,
															),
														),
													),
													IntrinsicHeight(
														child: Container(
															margin: const EdgeInsets.only( bottom: 23),
															width: double.infinity,
															child: Column(
																children: [
																	Text(
																		"Sign up to get started",
																		style: TextStyle(
																			color: Color(0xFF675F5A),
																			fontSize: 18,
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
															margin: const EdgeInsets.only( bottom: 14, left: 48, right: 48),
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
															margin: const EdgeInsets.only( bottom: 13, left: 48, right: 48),
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
															margin: const EdgeInsets.only( bottom: 10, left: 48, right: 48),
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
															margin: const EdgeInsets.only( bottom: 10, left: 48, right: 48),
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
															margin: const EdgeInsets.only( bottom: 12, left: 48, right: 48),
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
															margin: const EdgeInsets.only( bottom: 26, left: 48, right: 48),
															width: double.infinity,
															child: Column(
																crossAxisAlignment: CrossAxisAlignment.start,
																children: [
																	Text(
																		"Confirm Password",
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
														child: IntrinsicHeight(
															child: Container(
																decoration: BoxDecoration(
																	borderRadius: BorderRadius.circular(142),
																	color: Color(0xFF499A64),
																	boxShadow: [
																		BoxShadow(
																			color: Color(0x40000000),
																			blurRadius: 4,
																			offset: Offset(0, 4),
																		),
																	],
																),
																padding: const EdgeInsets.symmetric(vertical: 5),
																margin: const EdgeInsets.only( bottom: 22, left: 48, right: 48),
																width: double.infinity,
																child: Column(
																	children: [
																		Text(
																			"Sign up",
																			style: TextStyle(
																				color: Color(0xFFFFFFFF),
																				fontSize: 26,
																				fontWeight: FontWeight.bold,
																			),
																		),
																	]
																),
															),
														),
													),
													IntrinsicHeight(
														child: Container(
															width: double.infinity,
															child: Column(
																children: [
																	Text(
																		"Already have an account? Log in",
																		style: TextStyle(
																			color: Color(0xFF4676AE),
																			fontSize: 18,
																			fontWeight: FontWeight.bold,
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