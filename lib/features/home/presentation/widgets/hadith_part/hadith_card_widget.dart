import 'package:flutter/material.dart';
import 'package:zad_almumin/features/home/home.dart';

import '../../../../../config/local/l10n.dart';
import '../../../../../core/utils/resources/resources.dart';
import '../../../../../core/widget/app_card_widgets/app_card_widgets.dart';
import '../../../../../core/widget/space/space.dart';

class HadithCardWidget extends StatelessWidget {
  final HadithCardModel hadithCardModel;
  final bool fromFavoritePage;
  final Function? onReferesh;

  const HadithCardWidget({super.key, required this.hadithCardModel, required this.onReferesh})
      : fromFavoritePage = false;
  const HadithCardWidget.fromFavorite({super.key, required this.hadithCardModel})
      : fromFavoritePage = true,
        onReferesh = null;

  @override
  Widget build(BuildContext context) {
    return AppCardContent(
      topPartWidget: _toppartWidget(context),
      centerPartWidget: _centerPartWidget(context),
      footerPartWidget: _footerPartWidget(),
    );
  }

  Widget _toppartWidget(BuildContext context) {
    String title = AppStrings.of(context).hadithTitle;
    return fromFavoritePage
        ? AppCardTopPartHadith.fromFavorite(title: title)
        : AppCardTopPartHadith(title: title, onReferesh: onReferesh);
  }

  Widget _centerPartWidget(BuildContext context) {
    return Column(
      children: <Widget>[
        AppCardCenterPartWidget(content: '${hadithCardModel.hadithSanad}\n${hadithCardModel.hadithText}'),
        _hadithProps(context, hadithCardModel),
      ],
    );
  }

  Widget _hadithProps(BuildContext context, HadithCardModel hadithCardModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Divider(
          height: 50,
          indent: 50,
          endIndent: 50,
        ),
        _hadithPropItem(context, AppStrings.of(context).hadithBookName, hadithCardModel.hadithBookName),
        _hadithPropItem(context, AppStrings.of(context).categoryBookname, hadithCardModel.chapterBookname),
        _hadithPropItem(context, AppStrings.of(context).chapterName, hadithCardModel.chapterName),
        _hadithPropItem(context, AppStrings.of(context).hadithId, hadithCardModel.hadithId.toString()),
      ],
    );
  }

  Widget _hadithPropItem(BuildContext context, String title, String value) {
    return Wrap(
      children: <Widget>[
        Text('$title:', style: AppStyles.bodyMediumBold(context)),
        HorizontalSpace(AppSizes.spaceBetweanParts),
        Text(value),
      ],
    );
  }

  Widget _footerPartWidget() {
    return AppCardContentFooterPartButtons(
      content: hadithCardModel.hadithText,
      item: hadithCardModel,
    );
  }
}
