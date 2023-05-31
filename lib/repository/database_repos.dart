import 'package:firebase_database/firebase_database.dart';
import 'package:thuc_tap_chuyen_nganh/helper/date_time_helper.dart';
import 'package:thuc_tap_chuyen_nganh/model/app_user.dart';
import 'package:thuc_tap_chuyen_nganh/model/comment.dart';
import 'package:thuc_tap_chuyen_nganh/repository/auth_repos.dart';
import 'package:thuc_tap_chuyen_nganh/util/app_constants.dart';

import '../model/task.dart';

class DatabaseRepo {
  final FirebaseDatabase _database = FirebaseDatabase.instance;

  DatabaseRepo._();

  static final instance = DatabaseRepo._();

  /// *
  ///  This function is used to save user information
  Future setUserInfo(AppUser appUser) {
    return _database
        .ref()
        .child(AppConstants.APP_USERS_KEY)
        .child(appUser.uid)
        .set(appUser.toMap());
  }

  Future<AppUser?> getUserInfo() async {
    try {
      var appUser = await AuthRepos.instance().getCurrentUser();
      if (appUser == null) {
        return null;
      }
      var snapshot = await _database
          .ref()
          .child(AppConstants.APP_USERS_KEY)
          .child(appUser.uid)
          .get();
      if (snapshot.exists && snapshot.value != null) {
        return AppUser.fromMap(snapshot.value as Map);
      }
      return null;
    } catch (e) {
      print(e);
      return Future.error(e);
    }
  }

  /// *
  ///  This function is used to update new user information
  Future updateUserInfo(String uid, String username) {
    return _database
        .ref()
        .child(AppConstants.APP_USERS_KEY)
        .child(uid)
        .update({AppConstants.USERNAME_KEY: username});
  }

  /// *
  ///  This function is used to add new task to database
  Future setTask(Task task) async {
    var user = await AuthRepos.instance().getCurrentUser();
    if (user == null) {
      return Future.error('You need login to use this function.');
    }
    var userUid = user.uid;
    int todayTimeMillis = DateTimeHelper.getDateFromTimeMillis(task.time);
    return _database
        .ref(AppConstants.TASKS_KEY)
        .child(userUid)
        .child(todayTimeMillis.toString())
        .child(task.id)
        .set(task.toMap());
  }

  /// *
  ///  This function is used to get all task of one day
  ///  use DateTimeHelper.getCurrentDateMillis to get todayInMillis
  Future<List<Task>> getTasksByDate(int dayInMillis) async {
    var user = await AuthRepos.instance().getCurrentUser();
    if (user == null) {
      return Future.error('You need login to use this function.');
    }
    var userUid = user.uid;
    String dateKey =
        DateTimeHelper.getDateFromTimeMillis(dayInMillis).toString();
    var taskList = <Task>[];
    try {
      var snapshots = await _database
          .ref(AppConstants.TASKS_KEY)
          .child(userUid)
          .child(dateKey)
          .get();
      for (var snapshot in snapshots.children) {
        taskList.add(Task.fromMap(snapshot.value as Map));
      }
      return taskList;
    } catch (e) {
      print(e);
      return Future.error(AppConstants.errorOccurred);
    }
  }

  /// *
  ///  This function is used to get information of a task
  ///  dayInMillis is task's created date in millis of time
  Future<Task> getTaskInfo(String taskId, int dayInMillis) async {
    var user = await AuthRepos.instance().getCurrentUser();
    if (user == null) {
      return Future.error('You need login to use this function.');
    }
    var userUid = user.uid;
    String dateKey =
        DateTimeHelper.getDateFromTimeMillis(dayInMillis).toString();
    try {
      var snapshot = await _database
          .ref(AppConstants.TASKS_KEY)
          .child(userUid)
          .child(dateKey)
          .child(taskId)
          .get();
      return Task.fromMap(snapshot.value as Map<String, dynamic>);
    } catch (e) {
      return Future.error(AppConstants.errorOccurred);
    }
  }

  /// *
  ///  This function is used to update a task
  Future updateTask(Task task) async {
    var user = await AuthRepos.instance().getCurrentUser();
    if (user == null) {
      return Future.error('You need login to use this function.');
    }
    var userUid = user.uid;
    int todayTimeMillis = DateTimeHelper.getDateFromTimeMillis(task.time);
    return _database
        .ref(AppConstants.TASKS_KEY)
        .child(userUid)
        .child(todayTimeMillis.toString())
        .child(task.id)
        .update(task.toMap());
  }

  /// *
  ///  This function is used to remove a task
  Future deleteTask(Task task) async {
    var user = await AuthRepos.instance().getCurrentUser();
    if (user == null) {
      return Future.error('You need login to use this function.');
    }
    var userUid = user.uid;
    int todayTimeMillis = DateTimeHelper.getDateFromTimeMillis(task.time);
    return _database
        .ref(AppConstants.TASKS_KEY)
        .child(userUid)
        .child(todayTimeMillis.toString())
        .child(task.id)
        .remove();
  }

  // *
  ///  This function is used to set a new task to database
  Future<void> setTaskComment(Comment comment, String taskId) async {
    var user = await AuthRepos.instance().getCurrentUser();
    if (user == null) {
      return Future.error('You need login to use this function.');
    }
    var userUid = user.uid;
    int todayTimeMillis =
        DateTimeHelper.getDateFromTimeMillis(int.parse(taskId));
    return _database
        .ref(AppConstants.TASKS_KEY)
        .child(userUid)
        .child(todayTimeMillis.toString())
        .child(taskId)
        .child(AppConstants.COMMENTS_KEY)
        .child(comment.id)
        .set(comment.toMap());
  }

  // *
  ///  This function is used to get list of task comment by task id
  Future<List<Comment>> getListTaskComment(String taskId) async {
    var user = await AuthRepos.instance().getCurrentUser();
    if (user == null) {
      return Future.error('You need login to use this function.');
    }
    var userUid = user.uid;
    int todayTimeMillis =
        DateTimeHelper.getDateFromTimeMillis(int.parse(taskId));
    var commentList = <Comment>[];
    try {
      var snapshots = await _database
          .ref(AppConstants.TASKS_KEY)
          .child(userUid)
          .child(todayTimeMillis.toString())
          .child(taskId)
          .child(AppConstants.COMMENTS_KEY)
          .get();
      for (var snapshot in snapshots.children) {
        commentList
            .add(Comment.fromMap(snapshot.value as Map));
      }
      return commentList;
    } catch (e) {
      return Future.error(AppConstants.errorOccurred);
    }
  }

  // *
  ///  This function is used to remove a comment of task
  Future<void> deleteTaskComment(String commentId, String taskId) async {
    var user = await AuthRepos.instance().getCurrentUser();
    if (user == null) {
      return Future.error('You need login to use this function.');
    }
    var userUid = user.uid;
    int todayTimeMillis =
        DateTimeHelper.getDateFromTimeMillis(int.parse(taskId));
    return _database
        .ref(AppConstants.TASKS_KEY)
        .child(userUid)
        .child(todayTimeMillis.toString())
        .child(taskId)
        .child(AppConstants.COMMENTS_KEY)
        .child(commentId)
        .remove();
  }
}
