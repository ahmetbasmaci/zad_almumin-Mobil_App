import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import '../../../features/alarm/data/models/alarm_model.dart';
import '../../../features/favorite/favorite.dart';
import '../../../features/home/home.dart';
import '../../../features/quran/quran.dart';
import '../../../features/tafseer/tafseer.dart';
import '../enums/enums.dart';

class NoParams extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetZikrCardDataParams extends Equatable {
  ZikrCategories zikrCategory;

  GetZikrCardDataParams({required this.zikrCategory});
  @override
  List<Object?> get props => [zikrCategory];
}

class GetAlarmDataPartParams extends Equatable {
  final AlarmPart aLarmType;

  const GetAlarmDataPartParams({required this.aLarmType});
  @override
  List<Object?> get props => [aLarmType];
}

class UpdateAlarmModelParams extends Equatable {
  final AlarmModel alarmModel;

  const UpdateAlarmModelParams({required this.alarmModel});
  @override
  List<Object?> get props => [alarmModel];
}

class GetPrayTimeParams extends Equatable {
  final Position position;
  final DateTime date;

  const GetPrayTimeParams({required this.position, required this.date});
  @override
  List<Object?> get props => [position, date];
}

class GetNextAyahParams extends Equatable {
  final int ayahNumber;
  final int surahNumber;

  const GetNextAyahParams({required this.ayahNumber, required this.surahNumber});
  @override
  List<Object?> get props => [ayahNumber, surahNumber];
}

class DownloadTafseerParams extends Equatable {
  final int tafseerId;

  const DownloadTafseerParams({required this.tafseerId});
  @override
  List<Object?> get props => [tafseerId];
}

class TafseerIdParams extends Equatable {
  final int tafseerId;

  const TafseerIdParams({required this.tafseerId});
  @override
  List<Object?> get props => [tafseerId];
}

class TafseerIdModelParams extends Equatable {
  final SelectedTafseerIdModel tafseerIdModel;

  const TafseerIdModelParams({required this.tafseerIdModel});
  @override
  List<Object?> get props => [tafseerIdModel];
}

class WriteDataIntoFileAsBytesSyncParams extends Equatable {
  final int tafseerId;
  final List<int> data;

  const WriteDataIntoFileAsBytesSyncParams({required this.tafseerId, required this.data});
  @override
  List<Object?> get props => [tafseerId, data];
}

class GetRandomStartAyahParams extends Equatable {
  final int juzFrom;
  final int juzTo;
  final int pageFrom;
  final int pageTo;

  const GetRandomStartAyahParams({
    required this.juzFrom,
    required this.juzTo,
    required this.pageFrom,
    required this.pageTo,
  });

  @override
  List<Object?> get props => [juzFrom, juzTo, pageFrom, pageTo];
}

class JuzFromParams extends Equatable {
  final int juzFrom;

  const JuzFromParams({required this.juzFrom});
  @override
  List<Object?> get props => [juzFrom];
}

class JuzToParams extends Equatable {
  final int juzTo;

  const JuzToParams({required this.juzTo});
  @override
  List<Object?> get props => [juzTo];
}

class PageFromParams extends Equatable {
  final int pageFrom;

  const PageFromParams({required this.pageFrom});
  @override
  List<Object?> get props => [pageFrom];
}

class PageToParams extends Equatable {
  final int pageTo;

  const PageToParams({required this.pageTo});
  @override
  List<Object?> get props => [pageTo];
}

class QuestionTypeParams extends Equatable {
  final QuestionType questionType;

  const QuestionTypeParams({required this.questionType});
  @override
  List<Object?> get props => [questionType];
}

class AnswerTypeParams extends Equatable {
  final AyahsAnswersType answerType;

  const AnswerTypeParams({required this.answerType});
  @override
  List<Object?> get props => [answerType];
}

class AddNewUserMessageParams extends Equatable {
  final String name;
  final String message;

  const AddNewUserMessageParams({required this.name, required this.message});

  @override
  List<Object?> get props => [name, message];
}

class FavoriteParams extends Equatable {
  final BaseFavoriteEntities item;

  const FavoriteParams({required this.item});

  @override
  List<Object?> get props => [item];
}

class PlayAudioParams extends Equatable {
  final QuranCardModel ayahs;
  final QuranReader quranReader;
  final Function onComplated;

  const PlayAudioParams({
    required this.ayahs,
    required this.quranReader,
    required this.onComplated,
  });

  @override
  List<Object?> get props => [ayahs, quranReader, onComplated];
}

class PlayMultibleAudioParams extends Equatable {
  final List<Ayah> ayahs;
  final int startAyahIndex;
  final QuranReader quranReader;
  final void Function(Ayah complatedAyah, bool partEnded) onComplated;

  const PlayMultibleAudioParams({
    required this.ayahs,
    required this.startAyahIndex,
    required this.quranReader,
    required this.onComplated,
  });

  @override
  List<Object?> get props => [ayahs, quranReader, onComplated];
}

class CheckIfSurahDownloadedBeforeParams extends Equatable {
  final int surahNumber;
  final QuranReader quranReader;

  const CheckIfSurahDownloadedBeforeParams({required this.surahNumber, required this.quranReader});

  @override
  List<Object?> get props => [surahNumber, quranReader];
}

class CheckIfAyahDownloadedBeforeParams extends Equatable {
  final int surahNumber;
  final int ayahNumber;
  final QuranReader quranReader;

  const CheckIfAyahDownloadedBeforeParams(
      {required this.surahNumber, required this.ayahNumber, required this.quranReader});

  @override
  List<Object?> get props => [surahNumber, ayahNumber, quranReader];
}

class DownloadSurahParams extends Equatable {
  final int surahNumber;
  final QuranReader quranReader;

  const DownloadSurahParams({required this.surahNumber, required this.quranReader});

  @override
  List<Object?> get props => [surahNumber, quranReader];
}

class DownloadAyahParams extends Equatable {
  final int surahNumber;
  final int ayahNumber;
  final QuranReader quranReader;

  const DownloadAyahParams({required this.surahNumber, required this.ayahNumber, required this.quranReader});

  @override
  List<Object?> get props => [surahNumber, ayahNumber, quranReader];
}
