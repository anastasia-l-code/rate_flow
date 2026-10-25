import 'package:flutter/material.dart';

class SendTextPage extends StatefulWidget {
  const SendTextPage({super.key, required this.initialText});

  final String initialText;

  @override
  State<SendTextPage> createState() => _SendTextPageState();
}

class _SendTextPageState extends State<SendTextPage> {
  late String _text = widget.initialText;

  void _send() {
    final text = _text.trim();
    if (text.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Введите текст')));
      return;
    }
    Navigator.pop(context, text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ввод текста'),
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
      body: Padding(
        padding: const EdgeInsets.all(22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              initialValue: _text,
              onChanged: (value) => _text = value,
              decoration: const InputDecoration(
                labelText: 'Текст',
                border: OutlineInputBorder(),
              ),
              textCapitalization: TextCapitalization.sentences,
              textInputAction: TextInputAction.done,
              onFieldSubmitted: (_) => _send(),
            ),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: _send, child: const Text('Отправить')),
          ],
        ),
      ),
    );
  }
}
