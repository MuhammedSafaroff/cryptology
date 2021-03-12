import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

class SezarSifreleme extends StatefulWidget {
  @override
  _SezarSifrelemeState createState() => _SezarSifrelemeState();
}

class _SezarSifrelemeState extends State<SezarSifreleme> {
  final _formKey = GlobalKey<FormState>();
  String encryptedText = '';
  String unencryptedText = '';
  final keyController = TextEditingController();
  final encryptedController = TextEditingController();
  int key;
  bool isencrypted = true;

  @override
  void dispose() {
    keyController.dispose();
    encryptedController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sezar Şifrələmə'),
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
                Container(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  width: MediaQuery.of(context).size.width - 20,
                  child: TextFormField(
                    controller: keyController,
                    keyboardType: TextInputType.phone,
                    maxLength: 2,
                    style: TextStyle(fontSize: 14.0, color: Colors.black),
                    decoration: InputDecoration(
                      hintText: "Xahiş olunur key daxil edin",
                      hintStyle: TextStyle(fontSize: 14.0, color: Colors.black),
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
                        key = int.parse(keyController.text);
                        encryptedText = encryptedController.text;

                        encrypted(key, encryptedText, isencrypted);
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

  void encrypted(int key, String encryptedText, bool isencrypted) {
    int k = 0;
    List<String> a = [];
    List<String> x = [
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

    List<String> x1 = [
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
    encryptedText.characters.forEach((element) {
      a.add(element);
      k++;
    });

    for (int i = 0; i < k; i++) {
      for (int j = 0; j < 32; j++) {
        if (a[i] == a[i].toUpperCase()) {
          if (a[i] == x1[j]) {
            if (isencrypted)
              j = j + key;
            else
              j = j - key;
            j = j % 32;
            a[i] = x1[j];
          }
        } else if (a[i] == a[i].toLowerCase()) {
          if (a[i] == x[j]) {
            if (isencrypted)
              j = j + key;
            else
              j = j - key;
            j = j % 32;
            a[i] = x[j];
          }
        }
      }
    }

    setState(() {
      unencryptedText = '';
      a.forEach((element) {
        unencryptedText += element;
      });
    });
  }
}
