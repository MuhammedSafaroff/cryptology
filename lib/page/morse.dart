import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

class Morse extends StatefulWidget {
  Morse({Key key}) : super(key: key);

  @override
  _MorseState createState() => _MorseState();
}

class _MorseState extends State<Morse> {
  final _formKey = GlobalKey<FormState>();
  String encryptedText = '';
  String unencryptedText = '';
  String a = '';

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
        title: Text('Morse  Şifrələmə'),
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
                      fontSize: 30.0,
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

                        morse();
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

  void morse() {
    if (isencrypted) {
      morseCode(encryptedText);
    } else {
      a = "Deşifrələyə bilmirəm";
    }

    setState(() {
      unencryptedText = a;
    });
  }

  String morseEncode(String x) {
    // refer to the Morse table
    // image attached in the article
    switch (x) {
      case 'a':
        return ".-";
      case 'b':
        return "-...";
      case 'c':
        return "-.-.";
      case 'd':
        return "-..";
      case 'e':
        return ".";
      case 'f':
        return "..-.";
      case 'g':
        return "--.";
      case 'h':
        return "....";
      case 'i':
        return "..";
      case 'j':
        return ".---";
      case 'k':
        return "-.-";
      case 'l':
        return ".-..";
      case 'm':
        return "--";
      case 'n':
        return "-.";
      case 'o':
        return "---";
      case 'p':
        return ".--.";
      case 'q':
        return "--.-";
      case 'r':
        return ".-.";
      case 's':
        return "...";
      case 't':
        return "-";
      case 'u':
        return "..-";
      case 'v':
        return "...-";
      case 'w':
        return ".--";
      case 'x':
        return "-..-";
      case 'y':
        return "-.--";
      // for space
      case 'z':
        return "--..";
      case '1':
        return ".----";
      case '2':
        return "..---";
      case '3':
        return "...--";
      case '4':
        return "....-";
      case '5':
        return ".....";
      case '6':
        return "-....";
      case '7':
        return "--...";
      case '8':
        return "---..";
      case '9':
        return "----.";
      case '0':
        return "-----";
    }
    return "";
  }

  void morseCode(String s) {
    a = '';
    s.toLowerCase().split('').forEach((element) {
      a += morseEncode(element) + ",";
    });
  }
}
