import 'package:flutter/material.dart';
import 'declare.dart';

class PageAccueil extends StatefulWidget {
  const PageAccueil({super.key});

  @override
  State<PageAccueil> createState() => _PageAccueilState();
}

class _PageAccueilState extends State<PageAccueil>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Color?> _colorAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat(reverse: true);

    _colorAnimation = ColorTween(
      begin: Colors.pink[300],
      end: Colors.purple[400],
    ).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.pink[50]!, Colors.purple[50]!, Colors.blue[50]!],
          ),
        ),
        child: Center(
          child: AnimatedBuilder(
            animation: _colorAnimation,
            builder: (context, child) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.favorite, size: 80, color: _colorAnimation.value),
                  const SizedBox(height: 30),
                  Text(
                    'Mon Cœur pour Toi',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: _colorAnimation.value,
                      fontFamily: 'PlayfairDisplay',
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Text(
                      'Rihanna,\n\nDans ce petit monde numérique se cache tout ce que mon cœur ressent pour toi. Des mots, des émotions, et cette musique qui dit ce que parfois ma voix n\'arrive pas à exprimer.\n\nTu es celle qui illumine mes jours et adoucit mes nuits.',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey[700],
                        height: 1.5,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 40),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const PagePoeme(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _colorAnimation.value,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 40,
                        vertical: 16,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      elevation: 8,
                      shadowColor: Colors.pink[200],
                    ),
                    child: const Text(
                      'C\'est parti 💕',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
