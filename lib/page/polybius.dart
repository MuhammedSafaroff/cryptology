import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

class Polybius extends StatefulWidget {
  Polybius({Key key}) : super(key: key);

  @override
  _PolybiusState createState() => _PolybiusState();
}

class _PolybiusState extends State<Polybius> {
  final _formKey = GlobalKey<FormState>();
  String encryptedText = '';
  String unencryptedText = '';

  final encryptedController = TextEditingController();

  bool isencrypted = true;

  @override
  void dispose() {
    encryptedController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Polybius square Şifrələmə'),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 10),
                Container(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width - 25,
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: Colors.grey[200],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(isencrypted ? 'Şifrələmək' : 'Deşifrələmək',
                            style: TextStyle(
                                fontSize: 15.0,
                                color: isencrypted
                                    ? Colors.blue
                                    : Colors.black87)),
                        Switch(
                          onChanged: (bool value) {
                            setState(() {
                              isencrypted = !isencrypted;
                            });
                          },
                          value: isencrypted,
                        ),
                      ],
                    )),
                SizedBox(height: 10),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Positioned(
                      child: Container(
                        padding: EdgeInsets.only(left: 10, right: 10),
                        width: MediaQuery.of(context).size.width - 20,
                        child: TextFormField(
                          controller: encryptedController,
                          style: TextStyle(fontSize: 14.0, color: Colors.black),
                          decoration: InputDecoration(
                            hintText: isencrypted
                                ? "Şifrələmək istədiyiniz kəlimələri daxil edin"
                                : "Deşifrələmək istədiyiniz kəlimələri daxil edin",
                            hintStyle:
                                TextStyle(fontSize: 14.0, color: Colors.black),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10.0),
                              ),
                            ),
                          ),
                          validator: (value) {
                            if (value.length == 0)
                              return "Xahiş olunur boş qoymayın!";
                          },
                        ),
                      ),
                    ),
                    Positioned(
                        right: 6,
                        child: IconButton(
                            icon: Icon(
                              Icons.cancel,
                              color: Colors.blueAccent,
                            ),
                            onPressed: () {
                              encryptedController.text = "";
                            }))
                  ],
                ),
                SizedBox(height: 10),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: Text(
                    unencryptedText,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.black,
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.centerRight,
                  margin: EdgeInsets.only(bottom: 10),
                  padding: EdgeInsets.only(left: 10, right: 10),
                  width: MediaQuery.of(context).size.width - 20,
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: Colors.grey[200],
                  ),
                  child: IconButton(
                    icon: Icon(Icons.copy),
                    onPressed: () {
                      FlutterClipboard.copy(unencryptedText).then((value) =>
                          Toast.show("copied", context,
                              duration: Toast.LENGTH_SHORT,
                              gravity: Toast.CENTER));
                    },
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  width: MediaQuery.of(context).size.width - 20,
                  height: 45,
                  child: RaisedButton(
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        encryptedText = encryptedController.text;
                        unencryptedText = '';

                        polybius();
                      }
                    },
                    color: Colors.blueAccent,
                    child: Text('Təsdiqlə',
                        style: TextStyle(fontSize: 15.0, color: Colors.white)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void polybius() {
    // List<List<String>> deValue = [
    //   ['A', 'B', 'C', 'D', 'E'],
    //   ['F', 'G', 'H', 'I', 'K'],
    //   ['L', 'M', 'N', 'O', 'P'],
    //   ['Q', 'R', 'S', 'T', 'U'],
    //   ['V', 'W', 'X', 'Y', 'Z']
    // ];

    List<String> value = [
      'A',
      'B',
      'C',
      'D',
      'E',
      'F',
      'G',
      'H',
      'I',
      'K',
      'L',
      'M',
      'N',
      'O',
      'P',
      'Q',
      'R',
      'S',
      'T',
      'U',
      'V',
      'W',
      'X',
      'Y',
      'Z'
    ];
    String a = '';
    //List<int> index = [];
    if (isencrypted) {
      encryptedText.toUpperCase().split('').forEach((element) {
        if (element == 'J') {
          a += "24,";
        } else {
          int i = value.indexOf(element);
          int row = i ~/ 5 + 1;
          int column = i % 5 + 1;

          a += "$row$column,";
        }
      });
    }
    // for (int b = 0; b < encryptedText.length; b++) {
    //   if (encryptedText.substring(b, b + 1) != ',') {
    //     int c = int.parse(encryptedText.substring(b, b + 1));
    //     index.add(c);
    //   }
    // }
    // for (int b = 0; b < index.length - 2; b += 2) {
    //   a += deValue[b][b+1];
    //   //0 1, 2 3, 4 5,

    // }

    // }

    setState(() {
      unencryptedText = a;
    });
  }
}
