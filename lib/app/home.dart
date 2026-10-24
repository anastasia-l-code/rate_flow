import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rate_flow/app/currency_list/currency_list_page.dart';
import 'package:rate_flow/app/news_list/news_list_page.dart';

class HomeCubit extends Cubit<int> {
  HomeCubit() : super(0);

  void selectTab(int index) => emit(index);
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static const List<Widget> _pages = <Widget>[
    CurrencyListPage(),
    NewsListPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeCubit(),
      child: BlocBuilder<HomeCubit, int>(
        builder: (context, selectedIndex) {
          return Scaffold(
            body: _pages[selectedIndex],
            bottomNavigationBar: Container(
              decoration: const BoxDecoration(
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 25,
                    offset: Offset(0.0, 0.75),
                  ),
                ],
              ),
              child: BottomNavigationBar(
                currentIndex: selectedIndex,
                onTap: context.read<HomeCubit>().selectTab,
                items: [
                  BottomNavigationBarItem(
                    icon: TabWidget(
                      assetPath: 'assets/icons/home.png',
                      isSelected: selectedIndex == 0,
                    ),
                    label: 'Курс Валют',
                  ),
                  BottomNavigationBarItem(
                    icon: TabWidget(
                      assetPath: 'assets/icons/news.png',
                      isSelected: selectedIndex == 1,
                    ),
                    label: 'Новости',
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

/// Отображает иконку вкладки нижнего меню и меняет её цвет
/// в зависимости от того, выбрана ли вкладка, используя цвета темы.
class TabWidget extends StatelessWidget {
  const TabWidget({
    super.key,
    required this.assetPath,
    required this.isSelected,
  });

  final String assetPath;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    final BottomNavigationBarThemeData bottomBarTheme = Theme.of(context)
        .bottomNavigationBarTheme;

    return SizedBox.square(
      dimension: 24,
      child: Image.asset(
        assetPath,
        color: isSelected
            ? bottomBarTheme.selectedItemColor
            : bottomBarTheme.unselectedItemColor,
      ),
    );
  }
}
