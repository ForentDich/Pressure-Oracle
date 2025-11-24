import 'package:flutter/material.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/text_styles.dart';

class HistoryFilters extends StatefulWidget {
  final Function(String) onFilterChanged;

  const HistoryFilters({
    super.key,
    required this.onFilterChanged,
  });

  @override
  State<HistoryFilters> createState() => _HistoryFiltersState();
}

class _HistoryFiltersState extends State<HistoryFilters> {
  final Set<String> _selectedFilters = {};

  final Map<String, IconData> _filters = {
    'Давление': Icons.favorite_border,
    'Пульс': Icons.monitor_heart_outlined,
    'Вес': Icons.monitor_weight_outlined,
    'Сахар': Icons.water_drop_outlined,
  };

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 8,
      crossAxisSpacing: 8,
      childAspectRatio: 3.5,
      children: _filters.entries.map((entry) {
        final filter = entry.key;
        final icon = entry.value;
        final isSelected = _selectedFilters.contains(filter);

        return Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              setState(() {
                if (isSelected) {
                  _selectedFilters.remove(filter);
                } else {
                  _selectedFilters.add(filter);
                }
              });
              widget.onFilterChanged(_selectedFilters.join(','));
            },
            borderRadius: BorderRadius.circular(16),
            child: Container(
              decoration: BoxDecoration(
                color: isSelected ? AppColors.primary : Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: isSelected ? AppColors.primary : AppColors.neutral200,
                ),
              ),
              alignment: Alignment.center,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    icon,
                    size: 18,
                    color: isSelected ? Colors.white : AppColors.neutral600,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    filter,
                    style: TextStyles.bodyMedium.copyWith(
                      color: isSelected ? Colors.white : AppColors.neutral600,
                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
