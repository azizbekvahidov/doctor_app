import 'dart:convert';

import 'issue.dart';

class PaginatedIssues {
  final bool success;
  final String? message;
  final List<Issue> data;
  final PaginationLinks? links;
  final PaginationMeta? meta;

  PaginatedIssues({
    required this.success,
    this.message,
    required this.data,
    this.links,
    this.meta,
  });

  factory PaginatedIssues.fromRawJson(String str) =>
      PaginatedIssues.fromJson(json.decode(str));

  factory PaginatedIssues.fromJson(Map<String, dynamic> json) {
    return PaginatedIssues(
      success: json['success'] ?? false,
      message: json['message'],
      data:
          (json['data'] as List?)
              ?.map((e) => Issue.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      links: json['links'] != null
          ? PaginationLinks.fromJson(json['links'])
          : null,
      meta: json['meta'] != null ? PaginationMeta.fromJson(json['meta']) : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'success': success,
    'message': message,
    'data': data.map((e) => e.toJson()).toList(),
    'links': links?.toJson(),
    'meta': meta?.toJson(),
  };
}

class PaginationMeta {
  final int currentPage;
  final int? from;
  final int lastPage;
  final int? to;
  final int total;

  PaginationMeta({
    required this.currentPage,
    this.from,
    required this.lastPage,
    this.to,
    required this.total,
  });

  factory PaginationMeta.fromJson(Map<String, dynamic> json) => PaginationMeta(
    currentPage: json['current_page'] ?? 1,
    from: json['from'],
    lastPage: json['last_page'] ?? 1,
    to: json['to'],
    total: json['total'] ?? 0,
  );

  Map<String, dynamic> toJson() => {
    'current_page': currentPage,
    'from': from,
    'last_page': lastPage,
    'to': to,
    'total': total,
  };
}

class PaginationLinks {
  final String? first;
  final String? last;
  final String? next;
  final String? prev;

  PaginationLinks({this.first, this.last, this.next, this.prev});

  factory PaginationLinks.fromJson(Map<String, dynamic> json) =>
      PaginationLinks(
        first: json['first'],
        last: json['last'],
        next: json['next'],
        prev: json['prev'],
      );

  Map<String, dynamic> toJson() => {
    'first': first,
    'last': last,
    'next': next,
    'prev': prev,
  };
}
