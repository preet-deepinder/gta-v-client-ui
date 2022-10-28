import 'package:flutter_riverpod/flutter_riverpod.dart';

final ncpInteractionProvider = StateNotifierProvider<NpcInteractionStateNotifier, dynamic>((_) => NpcInteractionStateNotifier());

class NpcInteractionStateNotifier extends StateNotifier<dynamic> {
  NpcInteractionStateNotifier() : super(dynamic);

  void onEmit() {}
}
