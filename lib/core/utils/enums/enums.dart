enum ZikrCategories {
  morning,
  evening,
  wakeUp,
  sleep,
  travel,
  eating,
  mosque,
  home,
  toilet,
  haj,
  allahNames,
}

enum AlarmPeriod { daily, weekly, monthly, once, repeat }

enum RepeatAlarmType { high, medium, low, rare, none }

enum AlarmPart {
  dua,
  hadith,
  dailyAzkar,
  quran,
  fast,
  pray,
}

enum AlarmType {
  duaPhalastine,
  hadith,
  diferentAzkar,
  morningAzkar,
  eveningAzkar,
  quranPageEveryDay,
  quranKahfSure,
  mondayFasting,
  thursdayFasting,
  fajrAdhan,
  duhrAdhan,
  asrAdhan,
  maghribAdhan,
  ishaAdhan,
}

enum PrayTimeType { fajr, sun, duhr, asr, maghrib, isha,none }

enum AppConnectivityResult { bluetooth, wifi, ethernet, mobile, none, vpn, other }
