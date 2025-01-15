import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class CameraHeader extends StatelessWidget {
  final VoidCallback onBackTap;
  final VoidCallback onFlashToggle;
  final bool isFlashOn;

  const CameraHeader({
    super.key,
    required this.onBackTap,
    required this.onFlashToggle,
    required this.isFlashOn,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          GestureDetector(
            onTap: onBackTap,
            child: const Icon(
              Icons.arrow_back,
              color: Colors.white,
              size: 24,
            ),
          ),
          const Spacer(),
          Text(
            'camera'.tr(),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 17,
              fontWeight: FontWeight.w600,
            ),
          ),
          const Spacer(),
          GestureDetector(
            onTap: onFlashToggle,
            child: Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.white,
                  width: 1,
                ),
              ),
              child: Center(
                child: Icon(
                  isFlashOn ? Icons.flash_on_rounded : Icons.flash_off_rounded,
                  color: Colors.white, // Icon color
                  size: 16,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
