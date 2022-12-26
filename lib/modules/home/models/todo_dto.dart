import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class TodoDTO {
  final String id;
  final String title;
  final String description;
  final Timestamp timestamp;

  TodoDTO({
    this.id = "",
    this.title = "",
    this.description = "",
    required this.timestamp,
  });

  TodoDTO copyWith({
    String? id,
    String? title,
    String? description,
    Timestamp? timestamp,
  }) {
    return TodoDTO(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      timestamp: timestamp ?? this.timestamp,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'timestamp': timestamp,
    };
  }

  factory TodoDTO.fromMap(Map<String, dynamic> map) {
    return TodoDTO(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      timestamp: map['timestamp'] ?? Timestamp.now(),
    );
  }

  String toJson() => json.encode(toMap());

  factory TodoDTO.fromJson(String source) =>
      TodoDTO.fromMap(json.decode(source));

  @override
  String toString() {
    return 'TodoDTO(id: $id, title: $title, description: $description, timestamp: $timestamp)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TodoDTO &&
        other.id == id &&
        other.title == title &&
        other.description == description &&
        other.timestamp == timestamp;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        description.hashCode ^
        timestamp.hashCode;
  }
}
