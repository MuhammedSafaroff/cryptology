import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

class AtBash extends StatefulWidget {
  AtBash({Key key}) : super(key: key);

  @override
  _AtBashState createState() => _AtBashState();
}

class _AtBashState extends State<AtBash> {
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
        title: Text('AtBash Şifrələmə'),
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
                        atbash(encryptedText);
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

  void atbash(String encryptedText) {
    List<String> alphabetL = [
      'a',
      'b',
      'c',
      'ç',
      'd',
      'e',
      'ə',
      'f',
      'g',
      'ğ',
      'h',
      'x',
      'ı',
      'i',
      'j',
      'k',
      'q',
      'l',
      'm',
      'n',
      'o',
      'ö',
      'p',
      'r',
      's',
      'ş',
      't',
      'u',
      'ü',
      'v',
      'y',
      'z'
    ];
    List<String> alphabetU = [
      'A',
      'B',
      'C',
      'Ç',
      'D',
      'E',
      'Ə',
      'F',
      'G',
      'Ğ',
      'H',
      'X',
      'I',
      'İ',
      'J',
      'K',
      'Q',
      'L',
      'M',
      'N',
      'O',
      'Ö',
      'P',
      'R',
      'S',
      'Ş',
      'T',
      'U',
      'Ü',
      'V',
      'Y',
      'Z'
    ];

    List<String> reversedAlphabetU = [
      'Z',
      'Y',
      'V',
      'Ü',
      'U',
      'T',
      'Ş',
      'S',
      'R',
      'P',
      'Ö',
      'O',
      'N',
      'M',
      'L',
      'Q',
      'K',
      'J',
      'İ',
      'I',
      'X',
      'H',
      'Ğ',
      'G',
      'F',
      'Ə',
      'E',
      'D',
      'Ç',
      'C',
      'B',
      'A',
    ];

    List<String> reversedAlphabetL = [
      'z',
      'y',
      'v',
      'ü',
      'u',
      't',
      'ş',
      's',
      'r',
      'p',
      'ö',
      'o',
      'n',
      'm',
      'l',
      'q',
      'k',
      'j',
      'i',
      'ı',
      'x',
      'h',
      'ğ',
      'g',
      'f',
      'ə',
      'e',
      'd',
      'ç',
      'c',
      'b',
      'a',
    ];

    List<String> myList = [];

    encryptedText.toUpperCase().characters.forEach((element) {
      myList.add(element);
    });

    for (int i = 0; i < myList.length; i++) {
      for (int j = 0; j < 32; j++) {
        //if (myList[i] == myList[i].toUpperCase()) {
        if (isencrypted) {
          if (myList[i] == alphabetU[j]) {
            setState(() {
              unencryptedText += reversedAlphabetU[j];
            });
          }
        } else {
          if (myList[i] == reversedAlphabetU[j]) {
            setState(() {
              unencryptedText += alphabetU[j];
            });
          }

          // else if (myList[i] == myList[i].toLowerCase()) {
          //   print("true");
          //   if (isencrypted) {
          //     if (myList[i] == alphabetL[j]) {
          //       myList[i] = reversedAlphabetL[j];
          //     }
          //   } else {
          //     if (myList[i] == reversedAlphabetL[j]) {
          //       myList[i] = alphabetL[j];
          //     }
          //   }
        }
      }
    }
  }

  void polybius() {
    // List<List<String>> value = [
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
    encryptedText.split('').forEach((element) {
      int i = value.indexOf(element);
      int row = i ~/ 5 + 1;
      int column = i % 5 + 1;

      a += "$row$column,";
    });
    print(a);

    // for (int i = 0; i < 5; i++) {
    //   for (int j = 0; j < 5; j++) {
    //     if (value[i][j].contains('W')) {
    //       print("${i + 1} ${j + 1}");
    //     }
    //   }
  }
}
