import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool ohTurn = true;
  List<String> displayList = List.filled(9, "");

  var myTextStyle = TextStyle(color: Colors.white, fontSize: 30.0);
  int ohScore = 0;
  int exScore = 0;
  int filledBoxes = 0;

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[800],
      body: Column(
        children: [
          Expanded(
              child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Player X", style: myTextStyle),
                            Text(exScore.toString(), style: myTextStyle),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Player O", style: myTextStyle),
                            Text(ohScore.toString(), style: myTextStyle),
                          ],
                        ),
                      ),
                    ],
                  ))),
          Expanded(
            flex: 4,
            child: GridView.builder(
                itemCount: 9,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3),
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: () {
                      setState(() {
                        if (ohTurn && displayList[index] == "") {
                          displayList[index] = "O";
                          filledBoxes++;
                        } else if (!ohTurn && displayList[index] == "") {
                          displayList[index] = "X";
                          filledBoxes++;
                        }
                        ;
                        ohTurn = !ohTurn;
                        _checkWinner();
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: Colors.grey[700] ?? Colors.transparent)),
                      child: Center(
                        child: Text(
                          displayList[index],
                          //index.toString(),
                          style: TextStyle(color: Colors.white, fontSize: 40.0),
                        ),
                      ),
                    ),
                  );
                }),
          ),
          Expanded(child: Container()),
        ],
      ),
    );
  }

  void _showDrawDialog() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("DRAW"),
            actions: <Widget>[
              TextButton(
                  child: Text("Play Again!"),
                  onPressed: () {
                    _clearBoard();
                    Navigator.of(context).pop();
                  }
              )
            ],
          );
        });
  }

  void _showDialog(String winner) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("WİNNER IS: " + winner),
            actions: <Widget>[
              TextButton(
                  child: Text("Play Again"),
                  onPressed: () {
                    _clearBoard();
                    Navigator.of(context).pop();
                  }
              )
            ],
          );
        });
    if (winner == "O") {
      ohScore++;
    } else if (winner == "X") {
      exScore++;
    }
  }



  void _clearBoard(){
    setState(() {
      for(int i = 0; i < 9; i++){
        displayList[i] = "";
      }

    });
    filledBoxes = 0;

  }

  void _checkWinner() {
    // check 1st row
    if (displayList[0] == displayList[1] &&
        displayList[0] == displayList[2] &&
        displayList[0] != "") {
      _showDialog(displayList[0]);
    }

    // check 2nd row
    if (displayList[3] == displayList[4] &&
        displayList[3] == displayList[5] &&
        displayList[3] != "") {
      _showDialog(displayList[3]);
    }

    // check 3rd row
    if (displayList[6] == displayList[7] &&
        displayList[6] == displayList[8] &&
        displayList[6] != "") {
      _showDialog(displayList[6]);
    }

    // check 1st column
    if (displayList[0] == displayList[3] &&
        displayList[0] == displayList[6] &&
        displayList[0] != "") {
      _showDialog(displayList[0]);
    }

    // check 2nd column
    if (displayList[1] == displayList[4] &&
        displayList[1] == displayList[7] &&
        displayList[1] != "") {
      _showDialog(displayList[1]);
    }

    // check 3rd row
    if (displayList[2] == displayList[5] &&
        displayList[2] == displayList[8] &&
        displayList[2] != "") {
      _showDialog(displayList[2]);
    }

    // check diagonal
    if (displayList[0] == displayList[4] &&
        displayList[0] == displayList[8] &&
        displayList[0] != "") {
      _showDialog(displayList[0]);
    }

    // check diagonal
    if (displayList[6] == displayList[4] &&
        displayList[6] == displayList[2] &&
        displayList[6] != "") {
      _showDialog(displayList[6]);
    }

    else if(filledBoxes == 9){
      _showDrawDialog();
    }
  }
}
