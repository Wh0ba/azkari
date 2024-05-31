import 'dart:convert';
import 'package:azkari/models/holy_name.dart';
import 'package:azkari/models/zikr_subject.dart';
import 'package:flutter/material.dart';

class DataService {
  static final DataService _instance = DataService._internal();

  factory DataService() {
    return _instance;
  }
  List<ZikrSubject> _zikrSubjects = [];
  List<HolyName> _holyNames = [];
  DataService._internal();

  Future<List<ZikrSubject>> getZikrSubjects(BuildContext context) async {
    if (_zikrSubjects.isNotEmpty) {
      return _zikrSubjects;
    }
    try {
      // Read the JSON string from the root bundle
      String jsonString =
          await DefaultAssetBundle.of(context).loadString('assets/adhkar.json');

      // Parse the JSON string into a List of ZikrSubject
      List<dynamic> jsonList = json.decode(jsonString);
      List<ZikrSubject> zikrSubjects = jsonList
          .map((jsonObject) => ZikrSubject.fromJson(jsonObject))
          .toList();
      _zikrSubjects = zikrSubjects;
      return zikrSubjects;
    } catch (e) {
      // Handle exceptions (e.g., file not found, JSON parsing error)
      throw ('خطأ في قراءة البيانات ');
    }
  }

  Future<List<HolyName>> loadAsmaa(BuildContext context) async {
    if (_holyNames.isNotEmpty) {
      return _holyNames;
    }
    try {
      String jsonString =
          await DefaultAssetBundle.of(context).loadString('assets/names.json');
      List<dynamic> jsonList = json.decode(jsonString);
      List<HolyName> holyNames =
          jsonList.map((jsonObject) => HolyName.fromJSON(jsonObject)).toList();
      return holyNames;
    } catch (e) {
      throw ('خطأ في قراءة البيانات ');
    }
  }
}
