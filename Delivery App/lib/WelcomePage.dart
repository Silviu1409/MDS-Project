import 'package:intro_slider/intro_slider.dart';
import 'package:flutter/material.dart';
import 'package:intro_slider/slide_object.dart';
import 'package:intro_slider/scrollbar_behavior_enum.dart';
import 'LoginPage.dart';

class WelcomePageWidget extends StatelessWidget {
  const WelcomePageWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: WelcomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  WelcomePageState createState() => WelcomePageState();
}

class WelcomePageState extends State<WelcomePage> {
  List<Slide> slides = [];

  @override
  void initState() {
    super.initState();

    slides.add(
      Slide(
        backgroundImage: ("images/pizza.png"),
        backgroundImageFit: BoxFit.fill,
        backgroundOpacity: 0,
      ),
    );
    slides.add(
      Slide(
        backgroundImage: ("images/review.png"),
        backgroundImageFit: BoxFit.fill,
        backgroundOpacity: 0,
      ),
    );
    slides.add(
      Slide(
        backgroundImage: ("images/scuter.png"),
        backgroundImageFit: BoxFit.fill,
        backgroundOpacity: 0,
      ),
    );
  }

  void onDonePress() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const LoginPageWidget()),
      ModalRoute.withName("/login"),
    );
  }

  Widget renderNextBtn() {
    return const Icon(
      Icons.navigate_next,
      color: Color(0xffF3B4BA),
    );
  }

  Widget renderDoneBtn() {
    return const Icon(
      Icons.done,
      color: Color(0xffF3B4BA),
    );
  }

  Widget renderSkipBtn() {
    return const Icon(
      Icons.skip_next,
      color: Color(0xffF3B4BA),
    );
  }

  ButtonStyle myButtonStyle() {
    return ButtonStyle(
      shape: MaterialStateProperty.all<OutlinedBorder>(const StadiumBorder()),
      backgroundColor:
          MaterialStateProperty.all<Color>(const Color(0x33F3B4BA)),
      overlayColor: MaterialStateProperty.all<Color>(const Color(0x33FFA8B0)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: IntroSlider(
        slides: slides,
        renderSkipBtn: renderSkipBtn(),
        skipButtonStyle: myButtonStyle(),
        renderNextBtn: renderNextBtn(),
        nextButtonStyle: myButtonStyle(),
        renderDoneBtn: renderDoneBtn(),
        onDonePress: onDonePress,
        doneButtonStyle: myButtonStyle(),
        colorDot: const Color(0x33FFA8B0),
        colorActiveDot: const Color(0xffFFA8B0),
        sizeDot: 15.0,
        hideStatusBar: true,
        backgroundColorAllSlides: Colors.transparent,
        verticalScrollbarBehavior: scrollbarBehavior.SHOW_ALWAYS,
      ),
    );
  }
}
