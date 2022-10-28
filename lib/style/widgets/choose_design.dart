import 'package:flutter/material.dart';
import 'package:html_test/style/dimensions.dart';
import 'package:html_test/style/widgets/text_view.dart';

import '../palette.dart';
import 'buttons.dart';

class ChooseListTile extends StatefulWidget {
  final String? label;
  final bool? showCounter;
  final List<String>? list, list2;
  final void Function(int i)? onChanged2;
  final void Function(int i)? onChanged;

  const ChooseListTile({
    super.key,
    this.label,
    this.list,
    this.onChanged2,
    this.onChanged,
    this.showCounter = true,
    this.list2,
  });

  @override
  State<ChooseListTile> createState() => _ChooseListTileState();
}

class _ChooseListTileState extends State<ChooseListTile> {
  int _listIndex = 0;
  int _listIndex2 = 0;
  int size = 0;
  int size2 = 0;

  @override
  void initState() {
    super.initState();
    size = widget.list?.length ?? 0;
    size2 = widget.list2?.length ?? 0;
  }

  void onNext() {
    debugPrint('_listIndex: $_listIndex');
    if (_listIndex < size - 1) {
      _listIndex++;
      setState(() {});
      (widget.onChanged ?? () {})(_listIndex);
    }
  }

  void onPrev() {
    debugPrint('_listIndex: $_listIndex');
    if (_listIndex > 0) {
      _listIndex--;
      setState(() {});
      (widget.onChanged ?? () {})(_listIndex);
    }
  }

  void onNext2() {
    debugPrint('_list2Index: $_listIndex2');
    if (_listIndex2 < size2 - 1) {
      _listIndex2++;
      setState(() {});
      (widget.onChanged2 ?? () {})(_listIndex2);
    }
  }

  void onPrev2() {
    debugPrint('_list2Index: $_listIndex2');
    if (_listIndex2 > 0) {
      _listIndex2--;
      setState(() {});
      (widget.onChanged2 ?? () {})(_listIndex2);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Material(
        color: Palette.secondary.withOpacity(0.6),
        shape: ContinuousRectangleBorder(
          borderRadius: Dimension.buttonRadius,
          side: BorderSide(color: Palette.dark.withOpacity(0.6), width: 3),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextView(
                    widget.label ?? "",
                    color: Colors.white,
                    size: 18,
                  ),
                  if (widget.showCounter == true)
                    TextView(
                      '${_listIndex + 1}/${widget.list?.length ?? 0}',
                      size: 18,
                      color: Colors.white,
                    )
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //Previous Button
                  CustomButton(
                      onTap: onPrev,
                      child: const Icon(
                        Icons.arrow_back_ios_new_rounded,
                        color: Colors.white,
                      )),
                  TextView(
                    widget.list?[_listIndex],
                    size: 18,
                    color: Colors.white,
                  ),
                  // Next Button
                  CustomButton(
                      onTap: onNext,
                      child: const Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: Colors.white,
                      )),
                ],
              ),
              if (widget.list2 != null)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextView(
                      widget.label ?? "",
                      color: Colors.white,
                      size: 18,
                    ),
                    if (widget.showCounter == true)
                      TextView(
                        '${_listIndex + 1}/${widget.list?.length ?? 0}',
                        size: 18,
                        color: Colors.white,
                      )
                  ],
                ),
              if (widget.list2 != null) const SizedBox(height: 15),
              if (widget.list2 != null)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //Previous Button
                    CustomButton(
                        onTap: onPrev2,
                        child: const Icon(
                          Icons.arrow_back_ios_new_rounded,
                          color: Colors.white,
                        )),
                    TextView(
                      widget.list2?[_listIndex2],
                      size: 18,
                      color: Colors.white,
                    ),
                    // Next Button
                    CustomButton(
                        onTap: onNext2,
                        child: const Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: Colors.white,
                        )),
                  ],
                ),
              const SizedBox(height: 5),
            ],
          ),
        ),
      ),
    );
  }
}
