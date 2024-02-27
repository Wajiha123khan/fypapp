import 'package:flutter/material.dart';

const themeprimarycolor = Colors.white;
const backgroundcolor = Color.fromARGB(255, 250, 250, 250);
const blackcolor = Colors.black;
const bluecolor = Color.fromARGB(255, 6, 93, 165);
const greycolor = Colors.grey;
const redcolor = Colors.red;

class Palette {
  static const MaterialColor themecolor = const MaterialColor(
    // 0xFF14b9a1, // 0% comes in here, this will be color picked if no shade is selected when defining a Color property which doesn’t require a swatch.
    0xFF302ea7, // 0% comes in here, this will be color picked if no shade is selected when defining a Color property which doesn’t require a swatch.

    const <int, Color>{
      50: const Color(0xFF132342), //10%
      100: const Color(0xFF132342), //20%
      200: const Color(0xFF132342), //30%
      300: const Color(0xFF132342), //40%
      400: const Color(0xFF132342), //50%
      500: const Color(0xFF132342), //60%
      600: const Color(0xFF132342), //70%
      700: const Color(0xFF132342), //80%
      800: const Color(0xFF132342), //90%
      900: const Color(0xFF132342), //100%
    },
  );
  static const MaterialColor themecolor2 = const MaterialColor(
    0xFF5454b6, // 0% comes in here, this will be color picked if no shade is selected when defining a Color property which doesn’t require a swatch.
    const <int, Color>{
      50: const Color(0xFF2EA5FF), //10%
      100: const Color(0xFF2EA5FF), //20%
      200: const Color(0xFF2EA5FF), //30%
      300: const Color(0xFF2EA5FF), //40%
      400: const Color(0xFF2EA5FF), //50%
      500: const Color(0xFF2EA5FF), //60%
      600: const Color(0xFF2EA5FF), //70%
      700: const Color(0xFF2EA5FF), //80%
      800: const Color(0xFF2EA5FF), //90%
      900: const Color(0xFF2EA5FF), //100%
    },
  );
}

const themeblackcolor = Color(0xff101010);
const themewhitecolor = Colors.white;
const themegreycolor = Color(0xffE0E0E0);
const themelightgreycolor = Color.fromARGB(255, 244, 244, 244);
const themegreytextcolor = Color(0xff959595);
const themedarkgreycolor = Color(0xff333333);
const themeredcolor = Color(0xffE00000);
const themeyellowcolor = Color(0xffFAB639);
const themeorangecolor = Color(0xffFFA03A);
const themegreencolor = Color(0xff9ED4B5);
const themeauthbuttoncolor = Color(0xff8E7F47);
const themebluecolor = Color(0xff246BFD);
const themetextfieldcolor = Color(0xffF4F4F4);
const themebrowncolor = Color(0xffC68304);
const themepurplecolor = Color(0xff7698AF);
const themelightbrowncolor = Color(0xffC8A575);
const themebrown2color = Color(0xff836A57);
const themepinkcolor = Color(0xffF0768B);
const themedarkbluecolor = Color(0xff0E2936);
const themelightgreencolor = Color(0xffB2CCB3);
