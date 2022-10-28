import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:html_test/data/injectors/receiver_injection.dart';
import 'package:html_test/data/injectors/sender_injection.dart';

class GarageEnterence extends StatefulWidget {
  const GarageEnterence({Key? key}) : super(key: key);

  @override
  State<GarageEnterence> createState() => _GarageEnterenceState();
}

class _GarageEnterenceState extends State<GarageEnterence> {
  bool _res = false;
  String? _text;
  double opp = 0.0;

  @override
  void initState() {
    super.initState();

    if (kReleaseMode) {
      altOn('POINT_LOCAL', (vald) {
        setState(() {
          _res = vald != null;
          _text = vald;
        });
      });
    }

    // altOnClient(
    //   'POINT_FOCAL',
    //   (d) {
    //     debugPrint('dasffasfasf: $d');
    //   },
    // );
  }

  @override
  Widget build(BuildContext context) {
    return !_res
        ? const SizedBox()
        : Center(
            child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                _text.toString(),
                style: const TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              TextButton(
                  onPressed: () {
                    setState(() {
                      opp = 20.0;
                    });
                    emit('ACTION', 'gaggi sent to local');
                  },
                  child: const Text(
                    "Ok",
                    style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
                  ))
            ],
          ));
  }
}
