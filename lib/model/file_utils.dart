import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class FileUtils {
  static Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  static Future<File> _localFile(String filename) async {
    final path = await _localPath;
    print("File path: $path/$filename"); // Print the file path
    return File('$path/$filename');
  }

  static Future<File> writeJson(String filename, Map<String, dynamic> json) async {
    final file = await _localFile(filename);
    return file.writeAsString(jsonEncode(json));
  }

  static Future<Map<String, dynamic>> readJson(String filename) async {
    try {
      final file = await _localFile(filename);
      final contents = await file.readAsString();
      return jsonDecode(contents);
    } catch (e) {
      print("Error reading JSON file: $e");
      return {};
    }
  }
}
