import 'package:faker/faker.dart';
import 'package:flutter/material.dart';

final List<String> titleData = ['Name', 'Status', 'Total'];

final faker = Faker();
final List<Map<String, String>> orderData = List.generate(100, (index) {
  final statuses = ['New', 'Quotation', 'Invoice', 'Paid', 'Cancelled'];
  return {
    'name': faker.person.name(),
    'status': statuses[index % 5],
    'total': (faker.randomGenerator.integer(951, min: 50)).toString(),
  };
});


final List<Map<String, dynamic>> orderStatusMetrics = [
  {
    'icon': Icons.all_inbox,
    'title': 'All',
    'value': '1.2K',
  },
  {
    'icon': Icons.fiber_new,
    'title': 'New',
    'value': '345',
  },
  {
    'icon': Icons.description,
    'title': 'Quotation',
    'value': '120',
  },
  {
    'icon': Icons.receipt_long,
    'title': 'Invoice',
    'value': '312',
  },
  {
    'icon': Icons.payment,
    'title': 'Paid',
    'value': '320',
  },
  {
    'icon': Icons.cancel,
    'title': 'Cancelled',
    'value': '25',
  },
];

