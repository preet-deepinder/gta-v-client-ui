import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final phoneController = ChangeNotifierProvider.autoDispose<PhoneController>(
  (_) => PhoneController(),
);

class PhoneController extends ChangeNotifier {
  void onChanged(String value) {
    if (value.length == 3) {}
  }
}
