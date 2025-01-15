import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vlens_flutter/utilities/colors.dart';

import '../../../custom_views/custom_button.dart';
import '../../../utilities/text_styles.dart';
import '../../ids_verification/front_id_scanner/view/front_id_scanner.dart';

class IDsInstructionsScreen extends StatelessWidget {
  const IDsInstructionsScreen({super.key});

  // navigation
  static navigateToFrontIdScanner(BuildContext context) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const FrontIdScanner()));
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
        onPopInvokedWithResult: (bool popped, dynamic result) {
          Navigator.pushNamedAndRemoveUntil(context, "/IDsInstructionsScreen", (r) => false);
          SystemNavigator.pop();
        },
        child: Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 50, 20, 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Logo
                  Image.asset(
                    'assets/images/vlens_logo.png',
                    height: 56,
                  ),

                  SizedBox(
                    height: 14,
                  ),
                  // Scan Your ID Text
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'scan_your_id'.tr(),
                        style: CustomTextStyle.header,
                      ),
                      const SizedBox(width: 8),
                      Image.asset(
                        'assets/images/id.png',
                      ),
                    ],
                  ),

                  const SizedBox(height: 40),

                  // Illustration
                  Center(
                      child: Image.asset(
                    "assets/images/scan.png",
                    width: 237,
                    height: 242,
                  )),

                  const SizedBox(height: 40),

                  // Instructions Text
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 6),
                    child: Text(
                      'scan_id_instruction'.tr(),
                      textAlign: TextAlign.center,
                      style: CustomTextStyle.body,
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Tips Container
// Tips Container
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                    decoration: BoxDecoration(
                      color: UIColors.infoBlue50,
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(
                        color: UIColors.infoBlue,
                        width: 1.0,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.info_outline,
                                color: UIColors.infoBlue500, size: 16),
                            const SizedBox(width: 6),
                            Text('few_tip_to_success'.tr(),
                                style: CustomTextStyle.subHeader),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                spacing: 6,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('•', style: CustomTextStyle.subBody),
                                  Expanded(
                                    child: Text('make_sure_clear_id'.tr(),
                                        style: CustomTextStyle.subBody),
                                  ),
                                ],
                              ),
                              Row(
                                spacing: 6,
                                crossAxisAlignment: CrossAxisAlignment
                                    .start, // Align dots and text vertically
                                children: [
                                  Text('•', style: CustomTextStyle.subBody),
                                  Expanded(
                                    child: Text(
                                      'make_sure_easy_to_read'.tr(),
                                      style: CustomTextStyle.subBody,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Scan ID Button
                  CustomButton(
                    backgroundColor: UIColors.teal,
                    text: 'scan_id'.tr(),
                    onPressed: () {
                      navigateToFrontIdScanner(context);
                      // Add your functionality here
                    },
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}