import 'package:flutter/material.dart';
import 'package:rate_flow/app/app_routes_name.dart';

class CurrencyCard extends StatelessWidget {
  const CurrencyCard({super.key, required this.index, this.subtitle});

  final int index;
  final String? subtitle; //обьявляем необязательный подзаголовок

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(
          context,
        ).pushNamed(AppRoutesName.currency, arguments: 'Австралийский доллар');
      },
      child: Card(
        margin: EdgeInsets.zero,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
          child: Row(
            children: [
              CurrencyIcon(title: 'AUD'),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Австралийский доллар',
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                        ),
                      ),
                      if (subtitle != null && subtitle!.isNotEmpty)
                        // проверяем есть ли подзаголовок
                        Text(
                          subtitle!,
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: Colors.grey,
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 6),
                child: Text(
                  '60.99',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF1FD522),
                  ),
                ),
              ),
              Image.asset('assets/icons/arrow_up.png', width: 10, height: 10),
              const SizedBox(width: 8),
              Icon(
                index % 2 == 0 ? Icons.favorite : Icons.favorite_border,
                color: index % 2 == 0 ? Colors.red : Colors.grey,
                size: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CurrencyIcon extends StatelessWidget {
  const CurrencyIcon({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 20,
      backgroundColor: Theme.of(context).primaryColor,
      child: Text(
        title,
        style: const TextStyle(
          fontFamily: 'InterTight',
          fontSize: 12,
          fontWeight: FontWeight.w700,
          color: Colors.white,
        ),
      ),
    );
  }
}
