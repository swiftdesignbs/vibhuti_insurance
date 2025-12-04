import 'dart:io';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class DownloadService {
  static final Dio _dio = Dio();

  static Future<String?> downloadFile({
    required String url,
    required String fileName,
    required Function(int, int) onProgress,
  }) async {
    try {
      // Request storage permission
      final status = await Permission.storage.request();
      if (!status.isGranted) {
        throw Exception('Storage permission denied');
      }

      // Get download directory
      final Directory directory = await getApplicationDocumentsDirectory();
      final String savePath = '${directory.path}/$fileName';

      // Download file
      await _dio.download(url, savePath, onReceiveProgress: onProgress);

      return savePath;
    } catch (e) {
      print('Download error: $e');
      return null;
    }
  }

  static String getFileNameFromPath(String path) {
    return path.split('\\').last;
  }

  static String buildDownloadUrl(String relativePath) {
    String baseUrl = 'https://uatebpfapi.vibhutiinsurance.com';
    return '$baseUrl${relativePath.replaceAll('\\', '/')}';
  }
}
