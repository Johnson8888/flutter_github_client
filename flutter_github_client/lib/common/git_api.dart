import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../index.dart';

class Git {
  Git([this.context]) {
    _options = Options(extra: {"context": context});
  }
  BuildContext context;
  Options _options;
  static Dio dio = new Dio(BaseOptions(
    baseUrl: "https://api.github.com/",
    headers: {
      HttpHeaders.acceptHeader: "application/vnd.github.squirrel-girl-preview,"
          "application/vnd.github.symmetra-preview+json",
    },
  ));
  static void init() {
    dio.interceptors.add(Global.netCache);
  }
}
