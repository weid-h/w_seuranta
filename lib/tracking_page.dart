import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:w_seuranta/app_state.dart';
import 'package:http/http.dart' as http;

import 'models/matkahuolto.dart';

class TrackingPage extends StatelessWidget {
  const TrackingPage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(title)),
        body: Center(child: TrackingItemsContainer()));
  }
}

class TrackingItemsContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Expanded(
          flex: 1,
          child: Container(
            child: Column(
              children: [
                Consumer<AppState>(builder: (context, model, child) {
                  return Column(
                      children: model.trackingItems
                          .map((e) => TrackingItemWidget(item: e))
                          .toList());
                })
              ],
            ),
            padding: const EdgeInsets.all(10),
          ))
    ]);
  }
}

class TrackingItemWidget extends StatelessWidget {
  TrackingItemWidget({Key? key, required this.item}) : super(key: key) {
    trackingData = fetchStatus(item.identifier);
  }

  final TrackingItem item;

  late Future<MatkahuoltoTrackingResponse> trackingData;

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Expanded(
          flex: 1,
          child: Container(
              child: Card(
                  child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    title: Text(item.name == null
                        ? "${item.provider.toString().split('.')[1]} ${item.identifier}"
                        : "${item.name}"),
                    subtitle: FutureBuilder<MatkahuoltoTrackingResponse>(
                        future: trackingData,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Text(snapshot
                                .data!.trackingEvents.first.description);
                          } else if (snapshot.hasError) {
                            return Text("${snapshot.error}");
                          }
                          return const CircularProgressIndicator();
                        }),
                  ),
                ],
              )),
              padding: const EdgeInsets.only(bottom: 15)))
    ]);
  }
}

Future<MatkahuoltoTrackingResponse> fetchStatus(String identifier) async {
  final response = await http.get(Uri.parse(
      "https://wwwservice.matkahuolto.fi/search/trackingInfo?language=fi&parcelNumber=$identifier"));
  if (response.statusCode == 200) {
    return MatkahuoltoTrackingResponse.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load tracking data');
  }
}
