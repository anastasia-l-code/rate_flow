import 'package:flutter/material.dart';
import 'package:rate_flow/app/app_routes_name.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  void _showResult(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }

  Future<void> _sendText(BuildContext context) async {
    final result = await Navigator.pushNamed(
      context,
      AppRoutesName.sendText,
      arguments: 'Текст по умолчанию',
    );
    if (!context.mounted || result is! String) return;
    _showResult(context, result);
  }

  Future<void> _showDialog(BuildContext context) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Подтверждение'),
        content: const Text('Отправлять уведомления о курсах валют?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: const Text('Нет'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            child: const Text('Да'),
          ),
        ],
      ),
    );
    if (!context.mounted || result == null) return;
    _showResult(
      context,
      result ? 'Выбрано: отправлять уведомления' : 'Выбрано: без уведомлений',
    );
  }

  Future<void> _showBottomSheet(BuildContext context) async {
    final result = await showModalBottomSheet<String>(
      context: context,
      builder: (sheetContext) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Padding(
              padding: EdgeInsets.all(16),
              child: Text('Выберите период отображения курсов'),
            ),
            for (final period in ['День', 'Неделя', 'Месяц'])
              ListTile(
                title: Text(period),
                onTap: () => Navigator.pop(sheetContext, period),
              ),
          ],
        ),
      ),
    );
    if (!context.mounted || result == null) return;
    _showResult(context, 'Выбран период: $result');
  }

  Future<void> _pickDate(BuildContext context) async {
    final result = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100, 12, 31),
    );
    if (!context.mounted || result == null) return;
    final date = MaterialLocalizations.of(context).formatFullDate(result);
    _showResult(context, 'Выбрана дата: $date');
  }

  Future<void> _pickTime(BuildContext context) async {
    final result = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (!context.mounted || result == null) return;
    _showResult(context, 'Выбрано время: ${result.format(context)}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Настройки'),
        actions: [
          IconButton(
            tooltip: 'На главный экран',
            icon: const Icon(Icons.home),
            onPressed: () {
              Navigator.of(context).popUntil((route) => route.isFirst);
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(22),
        children: [
          ElevatedButton(
            onPressed: () => _sendText(context),
            child: const Text('Ввести текст'),
          ),
          const SizedBox(height: 12),
          ElevatedButton(
            onPressed: () => _showDialog(context),
            child: const Text('Диалог подтверждения'),
          ),
          const SizedBox(height: 12),
          ElevatedButton(
            onPressed: () => _showBottomSheet(context),
            child: const Text('Нижняя модальная панель'),
          ),
          const SizedBox(height: 12),
          ElevatedButton(
            onPressed: () => _pickDate(context),
            child: const Text('Выбрать дату'),
          ),
          const SizedBox(height: 12),
          ElevatedButton(
            onPressed: () => _pickTime(context),
            child: const Text('Выбрать время'),
          ),
          const SizedBox(height: 12),
          ElevatedButton(
            onPressed: () {
              Navigator.popUntil(
                context,
                ModalRoute.withName(AppRoutesName.main),
              );
            },
            child: const Text('На главную - popUntil'),
          ),
          const SizedBox(height: 12),
          ElevatedButton(
            onPressed: () async {
              final handled = await Navigator.maybePop(context);
              if (!context.mounted) return;
              if (!handled) {
                _showResult(context, 'Возврат не обработан');
              }
            },
            child: const Text('Назад - maybePop'),
          ),
          const SizedBox(height: 12),
          ElevatedButton(
            onPressed: () {
              final canGoBack = Navigator.canPop(context);
              _showResult(
                context,
                canGoBack ? 'Есть предыдущий экран' : 'Вы на корневом экране',
              );
            },
            child: const Text('Проверить canPop'),
          ),
          const SizedBox(height: 12),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamedAndRemoveUntil(
                context,
                AppRoutesName.main,
                (route) => false,
              );
            },
            child: const Text('Начать заново - pushNamedAndRemoveUntil'),
          ),
        ],
      ),
    );
  }
}
