import 'package:flutter/material.dart';

import '../../../../../config/local/l10n.dart';
import '../../../../../core/utils/resources/resources.dart';
import '../../../../../core/widget/app_card_widgets/app_card_widgets.dart';
import '../../../../../core/widget/space/space.dart';
import '../../../home.dart';

class QuranCardWidget extends StatelessWidget {
  final QuranCardModel quranCardModel;
  final bool fromFavoritePage;
  final Function? onReferesh;

  const QuranCardWidget({super.key, required this.quranCardModel, required this.onReferesh}) : fromFavoritePage = false;
  const QuranCardWidget.fromFavorite({super.key, required this.quranCardModel})
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
    return fromFavoritePage
        ? AppCardTopPartQuran.fromFavotire(title: AppStrings.of(context).quranTitle)
        : AppCardTopPartQuran(
            title: AppStrings.of(context).quranTitle,
            onReferesh: fromFavoritePage ? () {} : () => onReferesh?.call(),
          );
  }

  Widget _centerPartWidget(BuildContext context) {
    return Column(
      children: <Widget>[
        AppCardCenterPartWidget(
          content: quranCardModel.content,
          isLoading: false,
        ),
        _ayahProps(context, quranCardModel),
      ],
    );
  }

  Widget _ayahProps(BuildContext context, QuranCardModel quranCardModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Divider(
          height: 50,
          indent: 50,
          endIndent: 50,
        ),
        _ayahPropItem(context, AppStrings.of(context).surahName, quranCardModel.surahName),
        _ayahPropItem(context, AppStrings.of(context).ayahNumber, quranCardModel.ayahNumber.toString()),
        _ayahPropItem(context, AppStrings.of(context).juz, quranCardModel.juz.toString()),
      ],
    );
  }

  Widget _ayahPropItem(BuildContext context, String title, String value) {
    return Wrap(
      children: <Widget>[
        Text('$title:', style: AppStyles.bodyMediumBold(context)),
        HorizontalSpace(AppSizes.spaceBetweanParts),
        Text(value, style: AppStyles.bodyMediumBold(context)),
      ],
    );
  }

  Widget _footerPartWidget() {
    return AppCardContentFooterPartButtons(
      content: quranCardModel.content,
      item: quranCardModel,
    );
  }
}
