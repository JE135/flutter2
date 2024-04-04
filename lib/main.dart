import 'dart:math';
import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const DiceRoller(),
    ));

class DiceRoller extends StatefulWidget {
  const DiceRoller({Key? key}) : super(key: key);

  @override
  _DiceRollerState createState() => _DiceRollerState();
}

class _DiceRollerState extends State<DiceRoller> {
  int dice1 = 1;
  int dice2 = 1;
  int dice3 = 1;
  int dice4 = 1;
  int dice5 = 1;
  int dice6 = 1;
  int dice7 = 1;
  int dice8 = 1; // Use int for the coin flip, initialized to 1
  int extraValue = 0;
  int lastDiceRolled = 0;
  bool rolled = false;

  void rollDice(int diceNumber) {
    setState(() {
      rolled = true;
      switch (diceNumber) {
        case 1:
          dice1 = Random().nextInt(4) + 1;
          lastDiceRolled = dice1;
          break;
        case 2:
          dice2 = Random().nextInt(6) + 1;
          lastDiceRolled = dice2;
          break;
        case 3:
          dice3 = Random().nextInt(8) + 1;
          lastDiceRolled = dice3;
          break;
        case 4:
          dice4 = Random().nextInt(10) + 1;
          lastDiceRolled = dice4;
          break;
        case 5:
          dice5 = Random().nextInt(12) + 1;
          lastDiceRolled = dice5;
          break;
        case 6:
          dice6 = Random().nextInt(20) + 1;
          lastDiceRolled = dice6;
          break;
        case 7:
          dice7 = Random().nextInt(100) + 1;
          lastDiceRolled = dice7;
          break;
        case 8:
          dice8 = Random().nextInt(2) + 1; // Represent coin flip as 1 or 2
          lastDiceRolled = dice8 == 1
              ? 0
              : 1; // Convert dice8 to 0 or 1 for display if needed
          break;
        default:
          break;
      }
    });
  }

  int get sum => lastDiceRolled + extraValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dice Roller'),
        centerTitle: true,
        backgroundColor: Colors.orange[200],
      ),
      body: Column(
        children: <Widget>[
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              _DiceButton(
                imagePath: 'assets/d4.png',
                value: dice1,
                onPressed: () => rollDice(1),
              ),
              _DiceButton(
                imagePath: 'assets/d6.webp',
                value: dice2,
                onPressed: () => rollDice(2),
              ),
              _DiceButton(
                imagePath: 'assets/d8.webp',
                value: dice3,
                onPressed: () => rollDice(3),
              ),
              _DiceButton(
                imagePath: 'assets/d10.jpg',
                value: dice4,
                onPressed: () => rollDice(4),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              _DiceButton(
                imagePath: 'assets/d12.webp',
                value: dice5,
                onPressed: () => rollDice(5),
              ),
              _DiceButton(
                imagePath: 'assets/d20.jpg',
                value: dice6,
                onPressed: () => rollDice(6),
              ),
              _DiceButton(
                imagePath: 'assets/d100.jpg',
                value: dice7,
                onPressed: () => rollDice(7),
              ),
              _DiceButton(
                imagePath: 'assets/coinflip.jpg',
                value: dice8,
                onPressed: () => rollDice(8),
              ),
            ],
          ),
          const SizedBox(height: 50),
          Text(
            'Result: ${rolled ? sum : ''}',
            style: const TextStyle(fontSize: 30),
          ),
          const SizedBox(height: 20),
          Text(
            'Extra: $extraValue',
            style: const TextStyle(fontSize: 30),
          ),
        ],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(right: 20, bottom: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FloatingActionButton(
                  onPressed: () {
                    setState(() {
                      extraValue++;
                    });
                  },
                  child: const Icon(Icons.add),
                ),
                const SizedBox(width: 10),
                FloatingActionButton(
                  onPressed: () {
                    setState(() {
                      if (extraValue > 0) {
                        extraValue--;
                      }
                    });
                  },
                  child: const Icon(Icons.remove),
                ),
                const SizedBox(width: 10),
                FloatingActionButton(
                  onPressed: () {
                    setState(() {
                      dice1 = 1;
                      dice2 = 1;
                      dice3 = 1;
                      dice4 = 1;
                      dice5 = 1;
                      dice6 = 1;
                      dice7 = 1;
                      dice8 = 1; // Reset this too
                      extraValue = 0;
                      lastDiceRolled = 0;
                      rolled = false;
                    });
                  },
                  child: const Text("Clear"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _DiceButton extends StatelessWidget {
  final String imagePath;
  final int value;
  final VoidCallback onPressed;

  const _DiceButton({
    Key? key,
    required this.imagePath,
    required this.value,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
      child: SizedBox(
        width: 50,
        height: 50,
        child: Image.asset(
          imagePath,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
