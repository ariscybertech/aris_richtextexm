import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static final String title = 'RichText';

  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: title,
        theme: ThemeData(primarySwatch: Colors.deepOrange),
        home: MainPage(title: title),
      );
}

class MainPage extends StatefulWidget {
  final String title;

  const MainPage({
    @required this.title,
  });

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: ListView(
          padding: EdgeInsets.all(32),
          children: [
            buildHello1(),
            const SizedBox(height: 24),
            buildHello2(),
            const SizedBox(height: 24),
            buildEmailLink(),
            const SizedBox(height: 24),
            buildPhoneNumber(),
            const SizedBox(height: 24),
            buildWebsiteLink(),
          ],
        ),
      );

  Widget buildHello1() => RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: 'Hello ',
              style: TextStyle(
                color: Colors.teal,
                fontSize: 28,
              ),
            ),
            TextSpan(
              text: 'World',
              style: TextStyle(
                color: Colors.red,
                fontSize: 40,
              ),
            ),
          ],
        ),
      );

  Widget buildHello2() => Text.rich(
        TextSpan(
          text: 'Hello ',
          style: TextStyle(
            color: Colors.teal,
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
          children: [
            TextSpan(
              text: 'World ',
              style: TextStyle(
                color: Colors.red,
              ),
            ),
            TextSpan(text: '\u{1F44B}'), // 👋
          ],
        ),
      );

  Widget buildEmailLink() => RichText(
        text: TextSpan(
          text: 'Contact me via: ',
          style: TextStyle(color: Colors.black, fontSize: 20),
          children: [
            WidgetSpan(
              child: Icon(Icons.email, color: Colors.blue),
              alignment: PlaceholderAlignment.middle,
            ),
            TextSpan(
              text: ' Email',
              style: TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.bold,
              ),
              recognizer: TapGestureRecognizer()..onTap = launchEmail,
            ),
          ],
        ),
      );

  Widget buildPhoneNumber() => RichText(
        text: TextSpan(
          text: 'Call Me:  ',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          children: [
            TextSpan(
              text: '+1234987654321',
              style: TextStyle(
                color: Colors.blue,
                decoration: TextDecoration.underline,
              ),
              recognizer: TapGestureRecognizer()..onTap = launchPhoneNumber,
            ),
          ],
        ),
      );

  Widget buildWebsiteLink() => RichText(
        text: TextSpan(
          text: 'Read My Blog ',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          children: [
            TextSpan(
              text: 'HERE',
              style: TextStyle(
                color: Colors.blue,
                decoration: TextDecoration.underline,
              ),
              recognizer: TapGestureRecognizer()..onTap = launchWebsite,
            ),
          ],
        ),
      );

  Future launchWebsite() async {
    const url = 'https://flutter.dev';

    await launch(url);
  }

  Future launchPhoneNumber() async {
    const phoneNumber = '+49123498765432';

    await launch('tel:$phoneNumber');
  }

  Future launchEmail() async {
    final toEmail = 'smith@example.com';
    final subject = 'Example Subject';
    final body = 'Hello World';

    final email =
        'mailto:$toEmail?subject=${Uri.encodeFull(subject)}&body=${Uri.encodeFull(body)}';

    await launch(email);
  }
}
