import 'package:flashcard/add_flash_card.dart';
import 'package:flutter/material.dart';
import 'edit_flash_card.dart';

class FlashCard {
  String question;
  String answer;

  FlashCard({required this.question, required this.answer});
}

class FlashCardHomePage extends StatefulWidget {
  const FlashCardHomePage({super.key});

  @override
  State<FlashCardHomePage> createState() => _FlashCardHomePageState();
}

class _FlashCardHomePageState extends State<FlashCardHomePage> {
  List<FlashCard> flashcard = [
    FlashCard(question: "What is the capital of Pakistan", answer: "Islamabad"),
    FlashCard(question: "What is the capital of Punjab", answer: "Lahore")
  ];
  void _addFlashCard() async {
    final newCard = await showAddFlashCardDialog(context);

    if (newCard != null) {
      setState(() {
        flashcard.add(newCard);
      });
    }
  }

  void editFlashCard() async {
    final updatedCard = await showEditFlashCardDialog(
      context,
      flashcard[currentIndex],
    );

    if (updatedCard != null) {
      setState(() {
        flashcard[currentIndex] = updatedCard;
      });
    }
  }

  void deleteFlashCard() {
    if (flashcard.isEmpty) return;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Delete Flashcard"),
          content: const Text("Are you sure you want to delete this card?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  flashcard.removeAt(currentIndex);
                  if (currentIndex >= flashcard.length) {
                    currentIndex = flashcard.length - 1;
                  }

                  if (currentIndex < 0) {
                    currentIndex = 0;
                  }

                  showAnswer = false;
                });

                Navigator.pop(context);
              },
              child: const Text("Delete"),
            ),
          ],
        );
      },
    );
  }

  int currentIndex = 0;
  bool showAnswer = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Flash Card App"),
        actions: [
          IconButton(
            onPressed: editFlashCard,
            icon: const Icon(Icons.edit),
          ),
          IconButton(
            onPressed: deleteFlashCard,
            icon: const Icon(Icons.delete),
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: GestureDetector(
                onDoubleTap: () {
                  setState(() {
                    showAnswer = !showAnswer;
                  });
                },
                child: Card(
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: LinearGradient(
                        colors: showAnswer
                            ? [Colors.green.shade300, Colors.green.shade600]
                            : [Colors.blue.shade300, Colors.blue.shade600],
                      ),
                    ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(30),
                        child: Text(
                          showAnswer
                              ? flashcard[currentIndex].answer
                              : flashcard[currentIndex].question,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            showAnswer
                ? "Double tap to see question"
                : "Double tap to see answer",
            style: const TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: currentIndex > 0
                    ? () {
                        setState(() {
                          currentIndex--;
                          showAnswer = false;
                        });
                      }
                    : null,
                child: const Text("Previous"),
              ),
              ElevatedButton(
                onPressed: currentIndex < flashcard.length - 1
                    ? () {
                        setState(() {
                          currentIndex++;
                          showAnswer = false;
                        });
                      }
                    : null,
                child: const Text("Next"),
              ),
            ],
          ),
          const SizedBox(height: 5),
          ElevatedButton.icon(
            onPressed: _addFlashCard,
            icon: const Icon(Icons.add),
            label: const Text("Add Flash Card"),
          ),
          const SizedBox(height: 15),
        ],
      ),
    );
  }
}
