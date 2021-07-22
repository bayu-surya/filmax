import 'package:filmax/consumerprovider/common/styles.dart';
import 'package:filmax/consumerprovider/provider/tidakdigunakan/login_provider.dart';
import 'package:filmax/consumerprovider/ui/tidakdigunakan/list_page.dart';
import 'package:filmax/consumerprovider/widgets/app_drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  static const routeName = '/login';

  const Login();

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String _alertString = "";
  String _emailString = "";
  String _passwordString = "";

  @override
  Widget build(BuildContext context) {
    final _logo = CircleAvatar(
      backgroundColor: Colors.transparent,
      radius: 45.0,
      child: Image.asset('images/logo_movieku.png', width: 200, height: 200),
    );

    final _email = TextFormField(
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      decoration: InputDecoration(
        hintText: 'Email',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
      onChanged: (text) {
        _emailString=text;
      },
    );

    final _password = TextFormField(
      autofocus: false,
      obscureText: true,
      decoration: InputDecoration(
        hintText: 'Password',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
      onChanged: (text) {
        _passwordString=text;
      },
    );

    final _loginButton = Padding(
      padding: EdgeInsets.fromLTRB(0,10.0,0,0),
      child: Material(
        borderRadius: BorderRadius.circular(30.0),
        shadowColor: Colors.lightBlueAccent.shade100,
        elevation: 5.0,
        color: primaryColor,
        child:
        MaterialButton(
          minWidth: 200.0,
          height: 42.0,
          child: Text('Daftar',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16)
          ),
          onPressed: () {
            if ( _emailString=="" ) {
              setState(() {
                _alertString="Anda belum mengisi email";
              });
            } else if(_passwordString==""){
              setState(() {
                _alertString="Anda belum mengisi password";
              });
            } else {
              Provider.of<LoginProvider>(context, listen: false).complete(_emailString, _passwordString);
              Navigator.pushReplacementNamed(context, BerandaListPage.routeName);
            }
          },
        ),
      ),
    );

    final _forgotLabel = FlatButton(
      child: Text(
        'Lupa password?',
        style: TextStyle(color: Colors.black54,
            fontSize: 12),
      ),
      onPressed: () {},
    );

    final _tittle = Padding (
      padding: EdgeInsets.fromLTRB(15.0,0,0,0),
      child: Text(
        "Daftar",
        style: TextStyle(
          color: primaryColor,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text("Login",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),),
      ),
      drawer: AppDrawer(),
      backgroundColor: Colors.white,
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 24.0, right: 24.0),
          children: <Widget>[
            _logo,
            SizedBox(height: 48.0),
            _tittle,
            SizedBox(height: 8.0),
            _email,
            SizedBox(height: 8.0),
            _password,
            SizedBox(height: 24.0),
            _loginButton,
            _forgotLabel,
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          '$_alertString',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        color: _alertString==""?
        Colors.white :
        Colors.redAccent,
      ),
    );
  }
}