import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_2/task_model.dart';
import 'package:http/http.dart' as http;

class HTTPHelper {
  Future<List<String>> fetchProject() async {
    try {
      var dio = Dio();
      var response = await dio.request(
        'https://mobilecrm.erpdata.in/api/resource/Project',
        options: Options(
          method: 'GET',
          headers: {'Authorization': "token c2e4e54edf095c2:e25d998f1e6cfff"},
        ),
      );

      if (response.statusCode == 200) {
        var jsonData = json.encode(response.data);
        Map<String, dynamic> jsonDataMap = json.decode(jsonData);
        List<dynamic> dataList = jsonDataMap["data"];

        List<String> namesList =
            dataList.map((item) => item["name"].toString()).toList();
        return namesList;
      } else {
        Fluttertoast.showToast(msg: "Unable to fetch orders");
        return [];
      }
    } on DioException catch (e) {
      Fluttertoast.showToast(
        gravity: ToastGravity.BOTTOM,
        msg: 'Error: ${e.response!.data["exception"].toString()} ',
        textColor: Color(0xFFFFFFFF),
        backgroundColor: Color(0xFFBA1A1A),
      );

      return [];
    }
  }

  fetchType() async {
    try {
      var dio = Dio();
      var response = await dio.request(
        'https://mobilecrm.erpdata.in/api/resource/Task Type',
        options: Options(
          method: 'GET',
          headers: {'Authorization': "token c2e4e54edf095c2:e25d998f1e6cfff"},
        ),
      );

      if (response.statusCode == 200) {
        var jsonData = json.encode(response.data);
        Map<String, dynamic> jsonDataMap = json.decode(jsonData);
        List<dynamic> dataList = jsonDataMap["data"];

        List<String> namesList =
            dataList.map((item) => item["name"].toString()).toList();
        return namesList;
      } else {
        Fluttertoast.showToast(msg: "Unable to fetch orders");
        return [];
      }
    } on DioException catch (e) {
      Fluttertoast.showToast(
        gravity: ToastGravity.BOTTOM,
        msg: 'Error: ${e.response!.data["exception"].toString()} ',
        textColor: Color(0xFFFFFFFF),
        backgroundColor: Color(0xFFBA1A1A),
      );

      return [];
    }
  }

  fetchParentTask() async {
    try {
      var dio = Dio();
      var response = await dio.request(
        'https://mobilecrm.erpdata.in/api/resource/Task',
        options: Options(
          method: 'GET',
          headers: {'Authorization': "token c2e4e54edf095c2:e25d998f1e6cfff"},
        ),
      );

      if (response.statusCode == 200) {
        var jsonData = json.encode(response.data);
        Map<String, dynamic> jsonDataMap = json.decode(jsonData);
        List<dynamic> dataList = jsonDataMap["data"];

        List<String> namesList =
        dataList.map((item) => item["name"].toString()).toList();
        return namesList;
      } else {
        Fluttertoast.showToast(msg: "Unable to fetch orders");
        return [];
      }
    } on DioException catch (e) {
      Fluttertoast.showToast(
        gravity: ToastGravity.BOTTOM,
        msg: 'Error: ${e.response!.data["exception"].toString()} ',
        textColor: Color(0xFFFFFFFF),
        backgroundColor: Color(0xFFBA1A1A),
      );

      return [];
    }
  }
 Future<List<TaskList>> fetchTaskList() async {
    try {
      var dio = Dio();
      var response = await dio.request(
        'https://mobilecrm.erpdata.in/api/resource/Task?fields=["subject","status","name","priority","exp_end_date"]',
        options: Options(
          method: 'GET',
          headers: {'Authorization': "token c2e4e54edf095c2:e25d998f1e6cfff"},
        ),
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonData = json.decode(json.encode(response.data));
        List<TaskList> caneList = List.from(jsonData['data'])
            .map<TaskList>((data) => TaskList.fromJson(data))
            .toList();
        // Fluttertoast.showToast(msg: jsonData['message']);
        return caneList;
      } else {
        Fluttertoast.showToast(msg: "Unable to fetch orders");
        return [];
      }
    } on DioException catch (e) {
      Fluttertoast.showToast(
        gravity: ToastGravity.BOTTOM,
        msg: 'Error: ${e.response!.data["exception"].toString()} ',
        textColor: Color(0xFFFFFFFF),
        backgroundColor: Color(0xFFBA1A1A),
      );

      return [];
    }
  }



}
