import 'package:flutter/material.dart';
import 'flash_card_home_page.dart';

Future<FlashCard?> showEditFlashCardDialog(
  BuildContext context,
  FlashCard card,
) {
  final questionController = TextEditingController(text: card.question);

  final answerController = TextEditingController(text: card.answer);

  return showDialog<FlashCard>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text("Edit Flashcard"),
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
          ElevatedButton(
            onPressed: () {
              Navigator.pop(
                context,
                FlashCard(
                  question: questionController.text,
                  answer: answerController.text,
                ),
              );
            },
            child: const Text("Save"),
          ),
        ],
      );
    },
  );
}
