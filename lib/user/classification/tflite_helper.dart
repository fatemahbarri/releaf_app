import 'dart:io';
import 'package:flutter/services.dart' show rootBundle;
import 'package:image/image.dart' as img;
import 'package:tflite_flutter/tflite_flutter.dart';

class TFLiteHelper {
  static late Interpreter _interpreter;
  static late List<String> _labels;
  static bool _isInitialized = false;

  static Future<void> init() async {
    try {
      _interpreter =
          await Interpreter.fromAsset('assets/model/best_model.tflite');

      final labelsData = await rootBundle.loadString('assets/model/labels.txt');

      _labels = labelsData
          .split('\n')
          .map((e) => e.trim())
          .where((e) => e.isNotEmpty)
          .toList();

      _isInitialized = true;
    } catch (e) {
      throw Exception('Failed to initialize TFLite: $e');
    }
  }

  static List<List<List<List<double>>>> preprocessImage(File imageFile) {
    final rawImage = img.decodeImage(imageFile.readAsBytesSync());
    if (rawImage == null) {
      throw Exception('Could not decode image.');
    }

    final resized = img.copyResize(rawImage, width: 224, height: 224);

    final input = List.generate(
      1,
      (_) => List.generate(
        224,
        (y) => List.generate(
          224,
          (x) {
            final pixel = resized.getPixel(x, y);

            final r = (pixel.r.toDouble() / 127.5) - 1.0;
            final g = (pixel.g.toDouble() / 127.5) - 1.0;
            final b = (pixel.b.toDouble() / 127.5) - 1.0;

            return [r, g, b];
          },
        ),
      ),
    );

    return input;
  }

  static Future<Map<String, dynamic>> classifyImage(File imageFile) async {
    if (!_isInitialized) {
      throw Exception('Model not initialized.');
    }

    final input = preprocessImage(imageFile);

    final output = [List<double>.filled(_labels.length, 0.0)];

    _interpreter.run(input, output);

    int maxIndex = 0;
    double maxScore = output[0][0];

    for (int i = 1; i < output[0].length; i++) {
      if (output[0][i] > maxScore) {
        maxScore = output[0][i];
        maxIndex = i;
      }
    }

    return {
      'label': _labels[maxIndex],
      'confidence': maxScore,
      'scores': output[0],
    };
  }
}
