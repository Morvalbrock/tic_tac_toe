import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GameScreeen extends StatefulWidget {
  const GameScreeen({super.key});

  @override
  State<GameScreeen> createState() => _GameScreeenState();
}

class _GameScreeenState extends State<GameScreeen> {
  List<String> dispalyXO = [
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    '',
  ];
  List<int> matchIndexes = [];
  String resultDeclaration = '';
  int oScore = 0;
  int xscore = 0;
  int filledBoxes = 0;
  bool oTurn = true;
  bool winnerFound = false;

  static const maxSeconds = 30;
  int seconds = maxSeconds;
  Timer? timer;
  int attems = 0;
  void startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (_) {
      setState(() {
        if (seconds > 0) {
          seconds--;
        } else {
          stopTimer();
        }
      });
    });
  }

  void stopTimer() {
    resetTimer();
    timer?.cancel();
  }

  void resetTimer() {
    seconds = maxSeconds;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'Player 0',
                          style: GoogleFonts.coiny(
                            textStyle: const TextStyle(
                                fontSize: 25.0, color: Colors.white),
                          ),
                        ),
                        Text(
                          oScore.toString(),
                          style: GoogleFonts.coiny(
                            textStyle: const TextStyle(
                                fontSize: 25.0, color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'Player X',
                          style: GoogleFonts.coiny(
                            textStyle: const TextStyle(
                                fontSize: 25.0, color: Colors.white),
                          ),
                        ),
                        Text(
                          xscore.toString(),
                          style: GoogleFonts.coiny(
                            textStyle: const TextStyle(
                                fontSize: 25.0, color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 5,
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3),
                itemCount: 9,
                itemBuilder: (context, index) => GestureDetector(
                  onTap: () {
                    _tapped(index);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                        width: 5,
                        color: Colors.red,
                      ),
                      color: matchIndexes.contains(index)
                          ? const Color.fromARGB(255, 3, 98, 175)
                          : const Color.fromARGB(255, 253, 176, 44),
                    ),
                    child: Center(
                      child: Text(
                        dispalyXO[index],
                        style: GoogleFonts.coiny(
                          textStyle: const TextStyle(
                            fontSize: 64.0,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      resultDeclaration,
                      style: GoogleFonts.coiny(
                        textStyle: const TextStyle(
                            fontSize: 25.0, color: Colors.white),
                      ),
                    ),
                    const SizedBox(
                      height: 25.0,
                    ),
                    _buildTimer(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _tapped(int index) {
    final isRunning = timer == null ? false : timer!.isActive;
    if (isRunning) {
      setState(() {
        if (oTurn && dispalyXO[index] == '') {
          dispalyXO[index] = 'O';
          filledBoxes++;
        } else if (!oTurn && dispalyXO[index] == '') {
          dispalyXO[index] = 'X';
          filledBoxes++;
        }
        oTurn = !oTurn;
        _checkWinner();
      });
    }
  }

  void _checkWinner() {
    //check 1 row
    if (dispalyXO[0] == dispalyXO[1] &&
        dispalyXO[1] == dispalyXO[2] &&
        dispalyXO[0] != '') {
      setState(() {
        resultDeclaration = 'Player ' + dispalyXO[0] + ' Wins!';
        matchIndexes.addAll([0, 1, 2]);
        stopTimer();
        _updateScore(dispalyXO[0]);
      });
    }
    //check 2 row
    if (dispalyXO[3] == dispalyXO[4] &&
        dispalyXO[3] == dispalyXO[5] &&
        dispalyXO[3] != '') {
      setState(() {
        resultDeclaration = 'Player ' + dispalyXO[3] + ' Wins!';
        matchIndexes.addAll([3, 4, 5]);
        stopTimer();
        _updateScore(dispalyXO[3]);
      });
    }

    //check 3 row
    if (dispalyXO[6] == dispalyXO[7] &&
        dispalyXO[6] == dispalyXO[8] &&
        dispalyXO[6] != '') {
      setState(() {
        resultDeclaration = 'Player ' + dispalyXO[6] + ' Wins!';
        matchIndexes.addAll([6, 7, 8]);
        stopTimer();
        _updateScore(dispalyXO[6]);
      });
    }
    //check 1 column
    if (dispalyXO[0] == dispalyXO[3] &&
        dispalyXO[0] == dispalyXO[6] &&
        dispalyXO[0] != '') {
      setState(() {
        resultDeclaration = 'Player ' + dispalyXO[0] + ' Wins!';
        matchIndexes.addAll([0, 3, 6]);
        stopTimer();
        _updateScore(dispalyXO[0]);
      });
    }
    //check 2 column
    if (dispalyXO[1] == dispalyXO[4] &&
        dispalyXO[1] == dispalyXO[7] &&
        dispalyXO[1] != '') {
      setState(() {
        resultDeclaration = 'Player ' + dispalyXO[1] + ' Wins!';
        matchIndexes.addAll([1, 4, 7]);
        stopTimer();
        _updateScore(dispalyXO[1]);
      });
    }
    //check 3 column
    if (dispalyXO[2] == dispalyXO[5] &&
        dispalyXO[2] == dispalyXO[8] &&
        dispalyXO[2] != '') {
      setState(() {
        resultDeclaration = 'Player ' + dispalyXO[2] + ' Wins!';
        matchIndexes.addAll([2, 5, 8]);
        stopTimer();
        _updateScore(dispalyXO[2]);
      });
    }
    //check diagonal
    if (dispalyXO[0] == dispalyXO[4] &&
        dispalyXO[0] == dispalyXO[8] &&
        dispalyXO[0] != '') {
      setState(() {
        resultDeclaration = 'Player ' + dispalyXO[0] + ' Wins!';
        matchIndexes.addAll([0, 4, 8]);
        stopTimer();
        _updateScore(dispalyXO[0]);
      });
    }
    //check diagonal
    if (dispalyXO[6] == dispalyXO[4] &&
        dispalyXO[6] == dispalyXO[2] &&
        dispalyXO[6] != '') {
      setState(() {
        resultDeclaration = 'Player ' + dispalyXO[6] + ' Wins!';
        matchIndexes.addAll([6, 4, 2]);
        stopTimer();
        _updateScore(dispalyXO[6]);
      });
    }
    if (!winnerFound && filledBoxes == 9) {
      setState(() {
        resultDeclaration = 'Noboby Wins!';
      });
    }
  }

  void _updateScore(String winner) {
    if (winner == 'O') {
      oScore++;
    } else if (winner == 'X') {
      xscore++;
    }
    winnerFound = true;
  }

  void _clearBoard() {
    setState(() {
      for (int i = 0; i < 9; i++) {
        dispalyXO[i] = '';
      }
      resultDeclaration = '';
    });
    filledBoxes = 0;
  }

  Widget _buildTimer() {
    final isRunning = timer == null ? false : timer!.isActive;
    return isRunning
        ? SizedBox(
            width: 100,
            height: 100,
            child: Stack(
              fit: StackFit.expand,
              children: [
                CircularProgressIndicator(
                  value: 1 - seconds / maxSeconds,
                  valueColor: const AlwaysStoppedAnimation(Colors.white),
                  strokeWidth: 8,
                  backgroundColor: const Color.fromARGB(255, 5, 136, 243),
                ),
                Center(
                  child: Text(
                    '$seconds',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 50,
                    ),
                  ),
                ),
              ],
            ),
          )
        : ElevatedButton(
            onPressed: () {
              startTimer();
              _clearBoard();
              attems++;
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              padding:
                  const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
            ),
            child: Text(
              attems == 0 ? 'Start' : 'Play Again',
              style: const TextStyle(fontSize: 20, color: Colors.black),
            ),
          );
  }
}
