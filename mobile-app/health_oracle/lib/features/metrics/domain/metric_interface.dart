import 'package:flutter/material.dart';
import '../../../data/models/health_entry.dart';

abstract class MetricInterface {
  String get title;
  String get description;
  String get unit;
  Gradient get gradient;
  IconData get icon;
  EntryType get entryType;
  
  String formatValue(HealthEntry entry);
  String formatValueShort(HealthEntry entry);
}