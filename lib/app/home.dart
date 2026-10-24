import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rate_flow/app/currency_list/currency_list_page.dart';
import 'package:rate_flow/app/news_list/news_list_page.dart';
import 'package:rate_flow/app/currency_detail/currency_detail_page.dart';

/// Хранит состояние главного экрана: выбранную вкладку и название открытой валюты.
/// Если currencyTitle равен null, экран подробностей валюты закрыт.
class HomeState {
  const HomeState({this.selectedIndex = 0, this.currencyTitle});

  final int selectedIndex;
  final String? currencyTitle;
}

/// Управляет состоянием главного экрана: переключает вкладки, открывает
/// и закрывает подробности валюты. Через emit уведомляет интерфейс об изменениях.
class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(const HomeState());

  void selectTab(int index) => emit(HomeState(selectedIndex: index));

  void openCurrency(String title) =>
      emit(HomeState(selectedIndex: state.selectedIndex, currencyTitle: title));

  void closeCurrency() => emit(HomeState(selectedIndex: state.selectedIndex));
}

/// Создаёт HomeCubit и строит главный экран на основе его состояния:
/// показывает выбранную вкладку, нижнее меню и подробности валюты поверх экрана.
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static const List<Widget> _pages = <Widget>[
    CurrencyListPage(),
    NewsListPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(),
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, homeState) {
          final selectedIndex = homeState.selectedIndex;
          final currencyTitle = homeState.currencyTitle;
          return Stack(
            fit: StackFit.expand,
            children: [
              Scaffold(
                // Показываем экран, соответствующий выбранной вкладке.
                body: _pages[selectedIndex],
                bottomNavigationBar: Container(
                  decoration: BoxDecoration(
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
              ),
              if (currencyTitle != null)
                CurrencyDetailPage(title: currencyTitle),
            ],
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
