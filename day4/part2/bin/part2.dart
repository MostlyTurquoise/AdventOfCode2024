import 'dart:io';

void main(List<String> arguments) {
  var grid = File("../input.txt")
      .readAsStringSync()
      .split("\n")
      .map((s) => s.split(""))
      .toList();
  var xs = List<(int, int)>.empty(growable: true);
  for (int i = 0; i < grid.length; i++) {
    for (int j = 0; j < grid[i].length; j++) {
      if (grid[i][j] == "A") {
        xs.add((i, j));
      }
    }
  }
  var t = 0;
  for (var c in xs) {
    var rx = c.$1;
    var ry = c.$2;
    try {
      /**
       * M.S
       * .A.
       * M.S
       */
      if (grid[rx - 1][ry - 1] == "M" &&
          grid[rx + 1][ry - 1] == "M" &&
          grid[rx - 1][ry + 1] == "S" &&
          grid[rx + 1][ry + 1] == "S") {
        t++;
        print("found ${(rx,ry)}, case 1");
      }
      /**
       * M.M
       * .A.
       * S.S
       */
      if (grid[rx - 1][ry - 1] == "M" &&
          grid[rx + 1][ry - 1] == "S" &&
          grid[rx - 1][ry + 1] == "M" &&
          grid[rx + 1][ry + 1] == "S") {
        t++;
        print("found ${(rx,ry)}, case 2");
      }
      /**
       * S.M
       * .A.
       * S.M
       */
      if (grid[rx - 1][ry - 1] == "S" &&
          grid[rx + 1][ry - 1] == "S" &&
          grid[rx - 1][ry + 1] == "M" &&
          grid[rx + 1][ry + 1] == "M") {
        t++;
        print("found ${(rx,ry)}, case 3");
      }
      /**
       * S.S
       * .A.
       * M.M
       */
      if (grid[rx - 1][ry - 1] == "S" &&
          grid[rx + 1][ry - 1] == "M" &&
          grid[rx - 1][ry + 1] == "S" &&
          grid[rx + 1][ry + 1] == "M") {
        t++;
        print("found ${(rx,ry)}, case 4");
      }
    } catch (e) {
      print("Edge");
    }
  }
  print(t);
}
