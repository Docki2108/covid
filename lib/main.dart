import 'package:covid/view/menu.dart';
import 'package:covid/view/register.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:covid/lib/theme/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:covid/services/firestore.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Covid-19',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: const Color.fromARGB(217, 123, 123, 123),
      ),
      home: const MyHomePage(title: 'Авторизация'),
      debugShowCheckedModeBanner: false,
    );
  }
}

// enum Gender { none, Male, Female, Utug }

TextEditingController emailController = TextEditingController();
TextEditingController passwordController = TextEditingController();
TextEditingController test1Controller = TextEditingController();

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  //
  // Gender? _character = Gender.none;
  late FocusNode qwe11;
  late FocusNode qwe22;

  @override
  void initState() {
    qwe11 = FocusNode();
    qwe22 = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    qwe11.dispose();
    qwe22.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: color_back,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              startCovidPic(),
              email(),
              password(),
              cont(),
              btnEnter(),
              btnReg(),
            ],
          ),
        ),
      ),
    );
  }

  Widget startCovidPic() {
    return Container(
      margin: EdgeInsets.zero,
      child: const Image(
        image: AssetImage("lib/lib/theme/pics/covid19.png"),
        height: 500,
        width: 500,
        alignment: Alignment.center,
      ),
    );
  }

  Widget email() {
    return TextFormField(
      controller: emailController,
      onEditingComplete: () => qwe22.nextFocus(),
      focusNode: qwe11,
      decoration: const InputDecoration(
        contentPadding: EdgeInsets.all(15.0),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: cvet1, width: 2.0),
          borderRadius: BorderRadius.all(Radius.circular(15.0)),
        ),
        fillColor: Color(0xD9D9D9),
        filled: true,
        hintText: "Почта",
      ),
    );
  }

  Widget password() {
    return TextFormField(
        controller: passwordController,
        focusNode: qwe22,
        obscureText: true,
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.all(15.0),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: cvet1, width: 2.0),
            borderRadius: BorderRadius.all(Radius.circular(15.0)),
          ),
          fillColor: Color(0xD9D9D9),
          filled: true,
          hintText: "Пароль",
        ));
  }

  Widget cont() {
    return Container(
      padding: EdgeInsets.fromLTRB(0, 170, 0, 0),
    );
  }

  Widget btnEnter() {
    return ElevatedButton(
      onPressed: () async {
        try {
          final credential = await FirebaseAuth.instance
              .signInWithEmailAndPassword(
                  email: emailController.text,
                  password: passwordController.text);

          await FireStore.getUserData(FirebaseAuth.instance.currentUser!.uid);
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Menu()));
        } on FirebaseAuthException catch (e) {
          showDialog(
            context: context,
            // ignore: prefer_const_constructors
            builder: (_) => AlertDialog(
              content: const Text('Ошибка авторизации'),
            ),
          );
        }
      },
      child: Text("Продолжить"),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(color_elem),
        fixedSize: MaterialStateProperty.all<Size>(Size.fromWidth(380)),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
    );
  }

  Widget btnReg() {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Register()));
      },
      child: Text("Зарегистрироваться"),
      style: ButtonStyle(
        fixedSize: MaterialStateProperty.all<Size>(Size.fromWidth(380)),
        backgroundColor: MaterialStateProperty.all<Color>(color_elem),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
    );
  }

  Future signIn() async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim());
  }
}
