import 'package:json_annotation/json_annotation.dart';
part 'stock.g.dart';

@JsonSerializable()
class Stock {
  String imageUrl;

  @JsonKey(name: "_id")
  final String id;

  Stock({this.id, this.imageUrl});

  factory Stock.rand() {
    return Stock(
        id: "3412",
        imageUrl:
            "https://raw.githubusercontent.com/flutter/website/master/examples/layout/lakes/step5/images/lake.jpg");
  }

  factory Stock.fromJson(Map<String, dynamic> data) => _$StockFromJson(data);

  Map<String, dynamic> toJson() => _$StockToJson(this);
}
