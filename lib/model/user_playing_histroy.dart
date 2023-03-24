import 'dart:convert';

/// wins : "0"
/// series : "0"
/// contest : 1
/// matchs : 1

UserPlayingHistory userPlayingHistoryFromJson(String str) =>
    UserPlayingHistory.fromJson(json.decode(str));

String userPlayingHistoryToJson(UserPlayingHistory data) =>
    json.encode(data.toJson());

class UserPlayingHistory {
  UserPlayingHistory({
    String? wins,
    String? series,
    num? contest,
    num? matchs,
  }) {
    _wins = wins;
    _series = series;
    _contest = contest;
    _matchs = matchs;
  }

  UserPlayingHistory.fromJson(dynamic json) {
    _wins = json['wins'];
    _series = json['series'];
    _contest = json['contest'];
    _matchs = json['matchs'];
  }

  String? _wins;
  String? _series;
  num? _contest;
  num? _matchs;

  String? get wins => _wins;

  String? get series => _series;

  num? get contest => _contest;

  num? get matchs => _matchs;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['wins'] = _wins;
    map['series'] = _series;
    map['contest'] = _contest;
    map['matchs'] = _matchs;
    return map;
  }
}
