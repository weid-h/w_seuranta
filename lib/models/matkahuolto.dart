class MatkahuoltoTrackingResponse {
  final String parcelNumber;
  final String departureStation;
  final String productCategory;
  final List<MatkahuoltoTrackingEvent> trackingEvents;

  MatkahuoltoTrackingResponse(
      {required this.parcelNumber,
      required this.departureStation,
      required this.productCategory,
      required this.trackingEvents});

  MatkahuoltoTrackingResponse.fromJson(Map<String, dynamic> json)
      : parcelNumber = json['parcelNumber'],
        departureStation = json['departureStation'],
        productCategory = json['productCategory'],
        trackingEvents = (json['trackingEvents'] as List<dynamic>)
            .map((e) => MatkahuoltoTrackingEvent.fromJson(e))
            .toList();
}

class MatkahuoltoTrackingEvent {
  final String time;
  final String description;
  final String date;
  final String? place;

  MatkahuoltoTrackingEvent(
      {required this.time,
      required this.description,
      required this.date,
      required this.place});

  MatkahuoltoTrackingEvent.fromJson(Map<String, dynamic> json)
      : time = json['time'],
        description = json['description'],
        date = json['date'],
        place = json['place'];
}
