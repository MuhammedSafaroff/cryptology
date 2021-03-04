import 'package:flutter/material.dart';
import 'package:clipboard/clipboard.dart';
import 'package:toast/toast.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: MyHomePage(title: 'Sezar Şifrələmə'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
        title: Text(widget.title),
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
                Container(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  width: MediaQuery.of(context).size.width - 20,
                  child: TextFormField(
                    controller: encryptedController,
                    style: TextStyle(fontSize: 14.0, color: Colors.black),
                    decoration: InputDecoration(
                      hintText: isencrypted
                          ? "Şifrələmək istədiyiniz kəlimələri daxil edin"
                          : "Deşifrələmək istədiyiniz kəlimələri daxil edin",
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
    int i, j, k = 0;
    List a = List();
    List x = [
      'a',
      'b',
      'c',
      'd',
      'e',
      'f',
      'g',
      'h',
      'i',
      'j',
      'k',
      'l',
      'm',
      'n',
      'o',
      'p',
      'q',
      'r',
      's',
      't',
      'u',
      'v',
      'w',
      'x',
      'y',
      'z'
    ];
    encryptedText.characters.forEach((element) {
      a.add(element);
      k++;
    });

    print(k);
    for (i = 0; i < k; i++) {
      for (j = 0; j < 26; j++) {
        if (a[i] == x[j]) {
          if (isencrypted)
            j = j + key;
          else
            j = j - key;
          j = j % 26;
          a[i] = x[j];
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
