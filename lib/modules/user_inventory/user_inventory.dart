import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:html_test/data/constants/assets.dart';
import 'package:html_test/utility/utils.dart';

import '../../style/style.dart';

class UserInventoryUi extends ConsumerWidget {
  const UserInventoryUi({Key? key}) : super(key: key);
  final padding = 60.0;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<DragItem> pocketsList = List.filled(5, const DragItem());
    List<DragItem> backpackList = List.filled(30, const DragItem(isLocked: false));
    final List<DragItem> equippedList = List.filled(15, const DragItem(isLocked: false));
    final List<DragItem> quickAccessList = List.filled(5, const DragItem(isLocked: false));

    pocketsList[1] = const DragItem(isLocked: true);
    pocketsList[3] = const DragItem(icon: Icons.ac_unit, quantity: 4, title: 'Snow');

    for (int i = 10; i < backpackList.length; i++) {
      backpackList[i] = const DragItem(isLocked: true);
    }

    quickAccessList[0] = const DragItem(icon: Icons.phone_iphone);
    quickAccessList[1] = const DragItem(icon: Icons.fastfood);
    quickAccessList[2] = const DragItem(icon: Icons.healing);
    quickAccessList[3] = const DragItem(icon: Icons.key);
    quickAccessList[4] = const DragItem(icon: Icons.menu_book_outlined);

    return Scaffold(
      backgroundColor: Palette.secondary.withOpacity(0.7),
      body: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
        child: Column(
          children: [
            DragTarget<DragItem>(
              onAccept: (DragItem data) {
                debugPrint('data: $data');
              },
              builder: (context, candidateData, rejectedData) => Container(
                height: 70,
                width: double.maxFinite,
                color: Colors.red.withOpacity(0.2),
                alignment: Alignment.center,
                child: TextView(
                  'Drag and drop here\nto throw out an item'.toUpperCase(),
                  size: 20,
                  textAlign: TextAlign.center,
                  textType: TextType.title,
                ),
              ),
            ),
            Expanded(
              child: Container(
                height: double.maxFinite,
                width: double.maxFinite,
                alignment: Alignment.center,
                padding: const EdgeInsets.all(20.0).copyWith(top: 0),
                child: Column(
                  children: [
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        InventoryGrid(
                          data: pocketsList,
                          title: 'pockets',
                          itemCount: 5,
                          columnCount: 5,
                          rowCount: 1,
                        ),
                        padding.width,
                        InventoryGrid(
                          data: backpackList,
                          title: 'backpack',
                          itemCount: 30,
                          columnCount: 5,
                          rowCount: 6,
                        ),
                        padding.width,
                        InventoryGrid(
                          data: equippedList,
                          title: 'equipped',
                          itemCount: 15,
                          columnCount: 5,
                          rowCount: 3,
                        ),
                      ],
                    ),
                    const Spacer(),
                    InventoryGrid(
                      data: quickAccessList,
                      title: 'quick access',
                      itemCount: 5,
                      columnCount: 1,
                      rowCount: 5,
                      axis: Axis.horizontal,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class InventoryGrid extends StatefulWidget {
  const InventoryGrid({
    super.key,
    required this.title,
    required this.itemCount,
    this.dimensions = 100,
    this.columnCount = 1,
    this.rowCount = 1,
    this.spacing = 20.0,
    this.axis = Axis.vertical,
    this.data,
  });

  final int columnCount, rowCount, itemCount;
  final double dimensions;
  final double spacing;
  final String title;
  final Axis axis;
  final List<DragItem>? data;

  @override
  State<InventoryGrid> createState() => _InventoryGridState();
}

class _InventoryGridState extends State<InventoryGrid> {
  List<DragItem?>? _dragItem;

  @override
  void initState() {
    super.initState();
    _dragItem = widget.data;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        TextView(
          widget.title.toUpperCase(),
          size: 20,
          letterSpacing: 1.3,
          textType: TextType.title,
        ),
        20.0.height,
        SizedBox(
          width: (widget.dimensions * widget.rowCount) + (widget.spacing * (widget.rowCount - 1)),
          height: (widget.dimensions * widget.columnCount) + (widget.spacing * (widget.columnCount - 1)),
          child: Wrap(
            direction: widget.axis,
            spacing: widget.spacing,
            runSpacing: widget.spacing,
            children: List.generate(_dragItem?.length ?? widget.itemCount, (index) {
              return AbsorbPointer(
                absorbing: _dragItem?[index]?.isLocked == true,
                child: DragTarget<DragItem>(
                  onWillAccept: (data) => _dragItem?[index]?.icon == null,
                  onAccept: (DragItem i) {
                    _dragItem?[index] = i;
                  },
                  builder: (context, candidateData, rejectedData) {
                    final e = _dragItem?[index];

                    return _invenContainer(
                      dimension: widget.dimensions,
                      isLocked: e?.isLocked,
                      child: LongPressDraggable<DragItem>(
                        data: _dragItem?[index],
                        onDragCompleted: () {
                          debugPrint('rejectedData: $rejectedData');
                          debugPrint('candidateData: $candidateData');
                          if (candidateData.isEmpty) {
                            setState(() => _dragItem?[index] = const DragItem(isLocked: false));
                          }
                        },
                        delay: Duration.zero,
                        childWhenDragging: SizedBox(
                          height: widget.dimensions,
                          width: widget.dimensions,
                        ),
                        feedback: SizedBox(
                          height: widget.dimensions,
                          width: widget.dimensions,
                          child: Icon(e?.icon, size: 50, color: Colors.white),
                        ),
                        child: Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            // Item Icon
                            Container(
                              height: widget.dimensions,
                              width: widget.dimensions,
                              color: Colors.transparent,
                              child: Icon(e?.icon, size: 50, color: Colors.white),
                            ),

                            // Item count
                            if (e?.quantity != null && e?.quantity != 0)
                              Container(
                                padding: const EdgeInsets.all(5).copyWith(left: 8, right: 8),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(2),
                                  color: const Color(0xff4e596f),
                                ),
                                child: TextView(
                                  '${e?.quantity ?? '0'}',
                                  height: 1,
                                  textAlign: TextAlign.right,
                                  color: Palette.light,
                                  size: 12,
                                ),
                              ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
            }),
          ),
        ),
      ],
    );
  }

  Widget _invenContainer({required Widget child, bool? isLocked = false, double? dimension}) {
    return SizedBox.square(
      dimension: dimension,
      child: Material(
        color: const Color(0x7f242a38),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
          side: const BorderSide(
            color: Color(0xff4e596f),
            width: 2,
          ),
        ),
        child: isLocked == true
            ? Center(
                child: SvgPicture.asset(
                  LocalAsset.lockSvg,
                  height: 50,
                  width: 50,
                ),
              )
            : child,
      ),
    );
  }
}

class DragItem {
  final IconData? icon;
  final int? quantity;
  final String? title;
  final bool isLocked;

  const DragItem({
    this.icon,
    this.quantity,
    this.title,
    this.isLocked = false,
  });
}
