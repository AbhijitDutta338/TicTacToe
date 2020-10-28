import 'dart:math';
import 'GameButton.dart';

var cp = "0";
var ch = "X";
var scr = {cp: 10, ch: -10, "tie": 0};

win(List t) {
  for (var i = 0; i < 3; i++) {
    var k = 3 * i;
    if (t[k] == t[k + 1] && t[k] == t[k + 2] && t[k] != "_") return t[k];
  }
  for (var i = 0; i < 3; i++) {
    if (t[i] == t[3 + i] && t[i] == t[6 + i] && t[i] != "_") return t[i];
  }
  if (t[0] == t[4] && t[0] == t[8] && t[4] != "_")
    return t[0];
  else if (t[2] == t[4] && t[2] == t[6] && t[4] != "_") return t[2];
  for (var i = 0; i < 9; i++) if (t[i] == "_") return "None";
  return "tie";
}

min_max(List t, int d, bool isMax) {
  var val = win(t);
  if (val != "None") return scr[val];
  if (isMax) {
    var best = (-1000);
    for (var i = 0; i < 9; i++) {
      if (t[i] == "_") {
        t[i] = cp;
        var score = min_max(t, d + 1, false);
        t[i] = "_";
        best = max(score, best);
      }
    }
    return best;
  } else {
    var best = 1000;
    for (var i = 0; i < 9; i++) {
      if (t[i] == "_") {
        t[i] = ch;
        var score = min_max(t, d + 1, true);
        t[i] = "_";
        best = min(score, best);
      }
    }
    return best;
  }
}

findBestMove(List t) {
  var best = (-1000);
  var bestMove = -1;
  for (var i = 0; i < 9; i++) {
    if (t[i] == "_") {
      t[i] = cp;
      var move = min_max(t, 0, false);
      t[i] = "_";
      if (move > best) {
        bestMove = i;
        best = move;
      }
    }
  }
  return bestMove;
}

compPlay(List<GameButton> bl) {
  List t = List.filled(9, "_");
  for (var i = 0; i < 9; i++) {
    if (bl[i].text != "") {
      t[i] = bl[i].text;
    }
  }
  return findBestMove(t);
}
