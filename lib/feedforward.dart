import 'dart:math';

class Feed {
  List feedForward(List input) {
    double sigB(double x) {
      return (1 / (1 + exp(-x)));
    }

    List inputFix = List((input.length + 1));
    inputFix[0] = 1.0;
    for (var i = 1; i < inputFix.length; i++) {
      inputFix[i] = input[i - 1];
    }

    input = inputFix;

    // List input = [1, 3, 78, 50, 32, 88, 31, 0.248, 26];
    List w = [
      [
        [8.57848638, 0.56220033, -1.93871168, -0.46592205],
        [6.09474344, -5.26030289, 10.81540604, 1.04122752],
        [-5.92792993, 5.25613844, -1.13364602, -7.01377719],
        [1.47071468, -7.67950145, -4.66792965, -4.72096621],
        [4.52051949, 12.57203534, 3.71346512, 0.7399843],
        [2.03606512, -2.14912595, 8.88888372, -2.96766172],
        [4.5874886, -1.64654533, 6.59784826, 9.4805883],
        [-5.72368674, -17.28088456, 0.57410049, 6.71756501],
        [-7.02388876, 1.98378066, -11.07084393, -2.32588813]
      ],
      [
        [-4.41211153, 4.41211153],
        [4.7877085, -4.7877085],
        [-3.05610807, 3.05610807],
        [3.63631249, -3.63631249],
        [1.43791578, -1.43791578]
      ]
    ];

    List outcome = List.generate((w[0][0].length + 1), (i) => 1.0);

    for (var i = 0; i < w[0].length; i++) {
      for (var j = 0; j < w[0][i].length; j++) {
        outcome[j + 1] += input[i] * w[0][i][j];
      }
    }
    for (var i = 1; i < (outcome.length - 1); i++) {
      outcome[i] = sigB(outcome[i]);
    }

    input = outcome;
    outcome = List.generate(w[1][0].length, (i) => 1.0);

    for (var i = 0; i < w[1].length; i++) {
      for (var j = 0; j < w[1][i].length; j++) {
        outcome[j] += input[i] * w[1][i][j];
      }
    }
    for (var i = 0; i < outcome.length; i++) {
      outcome[i] = sigB(outcome[i]);
    }

    print(outcome);
    return outcome;
  }
}
