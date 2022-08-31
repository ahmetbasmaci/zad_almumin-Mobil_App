import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:zad_almumin/classes/zikr_data.dart';
import 'package:zad_almumin/components/my_app_bar.dart';
import 'package:zad_almumin/components/my_circular_progress_indecator.dart';
import 'package:zad_almumin/components/zikr_cards.dart';
import 'package:zad_almumin/constents/icons.dart';
import 'package:zad_almumin/constents/sizes.dart';
import 'package:zad_almumin/constents/texts.dart';
import 'package:zad_almumin/database/sqldb.dart';
import 'package:zad_almumin/moduls/enums.dart';
import '../components/my_drawer.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({Key? key}) : super(key: key);
  static const id = 'FavoritePage';
  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  List<ZikrData> zikrDataList = [];
  ZikrType selectedZikrType = ZikrType.quran;
  late Future readFuture;
  GetStorage getStorage = GetStorage();
  final GlobalKey<AnimatedListState> listKey = GlobalKey();
  @override
  void initState() {
    super.initState();
    readFuture = readDataFromDb();
    selectedZikrType = ZikrType.values[getStorage.read('selectedZikrType') ?? 0];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MyAppBar(
          title: 'المفضلة',
          actions: [
            MyIcons.menu(),
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: MySiezes.cardPadding),
                child: DropdownButton<ZikrType>(
                    icon: Container(),
                    value: selectedZikrType,
                    items: [
                      DropdownMenuItem(value: ZikrType.all, child: MyTexts.dropDownMenuItem( title: 'الكل')),
                      DropdownMenuItem(
                          value: ZikrType.allahNames,
                          child: MyTexts.dropDownMenuItem( title: 'أسماء الله الحسنى')),
                      DropdownMenuItem(
                          value: ZikrType.azkar, child: MyTexts.dropDownMenuItem( title: 'الاذكار')),
                      DropdownMenuItem(
                          value: ZikrType.quran, child: MyTexts.dropDownMenuItem( title: 'القران')),
                      DropdownMenuItem(
                          value: ZikrType.hadith, child: MyTexts.dropDownMenuItem( title: 'الحديث')),
                    ],
                    onChanged: (newSelectedType) {
                      getStorage.write('selectedZikrType', newSelectedType!.index);
                      setState(() {
                        selectedZikrType = newSelectedType;
                      });
                    }),
              ),
            ),
          ],
        ),
        drawer: MyDrawer(),
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: MySiezes.screenPadding),
          child: FutureBuilder(
            future: readFuture,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<ZikrData> selectedZikrDataList = [];
                if (selectedZikrType == ZikrType.all)
                  selectedZikrDataList.addAll(zikrDataList);
                else
                  for (var element in zikrDataList)
                    if (element.zikrType == selectedZikrType) selectedZikrDataList.add(element);

                return AnimatedList(
                  key: listKey,
                  initialItemCount: selectedZikrDataList.length,
                  physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                  itemBuilder: (context, index, animation) {
                    return SizeTransition(
                      key: UniqueKey(),
                      sizeFactor: animation,
                      child: ZikrCard2(
                        haveMargin: true,
                        onDeleteFromFavorite: () {
                          ZikrData deletingZikrData = selectedZikrDataList[index];
                          listKey.currentState!.removeItem(
                            index,
                            duration: Duration(milliseconds: 500),
                            (context, animation) {
                              return SizeTransition(
                                sizeFactor: animation,
                                child: ZikrCard2(
                                  haveMargin: true,
                                ).allahNamesCard(deletingZikrData),
                              );
                            },
                          );
                          zikrDataList.remove(selectedZikrDataList[index]);
                          selectedZikrDataList.removeAt(index);
                        },
                      ).byType(selectedZikrDataList[index]),
                    );
                  },
                );
              } else
                return MyCircularProgressIndecator();
            },
          ),
        ));
  }

  Future readDataFromDb() async {
    SqlDb sqlDb = SqlDb();
    List<Map> listMap = await sqlDb.readData(SqlDb.dbName);
    for (var i = 0; i < listMap.length; i++) {
      zikrDataList.add(
        ZikrData(
          zikrType: ZikrType.values[listMap[i]['zikrType']],
          title: listMap[i]['title'],
          content: listMap[i]['content'],
          description: listMap[i]['description'],
          ayahNumber: listMap[i]['numberInQuran'],
          surahNumber: listMap[i]['surahNumber'],
          isFavorite: true,
        ),
      );
    }
    setState(() {});
    return true;
  }
}
