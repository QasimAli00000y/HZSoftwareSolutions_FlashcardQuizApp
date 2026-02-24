import 'package:flutter/material.dart';
import 'flash_card_home_page.dart';

Future<FlashCard?> showAddFlashCardDialog(BuildContext context) {
  final questionController = TextEditingController();
  final answerController = TextEditingController();

  return showDialog<FlashCard>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text("Add Flash Card"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: questionController,
              decoration: const InputDecoration(labelText: "Question"),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: answerController,
              decoration: const InputDecoration(labelText: "Answer"),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              if (questionController.text.isNotEmpty &&
                  answerController.text.isNotEmpty) {
                Navigator.pop(
                  context,
                  FlashCard(
                    question: questionController.text,
                    answer: answerController.text,
                  ),
                );
              }
            },
            child: const Text("Add"),
          ),
        ],
      );
    },
  );
}
