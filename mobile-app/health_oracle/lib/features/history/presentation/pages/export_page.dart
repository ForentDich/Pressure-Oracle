import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:csv/csv.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:open_file/open_file.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../../data/data.dart';
import '../widgets/export_section.dart';
import '../widgets/export_selector_row.dart';

enum ExportFormat { pdf, csv }

class ExportPage extends StatefulWidget {
  const ExportPage({super.key});

  @override
  State<ExportPage> createState() => _ExportPageState();
}

class _ExportPageState extends State<ExportPage> {
  DateTimeRange? _dateRange;
  ExportFormat _format = ExportFormat.pdf;
  Set<EntryType> _selectedTypes = {}; // пусто = все
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    _dateRange = DateTimeRange(
      start: now.subtract(const Duration(days: 30)),
      end: now,
    );
  }

  String _formatDate(DateTime? date) {
    if (date == null) return '—';
    return DateFormat('dd.MM.yyyy').format(date);
  }

  String _getDateRangeText() {
    if (_dateRange == null) return 'Выберите диапазон';
    return '${_formatDate(_dateRange!.start)} — ${_formatDate(_dateRange!.end)}';
  }

  Future<void> _selectDateRange() async {
    final picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
      initialDateRange: _dateRange,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColors.primary,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        _dateRange = picked;
      });
    }
  }

  void _selectFormat() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: ExportFormat.values.map((format) {
            final isSelected = _format == format;
            return ListTile(
              title: Text(format == ExportFormat.pdf ? 'PDF отчёт' : 'CSV таблица'),
              trailing: isSelected ? const Icon(Icons.check, color: AppColors.primary) : null,
              onTap: () {
                setState(() => _format = format);
                Navigator.pop(ctx);
              },
            );
          }).toList(),
        ),
      ),
    );
  }

  String _getDetailText() {
    if (_selectedTypes.isEmpty) return 'Все измерения';
    final names = _selectedTypes.map((type) {
      switch (type) {
        case EntryType.pressure:
          return 'Давление';
        case EntryType.pulse:
          return 'Пульс';
        case EntryType.weight:
          return 'Вес';
        case EntryType.sugar:
          return 'Сахар';
      }
    }).toList();
    return names.join(', ');
  }

  void _selectDetails() {
    // Временная копия для редактирования
    Set<EntryType> tempSelected = Set.from(_selectedTypes);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) {
        return StatefulBuilder(
          builder: (context, setStateModal) {
            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Container(
                        width: 40,
                        height: 4,
                        decoration: BoxDecoration(
                          color: AppTheme.divider(context),
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Выберите категории',
                      style: TextStyles.titleMedium.copyWith(
                        fontSize: 18,
                        color: AppTheme.textPrimary(context),
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Опция "Все"
                    CheckboxListTile(
                      value: tempSelected.isEmpty,
                      onChanged: (value) {
                        setStateModal(() {
                          if (value == true) {
                            tempSelected.clear();
                          } else {
                            // Если снимаем "Все", то выбираем все категории
                            tempSelected = {
                              EntryType.pressure,
                              EntryType.pulse,
                              EntryType.weight,
                              EntryType.sugar,
                            };
                          }
                        });
                      },
                      title: const Text('Все измерения'),
                      controlAffinity: ListTileControlAffinity.leading,
                      activeColor: AppColors.primary,
                    ),
                    const Divider(),
                    // Список категорий
                    ...EntryType.values.map((type) {
                      final label = _typeName(type);
                      return CheckboxListTile(
                        value: tempSelected.contains(type),
                        onChanged: (value) {
                          setStateModal(() {
                            if (value == true) {
                              tempSelected.add(type);
                            } else {
                              tempSelected.remove(type);
                            }
                          });
                        },
                        title: Text(label),
                        controlAffinity: ListTileControlAffinity.leading,
                        activeColor: AppColors.primary,
                      );
                    }).toList(),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () => Navigator.pop(ctx),
                            child: const Text('Отмена'),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              // Применяем выбор
                              setState(() {
                                _selectedTypes = tempSelected;
                              });
                              Navigator.pop(ctx);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary,
                              foregroundColor: Colors.white,
                            ),
                            child: const Text('Применить'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  String _typeName(EntryType type) {
    switch (type) {
      case EntryType.pressure:
        return 'Давление';
      case EntryType.pulse:
        return 'Пульс';
      case EntryType.weight:
        return 'Вес';
      case EntryType.sugar:
        return 'Сахар';
    }
  }

  // === Запрос разрешений с учётом версии Android ===
  Future<bool> _requestStoragePermission() async {
    if (!Platform.isAndroid) return true;

    final androidInfo = await DeviceInfoPlugin().androidInfo;
    final sdkInt = androidInfo.version.sdkInt;

    if (sdkInt >= 30) {
      var status = await Permission.manageExternalStorage.status;
      if (status.isGranted) return true;

      status = await Permission.manageExternalStorage.request();
      if (status.isGranted) return true;

      if (status.isPermanentlyDenied) {
        if (mounted) {
          final openSettings = await showDialog<bool>(
            context: context,
            builder: (ctx) => AlertDialog(
              title: const Text('Требуется разрешение'),
              content: const Text(
                'Для сохранения файлов в папку Downloads необходимо разрешение '
                'на управление всеми файлами. Пожалуйста, включите его в настройках.',
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(ctx, false),
                  child: const Text('Отмена'),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(ctx, true),
                  child: const Text('Открыть настройки'),
                ),
              ],
            ),
          );
          if (openSettings == true) {
            await openAppSettings();
          }
        }
        return false;
      }
      return false;
    }

    final status = await Permission.storage.request();
    return status.isGranted;
  }

  // === Получение папки Downloads ===
  Future<Directory?> _getDownloadsDirectory() async {
    if (!Platform.isAndroid) {
      return await getDownloadsDirectory();
    }

    final paths = [
      '/storage/emulated/0/Download',
      '/sdcard/Download',
    ];

    for (final path in paths) {
      final dir = Directory(path);
      if (await dir.exists()) {
        return dir;
      }
    }

    final externalDir = await getExternalStorageDirectory();
    if (externalDir != null) {
      final downloadsPath = '${externalDir.path.split('/Android').first}/Download';
      final downloadsDir = Directory(downloadsPath);
      if (await downloadsDir.exists()) {
        return downloadsDir;
      }
    }

    return null;
  }

  // === Генерация CSV ===
  Future<File> _generateCsv(List<HealthEntry> entries, Directory dir) async {
    final rows = <List<String>>[];
    rows.add(['Дата', 'Время', 'Тип', 'Значение', 'Примечание']);

    for (final entry in entries) {
      final date = DateFormat('dd.MM.yyyy').format(entry.createdAt);
      final time = DateFormat('HH:mm').format(entry.createdAt);
      final typeName = entry.typeName(context);
      final value = entry.displayValue;
      final note = entry.note ?? '';
      rows.add([date, time, typeName, value, note]);
    }

    final csv = const ListToCsvConverter().convert(rows);
    final filename = 'health_export_${DateFormat('yyyyMMdd_HHmmss').format(DateTime.now())}.csv';
    final file = File('${dir.path}/$filename');
    await file.writeAsString(csv, flush: true);
    return file;
  }

  // === Генерация PDF с поддержкой кириллицы ===
  Future<File> _generatePdf(List<HealthEntry> entries, Directory dir) async {
    final fontData = await rootBundle.load('assets/fonts/Roboto-Regular.ttf');
    final font = pw.Font.ttf(fontData);
    final theme = pw.ThemeData.withFont(base: font);

    final pdf = pw.Document(theme: theme);

    final headers = ['Дата', 'Время', 'Тип', 'Значение', 'Примечание'];
    final rows = <List<String>>[];
    for (final entry in entries) {
      final date = DateFormat('dd.MM.yyyy').format(entry.createdAt);
      final time = DateFormat('HH:mm').format(entry.createdAt);
      final typeName = entry.typeName(context);
      final value = entry.displayValue;
      final note = entry.note ?? '';
      rows.add([date, time, typeName, value, note]);
    }

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(20),
        build: (pw.Context context) {
          return [
            pw.Center(
              child: pw.Text(
                'Экспорт данных Health Oracle',
                style: pw.TextStyle(
                  fontSize: 24,
                  fontWeight: pw.FontWeight.bold,
                  fontFallback: [font],
                ),
              ),
            ),
            pw.SizedBox(height: 20),
            pw.Text(
              'Период: ${_formatDate(_dateRange?.start)} — ${_formatDate(_dateRange?.end)}',
              style: pw.TextStyle(fontSize: 14, fontFallback: [font]),
            ),
            pw.SizedBox(height: 20),
            pw.Table.fromTextArray(
              headers: headers,
              data: rows,
              border: pw.TableBorder.all(),
              headerStyle: pw.TextStyle(
                fontWeight: pw.FontWeight.bold,
                fontFallback: [font],
              ),
              headerDecoration: const pw.BoxDecoration(color: PdfColors.grey300),
              cellHeight: 30,
              cellAlignment: pw.Alignment.centerLeft,
              cellStyle: pw.TextStyle(fontFallback: [font]),
            ),
            pw.SizedBox(height: 20),
            pw.Text(
              'Сгенерировано: ${DateFormat('dd.MM.yyyy HH:mm').format(DateTime.now())}',
              style: pw.TextStyle(fontSize: 10, color: PdfColors.grey600, fontFallback: [font]),
            ),
          ];
        },
      ),
    );

    final filename = 'health_export_${DateFormat('yyyyMMdd_HHmmss').format(DateTime.now())}.pdf';
    final file = File('${dir.path}/$filename');
    await file.writeAsBytes(await pdf.save());
    return file;
  }

  // === Основная функция экспорта ===
  Future<void> _export() async {
    if (_dateRange == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Пожалуйста, выберите диапазон дат')),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      final hasPermission = await _requestStoragePermission();
      if (!hasPermission) {
        setState(() => _isLoading = false);
        return;
      }

      final allEntries = EntryService.getByDateRange(
        _dateRange!.start,
        _dateRange!.end,
      );

      // Фильтрация по выбранным типам
      List<HealthEntry> filteredEntries;
      if (_selectedTypes.isEmpty) {
        filteredEntries = allEntries;
      } else {
        filteredEntries = allEntries.where((e) => _selectedTypes.contains(e.type)).toList();
      }

      if (filteredEntries.isEmpty) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Нет данных за выбранный период с такой детализацией')),
          );
        }
        setState(() => _isLoading = false);
        return;
      }

      final dir = await _getDownloadsDirectory();
      if (dir == null) {
        throw Exception('Не удалось получить доступ к папке Downloads');
      }

      File file;
      if (_format == ExportFormat.csv) {
        file = await _generateCsv(filteredEntries, dir);
      } else {
        file = await _generatePdf(filteredEntries, dir);
      }

      if (await file.exists()) {
        if (mounted) {
          final customSnackBar = SnackBar(
            content: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('✅ Сохранено в Загрузки'),
                      Text(
                        file.path.split('/').last,
                        style: const TextStyle(fontSize: 10, color: Colors.white70),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    TextButton(
                      onPressed: () {
                        Share.shareXFiles([XFile(file.path)]);
                        ScaffoldMessenger.of(context).hideCurrentSnackBar();
                      },
                      style: TextButton.styleFrom(foregroundColor: Colors.white),
                      child: const Text('Поделиться'),
                    ),
                    const SizedBox(width: 8),
                    TextButton(
                      onPressed: () {
                        OpenFile.open(file.path);
                        ScaffoldMessenger.of(context).hideCurrentSnackBar();
                      },
                      style: TextButton.styleFrom(foregroundColor: Colors.white),
                      child: const Text('Открыть'),
                    ),
                  ],
                ),
              ],
            ),
            duration: const Duration(seconds: 10),
          );
          ScaffoldMessenger.of(context).showSnackBar(customSnackBar);
        }
      } else {
        throw Exception('Файл не был создан');
      }
    } catch (e) {
      print('❌ Export error: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Ошибка экспорта: $e'),
            backgroundColor: AppColors.error500,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.35,
            decoration: const BoxDecoration(
              gradient: AppColors.purpleGradient,
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 8, 20, 24),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () => Navigator.of(context).pop(),
                        icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'Экспорт истории',
                        style: TextStyles.headlineLarge.copyWith(
                          color: Colors.white,
                          fontSize: 24,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppTheme.surface(context),
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(30),
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(30),
                      ),
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.fromLTRB(20, 24, 20, 24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ExportSection(
                              title: 'Диапазон дат',
                              child: Column(
                                children: [
                                  ExportSelectorRow(
                                    icon: Icons.calendar_today_outlined,
                                    label: 'Диапазон',
                                    value: _getDateRangeText(),
                                    onTap: _selectDateRange,
                                  ),
                                  const SizedBox(height: 8),
                                ],
                              ),
                            ),
                            const SizedBox(height: 20),

                            ExportSection(
                              title: 'Формат и содержимое',
                              child: Column(
                                children: [
                                  ExportSelectorRow(
                                    icon: Icons.description_outlined,
                                    label: 'Формат файла',
                                    value: _format == ExportFormat.pdf ? 'PDF отчёт' : 'CSV таблица',
                                    onTap: _selectFormat,
                                  ),
                                  const SizedBox(height: 8),
                                  ExportSelectorRow(
                                    icon: Icons.list_alt_outlined,
                                    label: 'Детализация',
                                    value: _getDetailText(),
                                    onTap: _selectDetails,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 32),

                            Row(
                              children: [
                                Expanded(
                                  child: OutlinedButton(
                                    onPressed: () => Navigator.of(context).pop(),
                                    style: OutlinedButton.styleFrom(
                                      foregroundColor: AppColors.neutral700,
                                      side: BorderSide(color: AppTheme.border(context)),
                                      padding: const EdgeInsets.symmetric(vertical: 16),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                    ),
                                    child: const Text('Отмена'),
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      gradient: AppColors.purpleGradient,
                                      borderRadius: BorderRadius.circular(16),
                                      boxShadow: [
                                        BoxShadow(
                                          color: const Color(0xFF8E2DE2).withValues(alpha: 0.3),
                                          blurRadius: 12,
                                          offset: const Offset(0, 6),
                                        ),
                                      ],
                                    ),
                                    child: ElevatedButton(
                                      onPressed: _isLoading ? null : _export,
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.transparent,
                                        shadowColor: Colors.transparent,
                                        foregroundColor: Colors.white,
                                        padding: const EdgeInsets.symmetric(vertical: 16),
                                        elevation: 0,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(16),
                                        ),
                                      ),
                                      child: _isLoading
                                          ? const SizedBox(
                                              height: 24,
                                              width: 24,
                                              child: CircularProgressIndicator(
                                                strokeWidth: 2,
                                                color: Colors.white,
                                              ),
                                            )
                                          : const Text(
                                              'Экспортировать',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                              ),
                                            ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}