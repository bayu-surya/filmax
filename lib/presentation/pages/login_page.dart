import 'package:filmax/core/common/styles.dart';
import 'package:filmax/domain/entities/login.dart';
import 'package:filmax/domain/entities/user.dart';
import 'package:filmax/presentation/bloc/login/login_bloc.dart' as loginBloc;
import 'package:filmax/presentation/bloc/user/user_bloc.dart';
import 'package:filmax/presentation/pages/home_page.dart';
import 'package:filmax/presentation/widgets/edit_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  static const routeName = '/login_page';

  const LoginPage();

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _alertString = "";
  String _noInduk = "";
  String _name = "";
  String _address = "";
  final TextEditingController noIndukController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the widget tree.
    noIndukController.dispose();
    nameController.dispose();
    addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _logo = CircleAvatar(
      backgroundColor: Colors.transparent,
      radius: 45.0,
      child: Image.asset('images/logo_movieku.png', width: 200, height: 200),
    );

    final _loginButton = Padding(
      padding: EdgeInsets.fromLTRB(0, 10.0, 0, 0),
      child: Material(
        borderRadius: BorderRadius.circular(30.0),
        shadowColor: Colors.lightBlueAccent.shade100,
        elevation: 5.0,
        color: primaryColor,
        child: MaterialButton(
          minWidth: 200.0,
          height: 42.0,
          child: Text('Login',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16)),
          onPressed: () {
            if (_noInduk == "") {
              setState(() {
                _alertString = "Anda belum mengisi No Induk";
              });
            } else if (_name == "") {
              setState(() {
                _alertString = "Anda belum mengisi Nama";
              });
            } else if (_address == "") {
              setState(() {
                _alertString = "Anda belum mengisi Alamat";
              });
            } else {
              Login login = Login(username: _name, password: _address);

              BlocProvider.of<loginBloc.LoginBloc>(context)
                  .add(loginBloc.GetDataForLogin(login));

              noIndukController.clear();
              nameController.clear();
              addressController.clear();

              _noInduk = "";
              _name = "";
              _address = "";
            }
          },
        ),
      ),
    );

    final _tittle = Padding(
      padding: EdgeInsets.fromLTRB(15.0, 0, 0, 0),
      child: Text(
        'Login',
        style: TextStyle(
          color: primaryColor,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Login',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
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
            EditText(
                text: "No Induk",
                onChanged: (value) {
                  _noInduk = value;
                },
                textController: noIndukController),
            SizedBox(height: 8.0),
            EditText(
                text: "Nama",
                onChanged: (value) {
                  _name = value;
                },
                textController: nameController),
            SizedBox(height: 8.0),
            EditText(
                text: "Alamat",
                onChanged: (value) {
                  _address = value;
                },
                textController: addressController),
            SizedBox(height: 24.0),
            _loginButton,
          ],
        ),
      ),
      bottomNavigationBar:
          BlocBuilder<loginBloc.LoginBloc, loginBloc.LoginState>(
        builder: (context, state) {
          if (state is loginBloc.Empty) {
            return Container(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                '$_alertString',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              color: _alertString == "" ? Colors.white : Colors.redAccent,
            );
          } else if (state is loginBloc.Loading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is loginBloc.Loaded) {
            User data = state.data;
            BlocProvider.of<UserBloc>(context).add(GetDataForUser(user: data));
            WidgetsBinding.instance?.addPostFrameCallback((_) {
              Navigator.pushReplacementNamed(context, HomePage.routeName);
            });
            return SizedBox(height: 0.0);
          } else if (state is loginBloc.Error) {
            return Container(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                state.message,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              color: state.message == "" ? Colors.white : Colors.redAccent,
            );
          } else {
            return Container(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                '$_alertString',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              color: _alertString == "" ? Colors.white : Colors.redAccent,
            );
          }
        },
      ),
    );
  }
}
