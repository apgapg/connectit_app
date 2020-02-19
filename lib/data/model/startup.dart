import 'package:freezed_annotation/freezed_annotation.dart';

part 'startup.freezed.dart';
part 'startup.g.dart';

@freezed
abstract class Startup with _$Startup {
  factory Startup({
    String name,
    String tagline,
    String description,
    String avatar,
    @JsonKey(defaultValue: false) bool isVerified,
    bool isTrending,
    bool isUpcoming,
    bool isNew,
    List founders,
    String facebook,
    String linkedIn,
    String website,
  }) = _Startup;

  factory Startup.fromJson(Map<String, dynamic> json) => _$StartupFromJson(json);
}
