import 'package:admin_dashboard/api/cafe_api.dart';
import 'package:admin_dashboard/models/models.dart';
import 'package:flutter/material.dart';

class UsersProvider extends ChangeNotifier {
  List<Usuario> users = [];
  bool isLoading = true;
  bool ascending = true;
  int? sortColumIndex;
  UsersProvider() {
    getPaginatedUsers();
  }

  getPaginatedUsers() async {
    final resp = await CafeApi.httpGet('/usuarios?limite=100&desde=0');
    final usersResp = UsersResponse.fromMap(resp);
    users = [...usersResp.usuarios];

    isLoading = false;
    notifyListeners();
  }

  Future<Usuario?> getUserByID(String uid) async {
    try {
      final resp = await CafeApi.httpGet('/usuarios/$uid');
      final user = Usuario.fromMap(resp);
      return user;
    } catch (e) {
      return null;
    }
  }

  void sort<T>(Comparable<T> Function(Usuario) getField) {
    users.sort((a, b) {
      final aValue = getField(a);
      final bValue = getField(b);
      return ascending
          ? Comparable.compare(aValue, bValue)
          : Comparable.compare(bValue, aValue);
    });
    ascending = !ascending;
    notifyListeners();
  }

  void refreshUser(Usuario newUser) {
    users = users.map((e) {
      if (e.uid == newUser.uid) {
        e = newUser;
      }
      return e;
    }).toList();
    notifyListeners();
  }
}
