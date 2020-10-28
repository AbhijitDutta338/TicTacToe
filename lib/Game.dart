import 'package:flutter/material.dart';
import 'package:tictactoe/GameButton.dart';
import 'package:tictactoe/custom_dialog.dart';
import 'minmax.dart';

class Game extends StatefulWidget {
  @override
  _GameState createState() => new _GameState();
}

class _GameState extends State<Game> {
  List<GameButton> buttonsList;
  @override
  void initState() {
    super.initState();
    buttonsList = initialize();
  }

  List<GameButton> initialize() {
    var gameButtons = <GameButton>[
      new GameButton(id: 0),
      new GameButton(id: 1),
      new GameButton(id: 2),
      new GameButton(id: 3),
      new GameButton(id: 4),
      new GameButton(id: 5),
      new GameButton(id: 6),
      new GameButton(id: 7),
      new GameButton(id: 8),
    ];
    return gameButtons;
  }

  void playGame(GameButton gb) {
    gb.bg = Colors.blue;
    gb.text = "X";
    gb.enabled = false;
    if (checkWin(buttonsList)) {
      showDialog(
          context: context,
          builder: (_) => CustomDialog(
              "You won!!", "Press reset button to start again.", resetGame));
      return;
    }
    if (drawGame(buttonsList)) {
      showDialog(
          context: context,
          builder: (_) => CustomDialog("its a Draw :)",
              "Press reset button to start again.", resetGame));
      return;
    }
    var inp = compPlay(buttonsList);

    buttonsList[inp].bg = Colors.black;
    buttonsList[inp].text = "0";
    buttonsList[inp].enabled = false;
    if (checkWin(buttonsList)) {
      showDialog(
          context: context,
          builder: (_) => CustomDialog(
              "You lost :(", "Press reset button to start again.", resetGame));
      return;
    }
  }

  void resetGame() {
    if (Navigator.canPop(context)) Navigator.pop(context);
    setState(() {
      buttonsList = initialize();
    });
  }

  bool drawGame(List<GameButton> bl) {
    for (var i = 0; i < 9; i++) {
      if (bl[i].enabled) {
        return false;
      }
    }
    return true;
  }

  bool checkWin(List<GameButton> bl) {
    for (var i = 0; i < 3; i++) {
      var k = 3 * i;
      if (bl[k].text != "" &&
          bl[k].text == bl[k + 1].text &&
          bl[k].text == bl[k + 2].text) return true;
    }
    for (var i = 0; i < 3; i++) {
      if (bl[i].text != "" &&
          bl[i].text == bl[3 + i].text &&
          bl[i].text == bl[6 + i].text) return true;
    }
    if (bl[4].text != "" &&
        bl[0].text == bl[4].text &&
        bl[4].text == bl[8].text)
      return true;
    else if (bl[4].text != "" &&
        bl[2].text == bl[4].text &&
        bl[4].text == bl[6].text)
      return true;
    else
      return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tic-Tac-Toe"),
      ),
      body: GridView.builder(
        padding: EdgeInsets.all(10.0),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 1.0,
          crossAxisSpacing: 9.0,
          mainAxisSpacing: 9.0,
        ),
        itemCount: buttonsList.length,
        itemBuilder: (context, i) => SizedBox(
          width: 100,
          height: 100,
          child: RaisedButton(
            padding: EdgeInsets.all(8.0),
            onPressed: buttonsList[i].enabled
                ? () {
                    setState(() {
                      playGame(buttonsList[i]);
                    });
                  }
                : null,
            child: Text(
              buttonsList[i].text,
              style: TextStyle(
                color: Colors.white,
                fontSize: 50,
              ),
            ),
            color: buttonsList[i].bg,
            disabledColor: buttonsList[i].bg,
          ),
        ),
      ),
    );
  }
}
