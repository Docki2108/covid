import 'package:covid/main.dart';
import 'package:covid/services/firestore.dart';
import 'package:covid/view/menu.dart';
import 'package:flutter/material.dart';
import 'package:covid/lib/theme/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:covid/models/user.dart' as user;

void main() {
  runApp(const Register());
}

class Register extends StatelessWidget {
  const Register({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Covid-19 ',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: Color.fromARGB(217, 123, 123, 123),
      ),
      home: const MyHomePage(title: 'Регистрация'),
      debugShowCheckedModeBanner: false,
    );
  }
}

enum Gender { none, Male, Female, Utug }

TextEditingController emailController = TextEditingController();
TextEditingController passwordController = TextEditingController();
TextEditingController nameController = TextEditingController();
TextEditingController yearsController = TextEditingController();

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  //метки фокуснода
  Gender? _character = Gender.none;
  late FocusNode qwe1;
  late FocusNode qwe2;
  late FocusNode qwe3;
  late FocusNode qwe4;

  //initState - срабатывает при создании виджета
  @override
  void initState() {
    qwe1 = FocusNode();
    qwe2 = FocusNode();
    qwe3 = FocusNode();
    qwe4 = FocusNode();
    super.initState();
  }

  //закрытие процессов фокуснода
  @override
  void dispose() {
    qwe1.dispose();
    qwe2.dispose();
    qwe3.dispose();
    qwe4.dispose();
    super.dispose();
  }

  // void _incrementCounter() {
  //   setState(() {
  //     _counter--;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: color_back,
      // appBar: AppBar(
      //   title: Text(widget.title),
      // ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              cont(),
              Dannie(),
              myEmail(),
              myPassword(),
              myName(),
              myYears(),
              genderM(Gender.Male),
              genderF(Gender.Female),
              btnReg(),
              btnBack(),
            ],
          ),
        ),
      ),
    );
  }

  //ВИДЖЕТЫ ↓

  Widget startCovidPic() {
    return Container(
      margin: EdgeInsets.zero,
      child: Image(
        image: AssetImage("lib/lib/theme/pics/covid19.png"),
        height: 300,
        width: 300,
        alignment: Alignment.center,
      ),
    );
  }

  Widget myEmail() {
    return TextFormField(
      controller: emailController,
      onEditingComplete: () => qwe2.nextFocus(),
      focusNode: qwe1,
      decoration: InputDecoration(
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

  Widget myPassword() {
    return TextFormField(
        controller: passwordController,
        focusNode: qwe2,
        onEditingComplete: () => qwe3.nextFocus(),
        decoration: InputDecoration(
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

  Widget myName() {
    return TextFormField(
        controller: nameController,
        focusNode: qwe3,
        onEditingComplete: () => qwe4.nextFocus(),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(15.0),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: cvet1, width: 2.0),
            borderRadius: BorderRadius.all(Radius.circular(15.0)),
          ),
          fillColor: Color(0xD9D9D9),
          filled: true,
          hintText: "Имя",
        ));
  }

  Widget myYears() {
    return TextFormField(
        keyboardType: TextInputType.number,
        controller: yearsController,
        focusNode: qwe4,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(15.0),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: cvet1, width: 2.0),
            borderRadius: BorderRadius.all(Radius.circular(15.0)),
          ),
          fillColor: Color(0xD9D9D9),
          filled: true,
          hintText: "Возраст",
        ));
  }

  Widget genderM(Gender lol) {
    return RadioListTile(
      title: lol == Gender.Male ? Text('М') : Text('Ж'),
      value: lol,
      groupValue: _character,
      onChanged: (Gender? value) {
        setState(() {
          _character = value;
        });
      },
    );
  }

  Widget cont() {
    return Container(
      padding: EdgeInsets.fromLTRB(0, 170, 0, 0),
    );
  }

  Widget Dannie() {
    return Container(
      //width: 10,
      height: 50,
      child: Text("Заполните все поля для успешной регистрации!"),
    );
  }

  Widget genderF(Gender lol) {
    return RadioListTile(
      title: lol == Gender.Male ? Text('М') : Text('Ж'),
      value: lol,
      groupValue: _character,
      onChanged: (Gender? value) {
        setState(() {
          _character = value;
        });
      },
    );
  }

  Widget btnStart() {
    return RaisedButton(
      color: color_elem,
      textColor: Colors.white,
      focusColor: color_back,
      child: Container(
        height: 40,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white, width: 1.0),
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Text('Продолжить'),
      ),
      onPressed: () {
        if (emailController.text.isEmpty || passwordController.text.isEmpty) {
          showDialog(
            context: context,
            builder: (_) => AlertDialog(
              content: const Text('Заполните все поля!'),
            ),
          );
        } else {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Menu()));
        }
      },
    );
  }

  Widget btnBack() {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => MyApp()));
      },
      child: Text("Назад"),
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

  Widget btnReg() {
    return ElevatedButton(
      onPressed: () async {
        if (emailController.text.isEmpty || passwordController.text.isEmpty) {
          //вывод микро-сообщения ↓
          showDialog(
            context: context,
            builder: (_) => AlertDialog(
              content: const Text('Заполните все поля!'),
            ),
          );
        } else {
          try {
            final credential =
                await FirebaseAuth.instance.createUserWithEmailAndPassword(
              email: emailController.text,
              password: passwordController.text,
            );
            user.User(
                id: FirebaseAuth.instance.currentUser!.uid,
                name: nameController.text,
                years: int.parse(yearsController.text),
                gender: Gender.Male);
            FireStore.setUserData().then((value) => Navigator.push(
                context, MaterialPageRoute(builder: (context) => Menu())));
          } on FirebaseAuthException catch (e) {
            if (e.code == 'weak-password') {
              print('The password provided is too weak.');
            } else if (e.code == 'email-already-in-use') {
              print('The account already exists for that email.');
            }
          } catch (e) {
            print(e);
          }
        }
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
}
