// To parse this JSON data, do
//
//     final dataModel = dataModelFromJson(jsonString);

import 'dart:convert';

DataModel dataModelFromJson(String str) => DataModel.fromJson(json.decode(str));

String dataModelToJson(DataModel data) => json.encode(data.toJson());

class DataModel {
  DataModel({
    this.channel,
    this.feeds,
  });

  Channel channel;
  List<Feed> feeds;

  factory DataModel.fromJson(Map<String, dynamic> json) => DataModel(
        channel: Channel.fromJson(json["channel"]),
        feeds: List<Feed>.from(json["feeds"].map((x) => Feed.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "channel": channel.toJson(),
        "feeds": List<dynamic>.from(feeds.map((x) => x.toJson())),
      };
}

//field 1 = temp
//field 2 = Humidity
//field 3 = Light
//field 4 = Soil Moisture

class Channel {
  Channel({
    this.id,
    this.name,
    this.latitude,
    this.longitude,
    this.field1,
    this.field2,
    this.field3,
    this.field4,
    this.createdAt,
    this.updatedAt,
    this.lastEntryId,
  });

  int id;
  String name;
  String latitude;
  String longitude;
  String field1;
  String field2;
  String field3;
  String field4;
  DateTime createdAt;
  DateTime updatedAt;
  int lastEntryId;

  factory Channel.fromJson(Map<String, dynamic> json) => Channel(
        id: json["id"],
        name: json["name"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        field1: json["field1"],
        field2: json["field2"],
        field3: json["field3"],
        field4: json["field4"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        lastEntryId: json["last_entry_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "latitude": latitude,
        "longitude": longitude,
        "field1": field1,
        "field2": field2,
        "field3": field3,
        "field4": field4,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "last_entry_id": lastEntryId,
      };
}

class Feed {
  Feed({
    this.createdAt,
    this.entryId,
    this.field1,
    this.field2,
    this.field3,
    this.field4,
  });

  DateTime createdAt;
  int entryId;
  String field1;
  String field2;
  String field3;
  String field4;

  factory Feed.fromJson(Map<String, dynamic> json) => Feed(
        createdAt: DateTime.parse(json["created_at"]),
        entryId: json["entry_id"],
        field1: json["field1"],
        field2: json["field2"] == null ? null : json["field2"],
        field3: json["field3"] == null ? null : json["field3"],
        field4: json["field4"] == null ? null : json["field4"],
      );

  Map<String, dynamic> toJson() => {
        "created_at": createdAt.toIso8601String(),
        "entry_id": entryId,
        "field1": field1,
        "field2": field2 == null ? null : field2,
        "field3": field3 == null ? null : field3,
        "field4": field4 == null ? null : field4,
      };
}
