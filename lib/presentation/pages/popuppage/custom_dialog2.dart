import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomDialogBox2 extends StatefulWidget {
  const CustomDialogBox2({
    Key? key,
  }) : super(key: key);

  @override
  _CustomDialogBox2State createState() => _CustomDialogBox2State();
}

class _CustomDialogBox2State extends State<CustomDialogBox2> {
  static const TextStyle linkStyle = const TextStyle(
    color: Colors.blue,
    decoration: TextDecoration.underline,
  );

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('About Pop up'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildAboutText(),
          _buildLogoAttribution(),
        ],
      ),
      actions: <Widget>[
        FlatButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          textColor: Theme.of(context).primaryColor,
          child: const Text('Okay, got it!'),
        ),
      ],
    );
  }

  Widget _buildAboutText() {
    return RichText(
      text: TextSpan(
        text:
            'Android Popup Menu displays the menu below the anchor text if space is available otherwise above the anchor text. It disappears if you click outside the popup menu.\n\n',
        style: const TextStyle(color: Colors.black87),
        children: <TextSpan>[
          const TextSpan(text: 'The app was developed with '),
          TextSpan(
            text: 'Flutter',
            style: linkStyle,
          ),
          const TextSpan(
            text: ' and it\'s open source; check out the source '
                'code yourself from ',
          ),
          TextSpan(
            text: 'www.codesnippettalk.com',
            style: linkStyle,
          ),
          const TextSpan(text: '.'),
        ],
      ),
    );
  }

  Widget _buildLogoAttribution() {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Row(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 0.0),
            child: Image.asset(
              "images/logo_movieku.png",
              width: 32.0,
            ),
          ),
          const Expanded(
            child: const Padding(
              padding: const EdgeInsets.only(left: 12.0),
              child: const Text(
                'Popup window is like a dialog box that gains complete focus when it appears on screen.',
                style: const TextStyle(fontSize: 12.0),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
