import 'package:freezed_annotation/freezed_annotation.dart';

enum ItemType {
  @JsonValue('plane')
  plane,
  @JsonValue('bag')
  bag,
  @JsonValue('shield')
  shield,
  @JsonValue('auto')
  auto,
  @JsonValue('diamond')
  diamond,
}
