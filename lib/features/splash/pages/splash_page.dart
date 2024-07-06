import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:zad_almumin/core/helpers/navigator_helper.dart';
import 'package:zad_almumin/core/helpers/pages_helper.dart';
import 'package:zad_almumin/features/splash/widget/splah_image_widget.dart';
import 'package:zad_almumin/src/bloc_observer.dart';
import '../widget/splah_text_widget.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with TickerProviderStateMixin {
  late AnimationController scaleController;
  late Animation<double> scaleAnimation;

  double _opacity = 0;
  bool _value = true;
  final Duration _splashScreenTime =
      kDebugMode ? const Duration(milliseconds: 0) : const Duration(milliseconds: 1000);
  final Duration _colorBigingTime = const Duration(milliseconds: 350);
  @override
  void initState() {
    super.initState();
    _setAnimationController();
    scaleAnimation = Tween<double>(begin: 0.0, end: 12).animate(scaleController);
    _updateVlauesTime();
    _updateAnimationTimer();
  }

  void _setAnimationController() {
    scaleController = AnimationController(
      vsync: this,
      duration: _colorBigingTime,
    )..addStatusListener(
        (status) {
          if (status == AnimationStatus.completed) {
            //ToatsHelper.show("Ended");
            NavigatorHelper.pushReplacementNamed(PagesHelper.getPagePath);
            // NavigatorHelper.pushReplacementNamed(AppRoutes.onboarding);
          }
        },
      );
  }

  void _updateVlauesTime() {
    Timer(
      const Duration(milliseconds: 500),
      () => setState(
        () {
          _opacity = 1.0;
          _value = false;
        },
      ),
    );
  }

  void _updateAnimationTimer() async {
    _setInitMethod();

    Timer(
      _splashScreenTime,
      () {
        setState(() {
          scaleController.forward();
        });
      },
    );
  }

  Future<void> _setInitMethod() async {
    await GetStorage.init();
    Bloc.observer = AppBlocObserver();
    await Firebase.initializeApp();
  }

  @override
  void dispose() {
    scaleController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            const SplahTextWidget(),
            SplahImageWidget(
              opacity: _opacity,
              value: _value,
              scaleAnimation: scaleAnimation,
            ),
          ],
        ),
      ),
    );
  }
}
