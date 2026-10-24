import 'package:flutter/material.dart';
import 'package:rate_flow/app/app_routes_name.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Настройки')),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            final result = await Navigator.pushNamed(
              context,
              AppRoutesName.sendText,
            );
            if (!context.mounted || result is! String) return;
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(result)));
          },
          child: const Text('Ввести текст'),
        ),
      ),
    );
  }
}
