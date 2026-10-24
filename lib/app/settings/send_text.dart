import 'package:flutter/material.dart';

class SendTextPage extends StatefulWidget {
  const SendTextPage({super.key});

  @override
  State<SendTextPage> createState() => _SendTextPageState();
}

class _SendTextPageState extends State<SendTextPage> {
  String _text = '';

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
      appBar: AppBar(title: const Text('Ввод текста')),
      body: Padding(
        padding: const EdgeInsets.all(22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
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
