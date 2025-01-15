import 'dart:io';
import 'dart:typed_data';
import 'package:image/image.dart' as img;

Future<String?> cropImage({
  required String imagePath,
  required double offsetX,
  required double offsetY,
  required double width,
  required double height,
  required double scaleFactor,
}) async {
  try {
    // Load the image
    final bytes = await File(imagePath).readAsBytes();
    final image = img.decodeImage(Uint8List.fromList(bytes));

    if (image == null) {
      throw Exception('Failed to decode image');
    }

    // Scale the cropping coordinates and size based on the scale factor
    final scaledOffsetX = (offsetX * scaleFactor).toInt();
    final scaledOffsetY = (offsetY * scaleFactor).toInt();
    final scaledWidth = (width * scaleFactor).toInt();
    final scaledHeight = (height * scaleFactor).toInt();

    // Crop the image based on the scaled coordinates
    final croppedImage = img.copyCrop(
      image,
      x:scaledOffsetX,
      y:scaledOffsetY,
      width: scaledWidth,
      height: scaledHeight,
    );

    // Save the cropped image to a temporary directory
    final croppedImagePath = '${Directory.systemTemp.path}/cropped_image_${DateTime.now().millisecondsSinceEpoch}.jpg';
    final croppedFile = File(croppedImagePath);
    croppedFile.writeAsBytesSync(img.encodeJpg(croppedImage));

    return croppedImagePath;
  } catch (e) {
    print('Error cropping image: $e');
    return null;
  }
}
