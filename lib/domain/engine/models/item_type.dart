import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../app/assets/item_assets.dart';

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

extension ItemTypeAssets on ItemType {
  String get asset {
    switch (this) {
      case ItemType.plane:
        return ItemAssets.plane;
      case ItemType.bag:
        return ItemAssets.bag;
      case ItemType.shield:
        return ItemAssets.shield;
      case ItemType.auto:
        return ItemAssets.auto;
      case ItemType.diamond:
        return ItemAssets.diamond;
    }
  }
}
