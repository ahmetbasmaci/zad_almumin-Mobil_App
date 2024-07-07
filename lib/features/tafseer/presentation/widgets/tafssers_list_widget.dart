import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zad_almumin/core/utils/resources/app_sizes.dart';
import 'package:zad_almumin/core/widget/space/space.dart';
import '../../tafseer.dart';

class TafssersListWidget extends StatelessWidget {
  const TafssersListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const TafseerLocaleListTile(),
        VerticalSpace(AppSizes.spaceBetweanWidgets),
        BlocBuilder<TafseerCubit, TafseerState>(
          builder: (context, state) {
            //if no tafseers for current local
            if (state.tafseerModels.isEmpty) return const NoTafseersForCurrentLocalWidget();

            return ListView.builder(
              itemCount: state.tafseerModels.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return TafseersListItem(tafseerModel: state.tafseerModels[index]);
              },
            );
          },
        ),
      ],
    );
  }
}
