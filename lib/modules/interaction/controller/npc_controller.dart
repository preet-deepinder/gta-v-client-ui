import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:html_test/data/injectors/sender_injection.dart';

final npcInteractionProvider = ChangeNotifierProvider<NpcChangeProvider>((ref) {
  return NpcChangeProvider();
});

class NpcChangeProvider extends ChangeNotifier {
  final ScrollController _gridController = ScrollController();

  double get _currentPosition => _gridController.offset;
  ScrollController get gridController => _gridController;

  void onUpButton() {
    if (_currentPosition >= _gridController.position.minScrollExtent) {
      _gridController.animateTo(_currentPosition - 100, duration: const Duration(milliseconds: 200), curve: Curves.ease);
    }
  }

  void onDownButton() {
    if (_currentPosition <= _gridController.position.maxScrollExtent) {
      _gridController.animateTo(_currentPosition + 100, duration: const Duration(milliseconds: 200), curve: Curves.ease);
    }
  }
}
