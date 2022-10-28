import 'dart:js';

void altOn(String event, void Function(dynamic d) func) {
  print('Event Name: $event');
  context['alt'].callMethod('on', [event, func]);
}

void altOnList(String event, void Function(List<String> d) func) {
  print('Event Name: $event');
  context['alt'].callMethod('on', [event, func]);
}

void altOnClient(String event, void Function(dynamic d) func) {
  print('Event Name: $event');
  context['alt'].callMethod('onClient', [event, func]);
}
