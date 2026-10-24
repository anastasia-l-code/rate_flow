import 'package:flutter/material.dart';
import 'package:rate_flow/app/currency_list/widgets/currency_card.dart';
import 'package:rate_flow/app/currency_list/widgets/search_view.dart';

class CurrencyListPage extends StatelessWidget {
  const CurrencyListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context)
        .size
        .width; // Узнаем ширину экрана
    final int crossAxisCount = screenWidth > 500 ? 2 : 1;

    return Scaffold(
      appBar: AppBar(title: Text('Курс Валют')),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(22, 10, 22, 40),
        child: Column(
          children: [
            const SearchView(),
            const SizedBox(height: 30),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  mainAxisSpacing: 10, // Отступ между карточками по вертикали
                  crossAxisSpacing: 10, // Отступ по горизонтали
                  mainAxisExtent: 68, // Фиксированная высота карточки
                ),
                itemCount: 20,
                itemBuilder: (BuildContext context, int index) {
                  return CurrencyCard(index: index, subtitle: 'Подзаголовок');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
