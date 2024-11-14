import 'package:flutter/material.dart';

import '../db/db_helper.dart';
import '../model/user_model.dart';

class UserProvider extends ChangeNotifier {
  final DBHelper dbHelper = DBHelper();

  List<User> _users = [];
  int _totalUsers = 0;
  DateTime? _dob;
  int _page = 1; 
  final int _limit = 8; 

  List<User> get users => _users;
  int get totalUsers => _totalUsers;
  DateTime? get dob => _dob;
  int get page => _page;
  int get limit => _limit;
  
  Future<void> fetchUsers() async {
    final offset = (_page - 1) * _limit;
    final List<Map<String, dynamic>> userMaps = await dbHelper.getUsersData(offset, _limit);
    _users = userMaps.map((map) => User.fromMap(map)).toList();
    _totalUsers = await dbHelper.countUsers();
    notifyListeners();
  }

  Future<void> nextPage() async {
    if (_page * _limit < _totalUsers) {
      _page++;
      await fetchUsers();
    }
  }

  Future<void> previousPage() async {
    if (_page > 1) {
      _page--;
      await fetchUsers();
    }
  }

  Future<void> addUser(User user) async {
    await dbHelper.insertUserDataInDB(user.toMap());
    await fetchUsers(); 
  }

  Future<void> deleteUser(int userId)async{
    await dbHelper.deleteUser(userId);
    await fetchUsers();
  }

  void updateDob(DateTime? newDob) {
    _dob = newDob;
    notifyListeners();
  }
}