import 'package:doafric/db_helper/sqlite_database.dart';
import 'package:doafric/utils/string_file.dart';
import 'package:get/get.dart';

class StorageController extends GetxController {
  final _userName = ''.obs;
  final _userId = 0.obs;
  final _isLogin = false.obs;
  final _userEmail = ''.obs;
  final _userPhone = ''.obs;

  String get userName => _userName.value;
  set userName(String name) => _userName.value = name;

  int get userId => _userId.value;
  set userId(int id) => _userId.value = id;

  String get userEmail => _userEmail.value;
  set userEmail(String email) => _userEmail.value = email;

  String get userPhone => _userPhone.value;
  set userPhone(String phone) => _userPhone.value = phone;

  bool get isLogin => _isLogin.value;
  set isLogin(bool login) => _isLogin.value = login;

  /* String get apiToken => _apiToken.value;
  set apiToken(String token) => _apiToken.value = token;*/

  @override
  onInit() {
    super.onInit();
  }

  //read data

  String getUserName = SqliteDatabase.readData(StorageKeys.userName) ?? '';

  String getUserPhone = SqliteDatabase.readData(StorageKeys.userPhone) ?? '';

  String getUserEmail = SqliteDatabase.readData(StorageKeys.userEmail) ?? '';

  int getUserId = SqliteDatabase.readData(StorageKeys.userId) ?? '';

  // String getApiToken = SqliteDatabase.readData(StorageKeys.apiToken) ?? '';

  bool getUserLogin = SqliteDatabase.readData(StorageKeys.isLogin) ?? false;

  //write data
  Future<dynamic> writeUserName(String name) =>
      SqliteDatabase.writeData(StorageKeys.userName, name);

  Future<dynamic> writeUserEmail(String email) =>
      SqliteDatabase.writeData(StorageKeys.userEmail, email);

  Future<dynamic> writeUserPhone(String phone) =>
      SqliteDatabase.writeData(StorageKeys.userPhone, phone);

  Future<dynamic> writeUserId(int userId) =>
      SqliteDatabase.writeData(StorageKeys.userId, userId);

  Future<dynamic> writeUserLogin(bool isLogin) =>
      SqliteDatabase.writeData(StorageKeys.isLogin, isLogin);

  // Future<dynamic> writeApiToken(String token) => SqliteDatabase.writeData(StorageKeys.apiToken, token);

}
