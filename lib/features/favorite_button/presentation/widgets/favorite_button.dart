import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zad_almumin/core/helpers/toats_helper.dart';
import 'package:zad_almumin/src/injection_container.dart';
import '../../../../core/utils/resources/app_icons.dart';
import '../../../favorite/favorite.dart';
import '../../favorite_button.dart';

class FavoriteButton extends StatelessWidget {
  const FavoriteButton({super.key, required this.item});
  final BaseFavoriteEntities item;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetItManager.instance.favoriteButtonCubit,
      child: BlocConsumer<FavoriteButtonCubit, FavoriteButtonState>(
        listener: (context, state) {
          if (state is FavoriteButtonErrorState) {
            ToatsHelper.showSnackBarError(context, state.message);
          }
        },
        builder: (context, state) => FutureBuilder(
          future: context.read<FavoriteButtonCubit>().checkIfItemIsFavorite(item),
          builder: (context, snapshot) => IconButton(
            onPressed: () => context.read<FavoriteButtonCubit>().changeFavoriteStatus(item),
            icon: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: state.isFavorite ? AppIcons.favoriteFilled : AppIcons.favorite,
            ),
          ),
        ),
      ),
    );
  }
}
