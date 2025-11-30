import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class PagePoeme extends StatefulWidget {
  const PagePoeme({super.key});

  @override
  State<PagePoeme> createState() => _PagePoemeState();
}

class _PagePoemeState extends State<PagePoeme>
    with SingleTickerProviderStateMixin {
  final List<String> _vers = [
    "🌹 Poème pour Rihanna Finunu — \"Mon Cœur Sous l'Armure\"",
    "",
    "Rihanna, mon amour,",
    "Je ne parle pas souvent,",
    "Je garde trop de choses derrière mes murs,",
    "Mais avec toi, même le silence devient vivant.",
    "",
    "Tu dis que je fais comme Batman,",
    "Que je cache tout dans l'ombre,",
    "Mais sache que dans le noir où je me tiens,",
    "Ton nom est la seule lumière qui compte.",
    "",
    "J'ai le cœur blindé,",
    "La voix serrée,",
    "Le regard fort…",
    "Mais devant toi, tout se brise sans effort.",
    "",
    "Tu es la paix dans mes tempêtes,",
    "La douceur dans mes batailles,",
    "La vérité que même mon masque ne peut cacher.",
    "Avec toi, je ne me sens ni faible, ni vulnérable :",
    "Je me sens complet.",
    "",
    "All of me loves all of you,",
    "Et si tu pouvais lire mes pensées,",
    "Tu verrais que chaque battement porte ton visage,",
    "Chaque silence porte ton nom,",
    "Chaque demain que j'imagine commence avec toi.",
    "",
    "Rihanna Finunu,",
    "Tu es ce que même un cœur protégé ne peut retenir,",
    "Ce que même la nuit ne peut éteindre.",
    "Tu es mon refuge, mon choix, mon évidence.",
    "Et si je suis Batman…",
    "Alors toi, tu es la seule personne",
    "Devant qui je retire l'armure.",
    "",
    "Je t'aime.",
    "Sans ombre, sans masque, sans peur.",
    "Je t'aime entièrement.",
  ];

  int _currentIndex = 0;
  late AnimationController _textController;
  late Animation<double> _textAnimation;
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool _musicStarted = false;

  @override
  void initState() {
    super.initState();
    _textController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _textAnimation = CurvedAnimation(
      parent: _textController,
      curve: Curves.easeIn,
    );

    _startTextAnimation();
    _playBackgroundMusic();
  }

  void _startTextAnimation() {
    Future.delayed(const Duration(milliseconds: 500), () {
      if (_currentIndex < _vers.length) {
        _textController.forward().then((_) {
          _textController.reset();
          Future.delayed(const Duration(milliseconds: 500), () {
            setState(() {
              _currentIndex++;
            });
            _startTextAnimation();
          });
        });
      }
    });
  }

  Future<void> _playBackgroundMusic() async {
    if (!_musicStarted) {
      try {
        // Remplacez par le chemin de votre fichier audio
        await _audioPlayer.play(AssetSource('all of me.m4a'));
        _musicStarted = true;
      } catch (e) {
        print('Erreur de lecture audio: $e');
      }
    }
  }

  @override
  void dispose() {
    _textController.dispose();
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.purple[900]!,
              Colors.pink[700]!,
              Colors.deepPurple[900]!,
            ],
          ),
        ),
        child: Stack(
          children: [
            // Animation de fond romantique
            Positioned.fill(
              child: CustomPaint(painter: _RomanticBackgroundPainter()),
            ),

            // Contenu principal
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  AppBar(
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    leading: IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () {
                        _audioPlayer.stop();
                        Navigator.pop(context);
                      },
                    ),
                    title: const Text(
                      'Pour Rihanna',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'PlayfairDisplay',
                      ),
                    ),
                  ),

                  Expanded(
                    child: Center(
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            for (int i = 0; i < _currentIndex; i++)
                              _buildAnimatedLine(_vers[i], i),

                            if (_currentIndex < _vers.length)
                              _buildCurrentLine(_vers[_currentIndex]),
                          ],
                        ),
                      ),
                    ),
                  ),

                  // Indicateur de progression
                  LinearProgressIndicator(
                    value: _currentIndex / _vers.length,
                    backgroundColor: Colors.white24,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Colors.pink[300]!,
                    ),
                  ),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAnimatedLine(String text, int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Text(
        text,
        style: TextStyle(
          fontSize: _getFontSize(text),
          color: Colors.white,
          fontWeight: _getFontWeight(text),
          fontFamily: 'PlayfairDisplay',
          height: 1.4,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildCurrentLine(String text) {
    return AnimatedBuilder(
      animation: _textAnimation,
      builder: (context, child) {
        return Opacity(
          opacity: _textAnimation.value,
          child: Transform.translate(
            offset: Offset(0, 10 * (1 - _textAnimation.value)),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Text(
                text,
                style: TextStyle(
                  fontSize: _getFontSize(text),
                  color: Colors.white,
                  fontWeight: _getFontWeight(text),
                  fontFamily: 'PlayfairDisplay',
                  height: 1.4,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        );
      },
    );
  }

  double _getFontSize(String text) {
    if (text.contains('🌹') || text.contains('Rihanna Finunu')) {
      return 20;
    } else if (text.isEmpty) {
      return 8;
    }
    return 16;
  }

  FontWeight _getFontWeight(String text) {
    if (text.contains('🌹') ||
        text.contains('Je t\'aime') ||
        text.contains('Rihanna Finunu')) {
      return FontWeight.bold;
    }
    return FontWeight.normal;
  }
}

class _RomanticBackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.pink.withOpacity(0.1)
      ..style = PaintingStyle.fill;

    // Dessiner des cœurs en arrière-plan
    for (int i = 0; i < 10; i++) {
      final x = size.width * (0.1 + 0.8 * (i / 10));
      final y = size.height * (0.2 + 0.6 * ((i * 3) % 10) / 10);
      _drawHeart(canvas, Offset(x, y), 20.0, paint);
    }
  }

  void _drawHeart(Canvas canvas, Offset center, double size, Paint paint) {
    final path = Path();

    path.moveTo(center.dx, center.dy + size / 4);

    path.cubicTo(
      center.dx - size / 2,
      center.dy - size / 2,
      center.dx + size,
      center.dy - size,
      center.dx,
      center.dy + size,
    );

    path.cubicTo(
      center.dx - size,
      center.dy - size,
      center.dx + size / 2,
      center.dy - size / 2,
      center.dx,
      center.dy + size / 4,
    );

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
