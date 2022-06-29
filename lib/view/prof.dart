import 'package:covid/view/menu.dart';
import 'package:flutter/material.dart';
import 'package:covid/lib/theme/colors.dart';
import 'package:covid/models/user.dart' as user;

void menu() {
  runApp(const Prof());
}

class Prof extends StatelessWidget {
  const Prof({Key? key}) : super(key: key);

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
              txtInfo1(),
              txtInfo2(),
              txtInfo3(),
              profView(),
              btnBackMenu(),
            ],
          ),
        ),
      ),
    );
  }

  Widget profView() {
    return Center(
      child: Column(
        children: [
          Text('\n'),
          Image(
            image: AssetImage("lib/lib/theme/pics/man.png"),
            height: 250,
            width: 250,
            alignment: Alignment.center,
          ),
          Text('\n' + '\n' + '\n'),
        ],
      ),
    );
  }

  Widget txtInfo1() {
    return Center(
      child: Container(
        color: color_elem_plus,
        padding: EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        child: Column(
          children: [
            Text(
              'ФАКТ: вирус, вызывающий COVID-19, не передается через воду или при плавании.',
              style: new TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
            Text(
              'Вирусом, вызывающим COVID-19, нельзя заразиться через воду при плавании. Тем не менее, вирус распространяется при тесном контакте между людьми.',
              style: new TextStyle(
                color: Color.fromARGB(255, 215, 215, 215),
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget txtInfo2() {
    return Center(
      child: Container(
        color: color_elem_plus,
        padding: EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        child: Column(
          children: [
            Text(
              'ФАКТ: возбудителем COVID-19 является вирус. НЕ бактерия.',
              style: new TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
            Text(
              'Возбудителем COVID-19 является вирус из семейства коронавирусов. Антибиотики на вирусы не действуют.',
              style: new TextStyle(
                color: Color.fromARGB(255, 215, 215, 215),
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget txtInfo3() {
    return Center(
      child: Container(
        color: color_elem_plus,
        padding: EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        child: Column(
          children: [
            Text(
              'ФАКТ: длительное ношение медицинских масок* НЕ ПРИВОДИТ к кислородной недостаточности',
              style: new TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
            Text(
              'Продолжительное ношение медицинской маски может вызывать дискомфорт. Одноразовые маски не следует использовать повторно и необходимо менять, как только они отсыревают.',
              style: new TextStyle(
                color: Color.fromARGB(255, 215, 215, 215),
                fontSize: 14,
              ),
            ),
          ],
        ),
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
            "ПРОФИЛЬ",
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
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 10,
              ),
              child: Text(
                'Имя: ' +
                    user.User().name +
                    '\n' +
                    'Возраст: ' +
                    user.User().years.toString(),
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

  Widget btnBackMenu() {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Menu()));
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
}
