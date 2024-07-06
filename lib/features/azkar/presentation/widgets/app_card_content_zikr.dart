import 'package:flutter/material.dart';
import '../../../../config/local/l10n.dart';
import '../../../../core/extentions/extentions.dart';
import '../../../../core/utils/resources/app_sizes.dart';
import '../../../../core/utils/resources/app_styles.dart';
import '../../azkar.dart';

import '../../../../core/utils/enums/enums.dart';
import '../../../../core/widget/animations/animated_list_item_down_to_up.dart';
import '../../../../core/widget/app_card_widgets/app_card_widgets.dart';

class ZikrCardWidget extends StatelessWidget {
  ZikrCardWidget.zikr({
    super.key,
    required this.zikrCardModel,
    required this.zikrCategoty,
  })  : isFromFavorite = false,
        allahNamesCardModel = null;

  ZikrCardWidget.zikrFromFavorite({
    super.key,
    this.zikrCardModel,
  })  : isFromFavorite = true,
        zikrCategoty = ZikrCategories.wakeUp, //TODO meybe should change this to real category
        allahNamesCardModel = null;

  ZikrCardWidget.allahNames({
    super.key,
    required this.allahNamesCardModel,
  })  : isFromFavorite = false,
        zikrCardModel = null,
        zikrCategoty = ZikrCategories.allahNames;

  ZikrCardWidget.allahNamesFromFavorite({
    super.key,
    required this.allahNamesCardModel,
  })  : isFromFavorite = true,
        zikrCardModel = null,
        zikrCategoty = ZikrCategories.allahNames;

  final ZikrCardModel? zikrCardModel;
  final AllahNamesCardModel? allahNamesCardModel;

  final ZikrCategories zikrCategoty;
  final bool isFromFavorite;
  int totalIndex = 0;

  @override
  Widget build(BuildContext context) {
    totalIndex = 0;
    return zikrCategoty == ZikrCategories.allahNames ? _allahNamesBody(context) : _azkarsBody(context);
  }

  Widget _allahNamesBody(BuildContext context) {
    return _appCardContent(
      context: context,
      useMargin: true,
      title: allahNamesCardModel!.name,
      content: allahNamesCardModel!.content,
      description: '',
      count: -1,
    );
  }

  Widget _azkarsBody(BuildContext context) {
    if (zikrCardModel!.haveList) {
      return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: zikrCardModel!.list.length,
          itemBuilder: (context, index2) {
            if (index2 > 0) {
              zikrCardModel!.title = "${zikrCardModel!.title} ${index2 + 1}";
            }
            zikrCardModel!.content = zikrCardModel!.list[index2]['zekr'] ?? "";
            return _appCardContent(
              context: context,
              useMargin: true,
              title: zikrCardModel!.title,
              content: zikrCardModel!.content,
              description: zikrCardModel!.description,
              count: zikrCardModel!.count,
            );
          });
    } else {
      return _appCardContent(
        context: context,
        useMargin: true,
        title: zikrCardModel!.title,
        content: zikrCardModel!.content,
        description: zikrCardModel!.description,
        count: zikrCardModel!.count,
      );
    }
  }

  Widget _appCardContent({
    required BuildContext context,
    required bool useMargin,
    required String title,
    required String content,
    required String description,
    required int count,
  }) {
    totalIndex++;
    return AnimatedListItemDownToUp(
      index: totalIndex,
      child: isFromFavorite
          ? AppCardContent(
              topPartWidget: _topPartWidget(context, title, count),
              centerPartWidget: _centerPartWidget(content, description),
              footerPartWidget: _footerPartWidget(context, title, content, count),
            )
          : StatefulBuilder(
              builder: (BuildContext context, setState) {
                return AppCardWithTappingAnimation(
                  canTap: count > 0 || count == -1,
                  onTap: () {},
                  onTapUp: () async {
                    count--;
                    //ckeck if state alive
                    if (context.mounted) {
                      setState(() {});
                    }
                  },
                  useMargin: useMargin,
                  child: AppCardContent(
                    topPartWidget: _topPartWidget(context, title, count),
                    centerPartWidget: _centerPartWidget(content, description),
                    footerPartWidget: _footerPartWidget(context, title, content, count),
                  ),
                );
              },
            ),
    );
  }

  Widget _topPartWidget(BuildContext context, String title, int count) {
    return AppCardTopPart(
      centerWidget: Text(
        title,
        style: AppStyles.titleMedium(context).copyWith(color: context.themeColors.primary),
      ),
    );
  }

  Widget _centerPartWidget(String content, String description) {
    return Column(
      children: <Widget>[
        AppCardCenterPartWidget(
          content: content,
          description: description,
        ),
      ],
    );
  }

  Widget _footerPartWidget(BuildContext context, String title, String content, int count) {
    return Padding(
      padding: EdgeInsets.only(top: AppSizes.cardPadding * 2),
      child: Column(
        children: [
          AppCardContentFooterPartButtons(
            content: content,
            item: zikrCardModel ?? allahNamesCardModel!,
          ),
          count > 0 ? _counterWidget(context, count) : Container(),
        ],
      ),
    );
  }

  Widget _counterWidget(BuildContext context, int count) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: context.themeColors.background,
        borderRadius: const BorderRadius.all(Radius.circular(100)),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 5),
            color: context.themeColors.primary.withOpacity(.2),
            blurRadius: 5,
          ),
        ],
      ),
      child: Text(
        count != 0 ? "$count" : AppStrings.of(context).done,
        style: AppStyles.titleMedium(context),
        textAlign: TextAlign.center,
      ),
    );
  }
}
