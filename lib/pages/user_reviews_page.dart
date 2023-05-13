import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:zad_almumin/components/my_app_bar.dart';
import 'package:zad_almumin/components/my_drawer.dart';
import 'package:zad_almumin/constents/my_colors.dart';
import 'package:zad_almumin/constents/my_sizes.dart';
import 'package:zad_almumin/constents/my_texts.dart';
import 'package:zad_almumin/moduls/user_review.dart';
import 'package:zad_almumin/services/animation_service.dart';
import 'package:zad_almumin/services/theme_service.dart';

class UserReviews extends StatefulWidget {
  UserReviews({super.key});
  static String id = 'UserReviews';
  @override
  State<UserReviews> createState() => _UserReviewsState();
}

class _UserReviewsState extends State<UserReviews> {
  static streamItems() {
    return FirebaseFirestore.instance.collection("users").snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MyAppBar(title: "ملاحظة للمطور"),
        drawer: MyDrawer(),
        body: StreamBuilder<QuerySnapshot>(
          stream: streamItems(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting)
              return Center(child: CircularProgressIndicator());
            else if (snapshot.hasError) return MyTexts.quran(title: 'ERROR: ${snapshot.error}');

            List<DocumentSnapshot> list = snapshot.data.docs;
            list = list.reversed.toList();
            List<UserReviewsData> itemsList = [];
            for (var element in list) itemsList.add(UserReviewsData.fromJson(element.data() as Map<String, dynamic>));
            return RefreshIndicator(
              onRefresh: () async => Future.delayed(Duration(seconds: 1)).then((value) => setState(() {})),
              child: AnimationLimiter(
                child: ListView.builder(
                  padding: EdgeInsets.all(20),
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                  itemCount: itemsList.length,
                  itemBuilder: (BuildContext c, int index) {
                    return AnimationService.animationListItemDownToUp(
                        index: index,
                        child: Column(
                          children: [
                            ExpansionTile(
                              title: MyTexts.quran(
                                  title: itemsList[index].data[0].name,
                                  size: Get.width * 0.06,
                                  textAlign: TextAlign.center),
                              leading: Icon(Icons.list),
                              // backgroundColor: MyColors.expansionTile(),
                              // collapsedBackgroundColor: MyColors.expansionTile(),
                              iconColor: MyColors.primary(),
                              children: [
                                SizedBox(height: MySiezes.betweanAzkarBlock),
                                ...userReviewsCard(items: itemsList[index].data),
                              ],
                            ),
                            Divider(
                              height: 10,
                              thickness: 4,
                            )
                          ],
                        ));
                  },
                ),
              ),
            );
          },
        ));
  }

  List<Widget> userReviewsCard({required List<ReviewData> items}) {
    return items.map((e) => reviewCard(item: e)).toList();
  }

  Widget reviewCard({required ReviewData item}) {
    return Container(
      margin: EdgeInsets.only(
        bottom: MySiezes.betweanAzkarBlock,
        left: MySiezes.betweanAzkarBlock,
        right: MySiezes.betweanAzkarBlock,
      ),
      padding: EdgeInsets.only(
        bottom: MySiezes.betweanAzkarBlock,
        left: MySiezes.betweanAzkarBlock,
        right: MySiezes.betweanAzkarBlock,
      ),
      decoration: BoxDecoration(
        color: MyColors.background(),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [BoxShadow(color: MyColors.black.withOpacity(0.1), blurRadius: 10, spreadRadius: 2)],
      ),
      child: Padding(
        padding: EdgeInsets.all(MySiezes.betweanAzkarBlock),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MyTexts.quran(title: item.name, textAlign: TextAlign.start, color: MyColors.primary()),
            Divider(height: 10),
            MyTexts.quran(title: item.review, textAlign: TextAlign.start, size: Get.width * 0.04),
          ],
        ),
      ),
    );
  }
}
