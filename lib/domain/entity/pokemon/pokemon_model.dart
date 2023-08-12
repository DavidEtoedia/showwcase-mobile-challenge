import 'dart:convert';

import 'package:equatable/equatable.dart';

Pokemon pokemonFromJson(String str) => Pokemon.fromJson(json.decode(str));

class Pokemon {
  int? count;
  String? next;
  String? previous;
  List<Result>? results;

  Pokemon({
    this.count,
    this.next,
    this.previous,
    this.results,
  });

  factory Pokemon.fromJson(Map<String, dynamic> json) => Pokemon(
        count: json["count"],
        next: json["next"],
        previous: json["previous"],
        results: json["results"] == null
            ? []
            : List<Result>.from(
                json["results"]!.map((x) => Result.fromJson(x))),
      );
}

class Result extends Equatable {
  final String name;
  final String url;
  final bool isLike;

  const Result({required this.name, required this.url, this.isLike = false});

  @override
  List<Object?> get props => [name, url, isLike];

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        name: json["name"],
        url: json["url"],
      );
}
