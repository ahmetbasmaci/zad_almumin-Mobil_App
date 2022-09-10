import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:zad_almumin/constents/constents.dart';
import 'package:zad_almumin/pages/quran/components/quran_search_delegate.dart';
import '../../../constents/colors.dart';
import '../../../constents/icons.dart';
import '../../../constents/texts.dart';
import '../../../services/theme_service.dart';
import '../../home_page.dart';
import '../classes/quran_helper.dart';
import '../controllers/quran_page_ctr.dart';

class QuranUpPart extends StatelessWidget {
  QuranUpPart({Key? key, required this.quranPageSetState}) : super(key: key);
  VoidCallback quranPageSetState;
  final double _upPartHeight = Get.size.height * .1;
  QuranPageCtr quranCtr = Get.find<QuranPageCtr>();

  var goToPageTextCtr = TextEditingController();
  @override
  Widget build(BuildContext context) {
    List<MenuItem> menuItemList = [
      MenuItem(
        title: 'بحث',
        icon: MyIcons.search(color: MyColors.quranSecond()),
        onTap: () => showSearch(context: context, delegate: QuranSearchDelegate()),
      ),
      MenuItem(
        title: 'اضافة علامة',
        icon: MyIcons.mark(color: MyColors.quranSecond()),
        onTap: () => QuranHelper().showMarkDialog(),
      ),
      MenuItem(
        title: 'تغير الثيم',
        icon: MyIcons.animated_Light_Dark(color: MyColors.quranSecond()),
        onTap: () {
          bool isDark = ThemeService().getThemeMode() == ThemeMode.dark;
          ThemeService().changeThemeMode(!isDark);
          quranPageSetState.call();
        },
      ),
    ];
    return AnimatedPositioned(
      duration: Duration(milliseconds: 300),
      top: quranCtr.onShown.value ? 0 : -_upPartHeight,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        height: _upPartHeight,
        width: Get.size.width,
        decoration: BoxDecoration(
          color: MyColors.quranBackGround(),
          boxShadow: [
            BoxShadow(
                color: MyColors.quranSecond().withOpacity(0.2), offset: Offset(0, 5), blurRadius: 30, spreadRadius: .5)
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: Align(
                alignment: Alignment.bottomRight,
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () => Get.offAll(() => HomePage()),
                      icon: MyIcons.home(color: MyColors.quranSecond()),
                    ),
                    PopupMenuButton(
                        color: MyColors.quranBackGround(),
                        icon: MyIcons.moreVert(color: MyColors.quranSecond()),
                        itemBuilder: (context) {
                          return [
                            ...menuItemList.map((e) => PopupMenuItem(
                                  value: e,
                                  child: InkWell(
                                    onTap: () {
                                      Get.back();
                                      e.onTap();
                                    },
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        e.icon,
                                        SizedBox(width: Get.width * .04),
                                        MyTexts.quran(title: e.title, color: MyColors.quranSecond()),
                                      ],
                                    ),
                                  ),
                                )),
                          ];
                        }),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  MyTexts.quranSecondTitle(title: 'الصفحة:   '),
                  SizedBox(
                    width: 40,
                    child: TextField(
                      controller: goToPageTextCtr,
                      keyboardType: TextInputType.number,
                      maxLength: 3,
                      cursorHeight: 20,
                      showCursor: false,
                      onSubmitted: (val) {
                        goToPageTextCtr.clear();
                        QuranHelper().changeOnShownState(false);
                      },
                      onTap: () => goToPageTextCtr.clear(),
                      onChanged: (query) {
                        if (query == '') return;
                        if (int.parse(query) > 604 || int.parse(query) < 1) {
                          Fluttertoast.showToast(msg: 'صفحة غير موجودة');
                          return;
                        }
                        quranCtr.tabCtr.index = int.parse(goToPageTextCtr.text) - 1;
                      },
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.fromLTRB(2, 2, 5, 2),
                        border: OutlineInputBorder(),
                        counterText: "",
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () => Constants.scaffoldKey.currentState!.openEndDrawer(),
                    icon: MyIcons.book(color: MyColors.quranSecond()),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MenuItem {
  MenuItem({required this.title, required this.icon, required this.onTap});
  String title;
  Widget icon;
  VoidCallback onTap;
}
