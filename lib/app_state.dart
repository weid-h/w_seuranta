import 'dart:collection';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:w_seuranta/models/matkahuolto.dart';
import 'package:http/http.dart' as http;

enum TrackingItemProvider { Matkahuolto, Posti }

class TrackingItem {
  TrackingItem(this.identifier, this.provider);

  TrackingItem.withName(this.identifier, this.provider, this.name);

  String identifier;
  TrackingItemProvider provider;
  String? name;
}

class AppState extends ChangeNotifier {
  List<TrackingItem> trackingItems = [
    TrackingItem("373325383432128933", TrackingItemProvider.Matkahuolto),
    TrackingItem.withName(
        "373325383433187120", TrackingItemProvider.Matkahuolto, "Kello")
  ];
}
