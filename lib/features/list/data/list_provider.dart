import 'package:flutter/foundation.dart';

class ListProvider with ChangeNotifier, DiagnosticableTreeMixin {
  bool _addModalOpen = false;
  bool get isAddModalOpen => _addModalOpen;

  void openAddModal() {
    _addModalOpen = true;
    notifyListeners();
  }

  /// Makes `ListProvider` readable inside the devtools by listing all of its properties
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(FlagProperty('isAddModalOpen', value: isAddModalOpen));
  }
}