import 'package:freezed_annotation/freezed_annotation.dart';

enum ItemType {
  @JsonValue('plane')
  plane,
  @JsonValue('bag')
  bag,
}
