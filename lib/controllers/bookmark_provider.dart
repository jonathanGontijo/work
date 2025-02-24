import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:work/constants/app_constants.dart';
import 'package:work/models/bookmark_res.dart';
import 'package:work/models/response/bookmarks/all_bookmarks.dart';
import 'package:work/services/helpers/book_helper.dart';

class BookMarkNotifier extends ChangeNotifier {
  List<String> _jobs = [];
  Future<List<AllBookmark>>? bookmarks;

  List<String> get jobs => _jobs;

  set jobs(List<String> newList) {
    _jobs = newList;
    notifyListeners();
  }

  // Fix: Jobs cannot be null
  Future<void> addJob(String jobId) async {
    final prefs = await SharedPreferences.getInstance();
    _jobs.insert(0, jobId);
    await prefs.setStringList('jobId', _jobs);
    notifyListeners();
  }

  // Fix: Jobs cannot be null
  Future<void> removeJob(String jobId) async {
    final prefs = await SharedPreferences.getInstance();
    _jobs.remove(jobId);
    await prefs.setStringList('jobId', _jobs);
    notifyListeners();
  }

  Future<void> loadJobs() async {
    final prefs = await SharedPreferences.getInstance();
    final jobs = prefs.getStringList('jobId');

    if (jobs != null) {
      _jobs = jobs;
    }
  }

  addBookMark(BookmarkResModel model, String jobId) {
    BookMarkHelper.addBookmarks(model).then((response) {
      if (response[0]) {
        addJob(jobId);
        Get.snackbar(
          'Bookmark successfully added',
          'Please Check your bookmarks',
          colorText: Color(kLight.value),
          backgroundColor: Color(kLightBlue.value),
          icon: const Icon(Icons.bookmark_add),
        );
      } else if (!response[0]) {
        Get.snackbar(
          'Failed to add Bookmarks',
          'Please try again',
          colorText: Color(kLight.value),
          backgroundColor: Colors.red,
          icon: const Icon(Icons.bookmark_add),
        );
      }
    });
  }

  deleteBookMark(String jobId) {
    BookMarkHelper.deleteBookmarks(jobId).then((response) {
      if (response) {
        removeJob(jobId);
        Get.snackbar(
          'Bookmark successfully deleted',
          'Please check your bookmarks',
          colorText: Color(kLight.value),
          backgroundColor: Color(kOrange.value),
          icon: const Icon(Icons.bookmark_remove_outlined),
        );
      } else if (!response) {
        Get.snackbar(
          'Failed to delete Bookmarks',
          'Please try again',
          colorText: Color(kLight.value),
          backgroundColor: Colors.red,
          icon: const Icon(Icons.bookmark_remove_outlined),
        );
      }
    });
  }

  getBookMarks() {
    bookmarks = BookMarkHelper.getBookmarks();
  }
}
