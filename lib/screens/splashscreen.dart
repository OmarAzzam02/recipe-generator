// ignore_for_file: prefer_const_constructors, sort_child_properties_last, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:fading_widget_animation/fading_widget_animation.dart';
import 'package:animated_floating_widget/animated_floating_widget.dart';
import 'package:receipe_generator/routes/routes.dart';
import 'package:receipe_generator/screens/home.dart';

class RecipeApp extends StatelessWidget {
  const RecipeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: 'intro',
      routes: {
        'intro': (context) => introLogo(),
        Routes.home: (context) => Home(
              isDark: false,
              onThemeToggle: (bool) {},
            )

      },
    );
  }
}

class introLogo extends StatelessWidget {
  const introLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[400],
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Pantry Pal",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color.fromARGB(197, 211, 199, 177),
      ),
     
      body: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              'assets/recipe.jpg',
            ),
            fit: BoxFit.fill,
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.47),
              BlendMode.dstIn,
            ),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FadingLogo(),
            Padding(padding: EdgeInsets.all(10), child: FadingText()),
            Padding(
              padding: EdgeInsets.all(10),
              child: FloatingButton(),
            ),
          ],
        ),
      ),
    );
  }
}

class FadingLogo extends StatelessWidget {
  const FadingLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return FadingWidgetAnimator(
      duration: const Duration(seconds: 4),
      child: Container(
        decoration:
            BoxDecoration(borderRadius: BorderRadius.circular(20), boxShadow: [
          BoxShadow(blurStyle: BlurStyle.outer, color: Colors.transparent),
        ]),
        child: Image.asset('assets/images/LOGO.png'),
      ),
      curve: Curves.linear,
    );
  }
}

class FadingText extends StatelessWidget {
  const FadingText({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      FadingWidgetAnimator(
          duration: const Duration(seconds: 3),
          startAfter: const Duration(seconds: 3),
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(20)),
            child: FadingWidgetAnimator(
              duration: const Duration(seconds: 3),
              startAfter: const Duration(seconds: 3),
              child: Text(
                "What are you craving?",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(131, 50, 54, 65),
                    fontFamily: AutofillHints.addressCityAndState),
              ),
            ),
          )),
      Padding(padding: EdgeInsets.all(3)),
      FadingWidgetAnimator(
          duration: const Duration(seconds: 3),
          startAfter: const Duration(seconds: 5),
          child: Container(
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(20)),
              child: FadingWidgetAnimator(
                duration: const Duration(seconds: 3),
                startAfter: const Duration(seconds: 5),
                child: Text(
                  "Something Salty? Sweet? We Got You...",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(131, 50, 54, 65),
                      fontFamily: AutofillHints.addressCityAndState),
                ),
              )))
    ]);
  }
}

class FloatingButton extends StatelessWidget {
  const FloatingButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FadingWidgetAnimator(
      child: FloatingWidget(
          verticalSpace: 15,
          duration: const Duration(
            seconds: 3,
          ),
          reverseDuration: const Duration(seconds: 3),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              fixedSize: Size(150, 35),
              backgroundColor: Color.fromARGB(255, 204, 169, 169),
            ),
            child: const Text(
              'LET US COOK!',
              style: TextStyle(
                fontSize: 15,
                color: Colors.white,
              ),
            ),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => RecipeAppHome()));
            },
          )),
      startAfter: const Duration(seconds: 6),
    );
  }
}
