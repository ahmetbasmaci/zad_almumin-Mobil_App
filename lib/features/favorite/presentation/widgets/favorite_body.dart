import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zad_almumin/core/utils/resources/app_sizes.dart';
import 'package:zad_almumin/core/widget/animations/animated_list_item_down_to_up.dart';
import 'package:zad_almumin/core/widget/progress_indicator/app_circular_progress_indicator.dart';
import 'package:zad_almumin/features/home/home.dart';
import '../../../../core/widget/app_card_widgets/app_card_widgets.dart';
import '../../../home/presentation/widgets/hadith_part/hadith_card_widget.dart';
import '../../favorite.dart';

class FavoriteBody extends StatelessWidget {
  const FavoriteBody() : searchText = '';
  const FavoriteBody.withSearchText({required this.searchText});
  final String searchText;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const FavoriteSelectZikrType(),
        _savedDataCards(context),
      ],
    );
  }

  Widget _savedDataCards(BuildContext context) {
    return BlocBuilder<FavoriteCubit, FavoriteState>(
      builder: (context, state) {
        return FutureBuilder<List<BaseFavoriteEntities>>(
          future: _getData(context),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) return const AppCircularProgressIndicator();
            if (snapshot.hasError) return const Center(child: Text('Error'));
            List<BaseFavoriteEntities> filteredModels = snapshot.data as List<BaseFavoriteEntities>;
            return _zikrCards(context, filteredModels);
          },
        );
      },
    );
  }

  Future<List<BaseFavoriteEntities>> _getData(BuildContext context) {
    if (searchText.isEmpty) {
      return context.read<FavoriteCubit>().getAllSavedData();
    } else {
      return context.read<FavoriteCubit>().getFilteredZikrModels(searchText);
    }
  }

  Widget _zikrCards(BuildContext context, List<BaseFavoriteEntities> filteredModels) {
    List<Widget> cards = [];
    for (var model in filteredModels) {
      if (model is QuranCardModel) {
        cards.add(QuranCardWidget.fromFavorite(quranCardModel: model));
      } else if (model is HadithCardModel) {
        cards.add(HadithCardWidget.fromFavorite(hadithCardModel: model));
      }
      //TODO add other categories
    }

    return Expanded(
      child: ListView.builder(
        key: context.read<FavoriteCubit>().listKey,
        itemCount: cards.length,
        // shrinkWrap: true,
        physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        itemBuilder: (context, index) {
          return AnimatedListItemDownToUp(
            index: index,
            child: Padding(
              padding: EdgeInsets.only(
                left: AppSizes.screenPadding,
                right: AppSizes.screenPadding,
                top: index == 0 ? AppSizes.screenPadding : 0,
                bottom: index == cards.length - 1 ? AppSizes.screenPadding : 0,
              ),
              child: AppCard(
                useMargin: true,
                child: cards[index],
              ),
            ),
          );
        },
      ),
    );
  }
}
