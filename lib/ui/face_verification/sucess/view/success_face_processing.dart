import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:vlens_flutter/utilities/colors.dart';
import 'package:vlens_flutter/utilities/text_styles.dart';

import '../../../../custom_views/custom_image_inside_circles.dart';

class SuccessFaceProcessing extends StatelessWidget {
  const SuccessFaceProcessing({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
        canPop: false,
        child: Scaffold(
            backgroundColor: Colors.white,
            body: SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Title
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 60),
                    child: Text(
                        textAlign: TextAlign.center,
                        "you_are_verified".tr(),
                        style: CustomTextStyle.header),
                  ),

                  const SizedBox(height: 30),
                  // Image Inside Circles
                  ImageInsideCircles(
                      circleColor: UIColors.teal200,
                      centerImage: Image.asset('assets/images/success.png')),
                  const SizedBox(height: 35),
                  // Description
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Text(
                      "face_scanned_successfully".tr(),
                      textAlign: TextAlign.center,
                      style: CustomTextStyle.body,
                    ),
                  ),
                ],
              ),
            )));
  }
}
