import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zad_almumin/core/widget/buttons/audio_play_pause_button.dart';

import '../../../../../core/helpers/toats_helper.dart';
import '../../../../../src/injection_container.dart';
import '../../../../quran/quran.dart';
import '../../../home.dart';

class AudioBtnHomeQuranCard extends StatelessWidget {
  const AudioBtnHomeQuranCard({super.key});

  @override
  Widget build(BuildContext context) {
    return quranReaderCubit(
          child: homeQuranCardCubit(
          ),
        );
  }



  Widget quranReaderCubit({required Widget child}) {
    return BlocBuilder<QuranReaderCubit, QuranReaderState>(
      builder: (context, stateReader) {
        return child;
      },
    );
  }

  Widget homeQuranCardCubit() {
    return 
    //Container();
    AudioPlayPauseButton.single();
  }
}
