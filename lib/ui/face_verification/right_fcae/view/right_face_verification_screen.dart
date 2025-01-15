import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:flutter/services.dart';
import 'package:vlens_flutter/ui/face_verification/left_face/view/left_face_verification_screen.dart';
import 'package:vlens_flutter/ui/face_verification/straight_face/view/straight_face_verification_screen.dart';
import 'package:vlens_flutter/utilities/colors.dart';

import '../../../../custom_views/custom_camera_button.dart';
import '../../../../custom_views/custom_camera_header.dart';

class RightFaceVerificationScreen extends StatefulWidget {
  const RightFaceVerificationScreen({super.key});

  @override
  State<RightFaceVerificationScreen> createState() =>
      _RightFaceVerificationScreen();
}

class _RightFaceVerificationScreen extends State<RightFaceVerificationScreen> {
  CameraController? _controller;
  bool _isFlashOn = false;
  bool _isInitialized = false;

  GlobalKey scanningFrameKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _initializeCamera();
    navigateToLeftFaceVerification(context);
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
    super.dispose();
    _controller?.dispose();
  }

  // navigation
  navigateToLeftFaceVerification(BuildContext context) {
    Future.delayed(const Duration(seconds: 6), () async {
      if (context.mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => const LeftFaceVerificationScreen()),
        );
      }
    });
  }

  navigateToStraightFace(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => const StraightFaceVerificationScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
        canPop: false,
        child: Scaffold(
          backgroundColor: Colors.black,
          body: SafeArea(
            child: Column(
              children: [
                // Header with navigation and flash
                CameraHeader(
                  onBackTap: () =>  navigateToStraightFace(context),
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
                              Image.asset('assets/images/right_face.png'),
                              const SizedBox(height: 8),
                              Text(
                                'look_right'.tr(),
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
                  onTap: () {},
                ),
              ],
            ),
          ),
        ));
  }
}
