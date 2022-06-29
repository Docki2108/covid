import 'dart:math';
import 'package:covid/services/remote_service.dart';
import 'package:covid/view/prof.dart';
import 'package:covid/view/test.dart' as test;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:covid/lib/theme/colors.dart';
import 'package:flutter/services.dart';
import '../main.dart';
import '../models/post.dart';
import 'package:covid/models/user.dart' as user;

Future<String> _loadCoronaApi() async {
  return await rootBundle.loadString('https://api.covid19api.com/');
}

void menu() {
  runApp(const Menu());
}

class Menu extends StatelessWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Covid-19 ',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: Color.fromARGB(217, 123, 123, 123),
      ),
      home: const MyHomePage(title: 'Меню'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Welcome? posts;
  var isLoaded = false;

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    var testposts = await RemoteService().getPosts();
    if (testposts != null) {
      setState(() {
        posts = testposts;
        isLoaded = true;
      });
    }
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
              upPole1(),
              upPole2(),
              viewRecomendation(),
              lastTestView(),
              btnTest(),
              btnProf(),
              btnBacktoMain(),
              btnSignOut(),
            ],
          ),
        ),
      ),
    );
  }

  Widget lastTestView() {
    return Center(
      child: Column(
        children: [
          Text('\n' + '\n' + '\n' + '\n' + '\n' + '\n'),
          Image(
            image: AssetImage("lib/lib/theme/pics/def.png"),
            height: 300,
            width: 300,
            alignment: Alignment.center,
          ),
          Text('\n' + '\n' + '\n'),
        ],
      ),
    );
  }

  Widget btnTest() {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => test.Test()));
      },
      child: Text("Пройти тест"),
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

  Widget btnProf() {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Prof()));
      },
      child: Text("Профиль"),
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

  Widget btnBacktoMain() {
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

  Widget btnSignOut() {
    return ElevatedButton(
      onPressed: () async {
        await FirebaseAuth.instance.signOut();
        emailController.clear();

        user.User().clear();
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => MyApp()));
      },
      child: Text("Выйти из аккаунта"),
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

  Widget upPole2() {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 10,
      ),
      color: color_bar,
      child: Column(
        children: <Widget>[
          Row(children: [
            Container(
              child: Image(
                image: AssetImage("lib/lib/theme/pics/covid2.png"),
                height: 75,
                width: 75,
                alignment: Alignment.center,
              ),
              alignment: Alignment(0, 0),
            ),
            posts == null
                ? CircularProgressIndicator()
                : Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    //alignment: Alignment.center,
                    child: Text(
                      'Всего заболевших: ' +
                          posts!.global.totalConfirmed.toString() +
                          '\n' +
                          'Всего умерших:            ' +
                          posts!.global.totalDeaths.toString() +
                          '\n' +
                          'Новых зараженных:      ' +
                          posts!.global.newConfirmed
                              .toString(), //+ posts!.message,
                      style: new TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
          ]),
        ],
      ),
    );
  }

  Widget upPole1() {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            "КОВИД ИНФОРМЕР",
            textAlign: TextAlign.center,
            style: new TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          ),
        ],
      ),
    );
  }

  List<String> rec = [
    'Держитесь на безопасном расстоянии от людей (не менее 1 метра), даже если они не кажутся заболевшими',
    'Носите маску в общественных местах, особенно в закрытых помещениях и там, где соблюдать безопасную дистанцию невозможно.',
    'Старайтесь избегать закрытых, плохо вентилируемых мест. Находясь в помещении, открывайте окна.',
    'Соблюдайте правила гигиены рук. Часто мойте их водой с мылом или обрабатывайте спиртосодержащим антисептиком для рук.',
    'Сделайте прививку, когда подойдет ваша очередь. Следуйте местным рекомендациям по вакцинации.',
    'При кашле или чихании прикрывайте рот и нос локтевым сгибом или платком.',
    'Если вы чувствуете недомогание, оставайтесь дома.'
  ];

  int randRec = Random().nextInt(6 - (0));

  Widget viewRecomendation() {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 10,
      ),
      color: color_elem_plus,
      child: Text(
        rec[randRec],
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.white,
          fontSize: 16,
        ),
      ),
    );
  }
}
