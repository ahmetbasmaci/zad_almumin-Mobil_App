import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zad_almumin/core/helpers/toats_helper.dart';
import '../../../../core/utils/resources/resources.dart';
import '../../../../core/widget/app_scaffold.dart';
import '../../favorite.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FavoriteCubit, FavoriteState>(
      listener: (context, state) {
        if (state is FavoriteErrorState) {
          ToatsHelper.showSnackBarError(context, state.message);
        }
      },
      builder: (context, state) {
        return AppScaffold(
          title: 'المفضلة',
          usePadding: false,
          actions: _actions(context),
          body: const FavoriteBody(),
        );
      },
    );
  }

  List<Widget> _actions(BuildContext context) {
    return [
      IconButton(
        icon: AppIcons.search,
        onPressed: () => showSearch(context: context, delegate: FavoriteSearchDelegate()),
      ),
    ];
  }
}
