import 'package:flutter/material.dart';
import 'package:rate_flow/app/home.dart';
import 'package:rate_flow/app/app_routes_name.dart';
import 'package:rate_flow/app/currency_detail/currency_detail_page.dart';
import 'package:rate_flow/app/settings/settings_page.dart';
import 'package:rate_flow/app/settings/send_text.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF3929C7);
    const backgroundColor = Color(0xFFf2f2f2);
    const secondaryColor = Color(0xFF7F7F7F);

    return MaterialApp(
      theme: ThemeData(
        primaryColor: primaryColor,
        scaffoldBackgroundColor: backgroundColor,
        appBarTheme: AppBarTheme(
          backgroundColor: backgroundColor,
          titleTextStyle: TextStyle(
            fontFamily: 'Inter',
            fontSize: 16,
            color: Colors.black,
          ),
          centerTitle: true,
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Colors.white,
          selectedItemColor: primaryColor,
          unselectedItemColor: secondaryColor,
          selectedLabelStyle: TextStyle(
            fontFamily: 'Inter',
            fontSize: 12,
            color: primaryColor,
          ),
          unselectedLabelStyle: TextStyle(
            fontFamily: 'Inter',
            fontSize: 12,
            color: secondaryColor,
          ),
        ),
      ),

      initialRoute: AppRoutesName.main,
      routes: {
        AppRoutesName.main: (_) => const HomePage(),
        AppRoutesName.settings: (_) => const SettingsPage(),
        AppRoutesName.currency: (context) {
          final title =
              ModalRoute.of(context)!.settings.arguments as String? ?? 'Валюта';
          return CurrencyDetailPage(title: title);
        },
      },
      onGenerateRoute: (settings) {
        if (settings.name != AppRoutesName.sendText) return null;
        final text = settings.arguments as String? ?? '';
        return PageRouteBuilder<String>(
          settings: settings,
          transitionDuration: const Duration(milliseconds: 500),
          reverseTransitionDuration: const Duration(milliseconds: 500),
          pageBuilder: (_, animation, secondaryAnimation) =>
              SendTextPage(initialText: text),
          transitionsBuilder: (_, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          },
        );
      },
    );
  }
}
