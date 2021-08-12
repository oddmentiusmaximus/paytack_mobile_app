import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class CommonStorage {
  static Map<String, String> data = {};
  static FlutterSecureStorage storage = new FlutterSecureStorage();
  static Future<String?> readSecureStorageData(key) async {
    try {
      return await storage.read(key: key);
    } catch (e) {
      return "";
    }
  }

  static Future<String?> writeSecureStorageData(
    String key,
    String value,
  ) async {
    try {
      await storage.write(key: key, value: value);
    } catch (e) {
      return 'Error while reading file';
    }
  }

  static Future<String?> delete() async {
    try {
      await storage.deleteAll();
      data.clear();
    } catch (e) {
      return "Error while writing file";
    }
  }

  static Future<String?> deleteByKey(String key) async {
    try {
      data.clear();
    } catch (e) {
      return e.toString();
    }
  }
}
