import 'package:freezed_annotation/freezed_annotation.dart';

part 'index.freezed.dart';

part 'index.g.dart';

@freezed
abstract class Index with _$Index {
  const Index._();

  const factory Index(
    int i,
    int j,
  ) = _Index;

  factory Index.from1D(int i, int size) => Index(i ~/ size, i % size);

  factory Index.fromJson(Map<String, dynamic> json) => _$IndexFromJson(json);
}

extension IndexUtils on Index {
  int as1D(int size) => i * size + j;
}
