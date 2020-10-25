import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task/models/task_model.dart';
import 'package:task/views/home_screen.dart';

const String apiurl = 'http://itsm-api.bangkokair.pg/api';
const String weburl = 'http://itsm.bangkokair.pg/api';
const String token =
    'CfDJ8JVHmcnwqN9NhqebjBA9F9DOm0dtYZueMTvdWEQoCmuRjq1R_6zVvq4BzRjyThy-Mdw__JgnaKZBEK7ypbPgOT9OfGSJ69AgdYK-Ra1rba64KCp8z4IjIkB2GL2m9G3dQXcU-3vlg_sKuE5t9OAO34Y';

Future<bool> authenLoginApi(
    BuildContext context, String username, String password) async {
  String token =
      'CfDJ8JVHmcnwqN9NhqebjBA9F9DOm0dtYZueMTvdWEQoCmuRjq1R_6zVvq4BzRjyThy-Mdw__JgnaKZBEK7ypbPgOT9OfGSJ69AgdYK-Ra1rba64KCp8z4IjIkB2GL2m9G3dQXcU-3vlg_sKuE5t9OAO34Y';
  String callurl = apiurl + '/TokenAuth/Authenticate';

  print(callurl);

  try {
    Response response = await Dio().post(
      callurl,
      data: {
        "usernameOrEmailAddress": username,
        "password": password,
        "returnUrlHash": '',
        "returnUrl": "/App",
        "__RequestVerificationToken": token,
      },
      options: Options(
        method: 'POST',
        contentType: 'application/json;charset=utf-8',
      ),
    );

    final body = json.decode(response.toString());
    final result = body['result'];

    if (result == '') {
      Get.snackbar(
        'Error',
        'no result',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent,
      );
      return false;
    }
    final accessToken = result['accessToken'];
    final userId = result['userId'];

    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('username', username);
    preferences.setString('token', accessToken);
    preferences.setString('userId', userId.toString());
    Get.to(HomeScreen());

    return true;
  } catch (e) {
    print(e);
    Get.snackbar(
      'Error',
      e.toString(),
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.redAccent,
    );
    return false;
  }
}

Future<Result> apiLoadTask(String accessToken, String assignId, String statusId,
    String categoryId, String subCategoryId, String display) async {
  String callurl = weburl +
      '/services/app/Task/GetTaskForListPage?assignedToUserId=$assignId&keyword=&runningNumber=&type=ALL&maxResultCount=$display&skipCount=0&statusId=$statusId&categoryValueId=$categoryId&subCategoryValueId=$subCategoryId&categoryValueId=&token=$accessToken';

  // print(callurl);

  try {
    Response response = await Dio().get(callurl);

    final body = json.decode(response.toString());
    Result resultModel = Result.fromJson(body['result']);
    print('apiLoadTask total: ${resultModel.items.length}');

    return resultModel;
  } catch (e) {
    print(e);
    Get.snackbar(
      'Error',
      e.toString(),
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.redAccent,
    );
    return null;
  }
}
