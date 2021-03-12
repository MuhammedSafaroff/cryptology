import 'package:flutter/material.dart';
import 'package:kriptoqrafiya/page/atbash.dart';
import 'package:kriptoqrafiya/page/polybius.dart';
import 'package:kriptoqrafiya/page/sezar.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Şifrələmə Metodları"),
      ),
      body: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 180,
              height: 50,
              child: RaisedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SezarSifreleme()));
                },
                child: Text(
                  'Sezar Şifrələmə',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                color: Colors.indigo,
              ),
            ),
            SizedBox(height: 16),
            SizedBox(
              width: 180,
              height: 50,
              child: RaisedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AtBash()));
                },
                child: Text(
                  'At Bash Şifrələmə',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                color: Colors.indigo,
              ),
            ),
            SizedBox(height: 16),
            SizedBox(
              width: 180,
              height: 50,
              child: RaisedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Polybius()));
                },
                child: Text(
                  'Polybius square Şifrələmə',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                color: Colors.indigo,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
