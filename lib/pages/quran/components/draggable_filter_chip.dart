import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zad_almumin/constents/my_texts.dart';
import '../../../constents/my_colors.dart';
import '../models/filter_chip_prop.dart';
import '../controllers/quran_page_ctr.dart';

class DraggableFilterChip extends StatelessWidget {
  DraggableFilterChip({super.key});
  QuranPageCtr quranCtr = Get.find<QuranPageCtr>();
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width,
      child: Column(
        children: [
          StatefulBuilder(builder: (context, setState) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                DragTarget<FilterChipProp>(
                  builder: (context, candidateData, rejectedData) => dragChild(quranCtr.searchFilterList[0].value),
                  onWillAccept: (newFilterChip) => true,
                  onAccept: (newFilterChip) {
                    FilterChipProp oldFilterChip = quranCtr.searchFilterList[0].value;
                    if (oldFilterChip == newFilterChip) return;
                    for (var i = 0; i < quranCtr.searchFilterList.length; i++) {
                      if (quranCtr.searchFilterList[i].value == newFilterChip) {
                        quranCtr.searchFilterList[i].value = oldFilterChip;
                        break;
                      }
                    }
                    quranCtr.searchFilterList[0].value = newFilterChip;

                    quranCtr.updateSearchFilterList();
                    setState(() {});
                  },
                ),
                DragTarget<FilterChipProp>(
                  builder: (context, candidateData, rejectedData) => dragChild(quranCtr.searchFilterList[1].value),
                  onWillAccept: (newFilterChip) => true,
                  onAccept: (newFilterChip) {
                    FilterChipProp oldFilterChip = quranCtr.searchFilterList[1].value;
                    if (oldFilterChip == newFilterChip) return;

                    for (var i = 0; i < quranCtr.searchFilterList.length; i++) {
                      if (quranCtr.searchFilterList[i].value == newFilterChip) {
                        quranCtr.searchFilterList[i].value = oldFilterChip;
                        break;
                      }
                    }
                    quranCtr.searchFilterList[1].value = newFilterChip;

                    quranCtr.updateSearchFilterList();
                    setState(() {});
                  },
                ),
                DragTarget<FilterChipProp>(
                  builder: (context, candidateData, rejectedData) => dragChild(quranCtr.searchFilterList[2].value),
                  onWillAccept: (newFilterChip) => true,
                  onAccept: (newFilterChip) {
                    FilterChipProp oldFilterChip = quranCtr.searchFilterList[2].value;
                    if (oldFilterChip == newFilterChip) return;

                    for (var i = 0; i < quranCtr.searchFilterList.length; i++) {
                      if (quranCtr.searchFilterList[i].value == newFilterChip) {
                        quranCtr.searchFilterList[i].value = oldFilterChip;
                        break;
                      }
                    }
                    quranCtr.searchFilterList[2].value = newFilterChip;

                    quranCtr.updateSearchFilterList();
                    setState(() {});
                  },
                ),
              ],
            );
          }),
          Divider(),
        ],
      ),
    );
  }

  Widget dragChild(FilterChipProp data) => item(data);

  Widget item(FilterChipProp filterChipProp) {
    Widget filterChip = Obx(
      () => FilterChip(
        label:
            MyTexts.quran(title: filterChipProp.text, color: filterChipProp.isSelected.value ? MyColors.white : null),
        selected: filterChipProp.isSelected.value,
        selectedColor: MyColors.quranPrimary(),
        checkmarkColor: MyColors.white,
        onSelected: (value) {
          filterChipProp.isSelected.value = value;
          quranCtr.updateSearchFilterList();
        },
      ),
    );
    Widget childDragging = FilterChip(
      label: MyTexts.quran(title: '           '),
      selected: false,
      onSelected: (value) {},
      selectedColor: MyColors.quranPrimary(),
    );
    return Draggable<FilterChipProp>(
      data: filterChipProp,
      childWhenDragging: childDragging,
      feedback: Material(
        color: Colors.transparent,
        child: filterChip,
      ),
      child: filterChip,
    );
  }
}
