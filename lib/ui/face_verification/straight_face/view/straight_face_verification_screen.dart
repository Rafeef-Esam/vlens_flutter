import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:flutter/services.dart';
import 'package:vlens_flutter/ui/face_verification/right_fcae/view/right_face_verification_screen.dart';
import 'package:vlens_flutter/utilities/colors.dart';

import '../../../../custom_views/custom_camera_button.dart';
import '../../../../custom_views/custom_camera_header.dart';

class StraightFaceVerificationScreen extends StatefulWidget {
  const StraightFaceVerificationScreen({super.key});

  @override
  State<StraightFaceVerificationScreen> createState() => _StraightFaceVerificationScreen();
}

class _StraightFaceVerificationScreen extends State<StraightFaceVerificationScreen> {
  CameraController? _controller;
  bool _isFlashOn = false;
  bool _isInitialized = false;

  GlobalKey scanningFrameKey = GlobalKey();


  @override
  void initState() {
    super.initState();
    _initializeCamera();
    navigateToRightFaceVerification(context);
  }

  Future<void> _initializeCamera() async {
    try {
      final cameras = await availableCameras();
      if (cameras.isEmpty) return;

      final frontCamera = cameras.firstWhere(
            (camera) => camera.lensDirection == CameraLensDirection.front,
      );

      _controller = CameraController(
        frontCamera,
        ResolutionPreset.high,
        enableAudio: false,
        imageFormatGroup: ImageFormatGroup.jpeg,
      );

      await _controller?.initialize();
      await _controller?.lockCaptureOrientation(DeviceOrientation.portraitUp);

      setState(() {
        _isInitialized = true;
      });
    } catch (e) {
      print('Error initializing camera: $e');
    }
  }

  void _toggleFlash() async {
    if (_controller != null && _isInitialized) {
      setState(() {
        _isFlashOn = !_isFlashOn;
      });
      await _controller?.setFlashMode(
        _isFlashOn ? FlashMode.torch : FlashMode.off,
      );
    }
  }

  Future<void> _takePicture() async {
    if (_controller != null && _isInitialized) {
      try {
        final XFile? photo = await _controller?.takePicture();
        if (photo != null) {
          // Directly handle the captured image path
          print('Image saved at: ${photo.path}');
        }
      } catch (e) {
        print('Error taking picture: $e');
      }
    }
  }
  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  // navigation
   navigateToRightFaceVerification(BuildContext context) {
    Future.delayed(const Duration(seconds: 6), () { // TODO: Remove delay in production
      if (context.mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const RightFaceVerificationScreen()),
        );
      }
    });
  }

  navigateToFaceInsctruction(){

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            // Header with navigation and flash
            CameraHeader(
              onBackTap: () => Navigator.pop(context),
              onFlashToggle: _toggleFlash,
              isFlashOn: _isFlashOn,
            ),
            // Camera Preview
            Expanded(
              child: Stack(
                children: [
                  if (_isInitialized && _controller != null)
                    RotatedBox(
                      quarterTurns: 3,
                      child: Align(
                        alignment: Alignment.center,
                        child: SizedBox.expand(
                          child: Transform.scale(
                            scaleY: -1,
                            child: CameraPreview(_controller!),
                          ),
                        ),
                      ),
                    )
                  else
                    const Align(
                      alignment: Alignment.center,
                      child: CircularProgressIndicator(),
                    ),

                  // Instruction Container Positioned below the Scanning Frame
                  Positioned(
                    bottom: 40,
                    left: 20,
                    right: 20,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 25),
                      decoration: BoxDecoration(
                        color: UIColors.midnightBlue,
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(
                          color: Colors.transparent,
                          width: 1.0,
                        ),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.asset('assets/images/striat_face.png'),
                          const SizedBox(height: 8),
                          Text(
                            'look_straight'.tr(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: UIColors.white50,
                                fontSize: 16,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Bottom Button (Capture Image)
            CameraButton(
              onTap: (){},
            ),
          ],
        ),
      ),
    );
  }
}
