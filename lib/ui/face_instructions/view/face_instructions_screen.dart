import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:vlens_flutter/utilities/colors.dart';

import '../../../custom_views/custom_button.dart';
import '../../../utilities/text_styles.dart';
import '../../face_verification/straight_face/view/straight_face_verification_screen.dart';

class FaceInstructionsScreen extends StatelessWidget {
  const FaceInstructionsScreen({super.key});

  // navigation
  static navigateToStraightFaceVerificationScreen(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => const StraightFaceVerificationScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
        canPop: false,
        child: Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 50, 20, 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
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
                        'lets_verify_your_face'.tr(),
                        style: CustomTextStyle.header,
                      ),
                      const SizedBox(width: 8),
                      Image.asset(
                        'assets/images/face.png',
                      ),
                    ],
                  ),

                  const SizedBox(height: 40),

                  // Illustration
                  Center(
                      child: Image.asset(
                    "assets/images/face_scan.png",
                    width: 237,
                    height: 242,
                  )),

                  const SizedBox(height: 40),

                  // Instructions Text
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 6),
                    child: Text(
                      'scan_face_instructions'.tr(),
                      textAlign: TextAlign.center,
                      style: CustomTextStyle.body,
                    ),
                  ),

                  const SizedBox(height: 35),

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
                          child: Row(
                            spacing: 6,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('•', style: CustomTextStyle.subBody),
                              Expanded(
                                child: Text('keep_your_camera_steady'.tr(),
                                    style: CustomTextStyle.subBody),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 35),

                  // Scan ID Button
                  SizedBox(
                    width: double.infinity,
                    child: CustomButton(
                      backgroundColor: UIColors.teal,
                      text: 'Start Scanning'.tr(),
                      onPressed: () {
                        navigateToStraightFaceVerificationScreen(context);
                        // Add your functionality here
                      },
                    ),
                  ),

                  const SizedBox(height: 14),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'powered_by'.tr(),
                        style: CustomTextStyle.body,
                      ),
                      Image.asset('assets/images/small_logo.png')
                    ],
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
