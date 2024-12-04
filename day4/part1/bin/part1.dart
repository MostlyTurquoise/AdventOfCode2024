import 'dart:io';
void main(List<String> arguments) {
  var grid = File("../input.txt").readAsStringSync().split("\n").map((s)=>s.split("")).toList();
  var xs = List<(int, int)>.empty(growable: true);
  for(int i = 0; i < grid.length; i++){
    for(int j = 0; j < grid[i].length;j++){
      if(grid[i][j]=="X"){
        xs.add((i, j));
      }
    }
  }
  var t = 0;
  for(var c in xs) {
    var rx = c.$1;
    var ry = c.$2;
    for(int i = -1; i < 2; i++){
      for(int j = -1; j < 2; j++){
        try {
        if(grid[rx + i][ry + j]=="M" && grid[rx + 2*i][ry + 2*j] == "A" && grid[rx + 3*i][ry + 3*j]=="S"){
          print("found $c in dir ${(i, j)}");
          t++;
        }
        } catch(e) {
          print("Err");
        }
      }
    }
  }
  print(t);
}
