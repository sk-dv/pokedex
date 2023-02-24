import 'dart:io';

import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';

class ImageDownloader {
  const ImageDownloader._(this._imagePath);

  final String _imagePath;

  static Future<ImageDownloader> setup() async {
    final directory = await getApplicationDocumentsDirectory();

    final path = '${directory.path}/images';
    final imageDirectory = await Directory(path).create(recursive: true);

    return ImageDownloader._(imageDirectory.path);
  }

  Future<String> saveImage(String name, String url) async {
    final options = Options(responseType: ResponseType.bytes);
    final response = await Dio().get(url, options: options);

    final file = File('$_imagePath/$name');
    file.writeAsBytesSync(response.data);

    return file.path;
  }

  File readImage(String filePath) => File(filePath);
}
