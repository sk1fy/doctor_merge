// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stock.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Stock _$StockFromJson(Map<String, dynamic> json) {
  return Stock(
    id: json['_id'] as String,
    imageUrl: json['imageUrl'] as String,
  );
}

Map<String, dynamic> _$StockToJson(Stock instance) => <String, dynamic>{
      'imageUrl': instance.imageUrl,
      '_id': instance.id,
    };
