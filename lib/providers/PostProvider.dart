
import 'package:flutter/material.dart';
import 'package:random_user/data/models/Post.dart';
import 'package:random_user/services/ApiService.dart';
import 'package:random_user/services/serviceLocator.dart';

class PostProvider with ChangeNotifier {
  String _authError;


  List<Post> _postList;

  List<Post> get posts => _postList;

  set authErrorMsg(String er) {
    _authError = er;
    notifyListeners();
  }

  String get authErrorMsg => _authError;

  ApiService get _apiService => sl.get<ApiService>();


  Future<void> getPosts() async {
      try {
        final List<Post> _postItems  = await _apiService.getPost();

        _postList = _postItems;

        notifyListeners();
      } catch (e) {
        authErrorMsg =
            e.message ?? 'An error occurred while processing your request';
        notifyListeners();
      }
  }
}
