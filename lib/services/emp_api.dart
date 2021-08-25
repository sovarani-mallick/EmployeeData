import 'dart:convert';

import 'package:finnovation_z/resources/constants.dart';
import 'package:finnovation_z/screens/employees_modal.dart';
import 'package:http/http.dart' as http;


// ignore: camel_case_types

  Future<Employee> getNews() async {
    var client = http.Client();
    var newsModel;

    try {
      var response = await client.get(Strings.url);
      if (response.statusCode == 200) {
        var jsonString = response.body;
        var jsonMap = json.decode(jsonString);

        newsModel = Employee.fromJson(jsonMap);
      }
    } catch (Exception) {
      return newsModel;
    }

    return newsModel;
  }
