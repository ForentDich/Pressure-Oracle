import 'package:hive_flutter/hive_flutter.dart';
import 'package:uuid/uuid.dart';
import '../models/health_entry.dart';


class EntryService {
  static const String _boxName = 'health_entries';
  static Box<HealthEntry>? _box;
  static const _uuid = Uuid();


  static Future<void> init() async {
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(EntryTypeAdapter());
    }
    if (!Hive.isAdapterRegistered(2)) {
      Hive.registerAdapter(HealthEntryAdapter());
    }

    _box = await Hive.openBox<HealthEntry>(_boxName);
  }


  static List<HealthEntry> getAll() {
    return _box?.values.toList() ?? [];
  }


  static List<HealthEntry> getByType(EntryType type) {
    return _box?.values.where((e) => e.type == type).toList() ?? [];
  }


  static HealthEntry? getLastByType(EntryType type) {
    final entries = getByType(type);
    if (entries.isEmpty) return null;
    entries.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    return entries.first;
  }


  static List<HealthEntry> getByDateRange(DateTime start, DateTime end) {
    return _box?.values
            .where((e) => e.createdAt.isAfter(start) && e.createdAt.isBefore(end))
            .toList() ??
        [];
  }

  static List<HealthEntry> getByTypeAndDateRange(EntryType type, DateTime start, DateTime end) {
    final entries = _box?.values
            .where((e) => 
                e.type == type && 
                (e.createdAt.isAfter(start) || e.createdAt.isAtSameMomentAs(start)) && 
                (e.createdAt.isBefore(end) || e.createdAt.isAtSameMomentAs(end)))
            .toList() ?? [];
    entries.sort((a, b) => a.createdAt.compareTo(b.createdAt));
    return entries;
  }


  static Future<HealthEntry> add({
    required EntryType type,
    required double value,
    double? secondaryValue,
    String? note,
    DateTime? createdAt,
  }) async {
    if (_box == null) {
      throw Exception('EntryService not initialized. Call init() first.');
    }
    
    final entry = HealthEntry(
      id: _uuid.v4(),
      type: type,
      createdAt: createdAt ?? DateTime.now(),
      value: value,
      secondaryValue: secondaryValue,
      note: note,
    );

    await _box!.put(entry.id, entry);
    print('EntryService: Added entry ${entry.id}, type: ${entry.type}, value: ${entry.value}');
    return entry;
  }

  static Future<void> update(HealthEntry entry) async {
    await _box?.put(entry.id, entry);
  }


  static Future<void> delete(String id) async {
    await _box?.delete(id);
  }

  static Future<void> deleteAll() async {
    await _box?.clear();
  }

  static int get count => _box?.length ?? 0;

  static Stream<BoxEvent>? watch() {
    return _box?.watch();
  }
}
