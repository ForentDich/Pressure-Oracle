import 'package:flutter/material.dart';
import '../../../../core/widgets/bottom_entry_menu.dart';

class AddEntryPage extends StatelessWidget {
  const AddEntryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedNotifier = ValueNotifier<Set<String>>({});

    return DraggableScrollableSheet(
      expand: false,
      builder: (context, scrollController) => BottomEntryMenu(
        selectedNotifier: selectedNotifier,
      ),
    );
  }
}
