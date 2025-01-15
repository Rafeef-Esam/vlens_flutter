import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:vlens_flutter/utilities/colors.dart';

import '../../../../custom_views/custom_image_inside_circles.dart';
import '../../../../di/di_setup.dart';
import '../../../../utilities/text_styles.dart';
import '../../faild/view/faild_face_processing.dart';
import '../../sucess/view/success_face_processing.dart';
import '../view_model/face_verfication_processing_view_model.dart';

class FaceVerificationProcessing extends StatefulWidget {
  const FaceVerificationProcessing({super.key});

  @override
  State<FaceVerificationProcessing> createState() =>
      _FaceVerificationProcessing();
}

class _FaceVerificationProcessing extends State<FaceVerificationProcessing> {
  late FaceVerificationProcessingViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = getIt<FaceVerificationProcessingViewModel>();
    _processIdsAndNavigate();
  }

  // Modify the function to wait for processIds to finish
  Future<void> _processIdsAndNavigate() async {
    await _viewModel.processIds();
    if (mounted) {
      if (_viewModel.isSuccess) {
        navigateToSuccess(context);
      } else {
        navigateToFailure(context);
      }
    }
  }

  // navigation
  static navigateToSuccess(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SuccessFaceProcessing()),
    );
  }

  static navigateToFailure(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const FailedFaceProcessing()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
        canPop: false,
        child: ChangeNotifierProvider.value(
          value: _viewModel,
          child: Scaffold(
            backgroundColor: Colors.white,
            body: Consumer<FaceVerificationProcessingViewModel>(
              builder: (context, viewModel, child) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Title
                    Text(
                      "verify_your_identity".tr(),
                      style: CustomTextStyle.header,
                    ),
                    const SizedBox(height: 30),
                    // Image Inside Circles
                    ImageInsideCircles(
                      circleColor: UIColors.sandColor,
                      centerImage: Image.asset('assets/images/verify_face.png'),
                    ),
                    const SizedBox(height: 30),
                    // Description
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 50),
                      child: Text(
                        "facial_processing".tr(),
                        textAlign: TextAlign.center,
                        style: CustomTextStyle.body,
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ));
  }
}
