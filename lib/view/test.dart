import 'package:covid/services/firestore.dart';
import 'package:covid/view/menu.dart';
import 'package:flutter/material.dart';
import 'package:covid/lib/theme/colors.dart';

void main() {
  runApp(const Test());
}

class Test extends StatelessWidget {
  const Test({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Covid-19',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: Color.fromARGB(217, 123, 123, 123),
      ),
      home: const MyHomePage(title: 'Авторизация'),
      debugShowCheckedModeBanner: false,
    );
  }
}

// enum Gender { none, Male, Female, Utug }
List<bool> isSelected = [];
List<bool> isSelected1 = [];
List<bool> isSelected2 = [];
TextEditingController ansPointsController = TextEditingController();
TextEditingController ansPointsController1 = TextEditingController();
TextEditingController obsh = TextEditingController();

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  int countTest = 0;

  //
  // Gender? _character = Gender.none;

  //initState - срабатывает при создании виджета
  @override
  void initState() {
    isSelected = [false, true, false];
    isSelected1 = [false, true, false];
    isSelected2 = [false, true, false];

    super.initState();
  }

  //закрытие процессов фокуснода
  @override
  void dispose() {
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
              upPole1(),
              firstQuestion(),
              secondQuestion(),
              thirdQuestion(),
              fourthQuestion(),
              fifthQuestion(),
              btnViewTestResult(),
              btnBacktoMenu(),
            ],
          ),
        ),
      ),
    );
  }

  Widget invisHelp() {
    return Text(obsh.toString());
  }

  Widget invisHelp1() {
    return TextFormField(
        textAlignVertical: TextAlignVertical.center,
        keyboardType: TextInputType.numberWithOptions(decimal: false),
        controller: obsh,
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.all(15.0),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: cvet1, width: 2.0),
            borderRadius: BorderRadius.all(Radius.circular(15.0)),
          ),
          fillColor: Color(0xD9D9D9),
          filled: true,
          hintText: ".",
        ));
  }

  Widget upPole2() {
    return Container(
      color: color_bar,
      child: Column(
        children: <Widget>[
          Row(children: [Container()])
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
            "ТЕСТ",
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

  Widget btnViewTestResult() {
    return ElevatedButton(
      onPressed: () {
        if (ansPointsController.text.isEmpty ||
            ansPointsController.text.isEmpty) {
          showDialog(
            context: context,
            builder: (_) => AlertDialog(
              content: const Text('Заполните все поля!'),
            ),
          );
        } else {
          countTest = countTest +
              int.parse(ansPointsController.text) +
              int.parse(ansPointsController1.text);
          if (countTest <= 5) {
            showDialog(
                context: context,
                builder: (_) => AlertDialog(
                      content: Text(
                        'Ваш результат: ' +
                            countTest.toString() +
                            ' баллов.' +
                            '\n' +
                            'Риск быть инфицированным: ' +
                            (countTest * 0.03 * 100).toString() +
                            '%',
                      ),
                    ));
          }
          if (countTest == 6 && countTest < 10) {
            showDialog(
                context: context,
                builder: (_) => AlertDialog(
                      content: Text(
                        'Ваш результат: ' +
                            countTest.toString() +
                            ' баллов.' +
                            '\n' +
                            'Риск быть инфицированным: ' +
                            (countTest * 0.09 * 100).toString() +
                            '%',
                      ),
                    ));
          }
          if (countTest >= 10 && countTest <= 17) {
            showDialog(
                context: context,
                builder: (_) => AlertDialog(
                      content: Text(
                        'Ваш результат: ' +
                            countTest.toString() +
                            ' баллов.' +
                            '\n' +
                            'Риск быть инфицированным: ' +
                            (countTest * 0.15 * 100).toString() +
                            '%',
                      ),
                    ));
          }
          if (countTest >= 18) {
            showDialog(
                context: context,
                builder: (_) => AlertDialog(
                      content: Text(
                        'Ваш результат: ' +
                            countTest.toString() +
                            ' баллов.' +
                            '\n' +
                            'Риск быть инфицированным: ' +
                            (countTest * 0.03 * 10000).toString() +
                            '%',
                      ),
                    ));
          }

          FireStore.setTesti(countTest, DateTime.now());

          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Menu()));
          ansPointsController.clear();
          ansPointsController1.clear();
        }
      },
      child: Text("Узнать результат"),
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

  Widget btnBacktoMenu() {
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

  Widget firstQuestion() {
    return Container(
        padding: EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 5,
        ),
        //color: color_elem,
        child: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
              Container(
                child: Text(
                  'Вы курите?',
                  style: new TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ),
              ToggleButtons(
                disabledColor: Colors.grey[300],
                disabledBorderColor: Colors.blueGrey,
                children: <Widget>[
                  Icon(Icons.arrow_drop_down_outlined),
                  Icon(Icons.self_improvement_sharp),
                  Icon(Icons.arrow_drop_up_outlined),
                ],
                isSelected: isSelected,
                onPressed: (int index) {
                  setState(() {
                    for (int buttonIndex = 0;
                        buttonIndex < isSelected.length;
                        buttonIndex++) {
                      if (buttonIndex == index) {
                        isSelected[buttonIndex] = !isSelected[buttonIndex];
                        if (isSelected[0]) {
                          //countTest--;
                          print(countTest--);
                          //print(countTest);
                        }
                        if (isSelected[1]) {
                          countTest;
                          print(countTest);
                        }
                        if (isSelected[2]) {
                          countTest++;
                          print(countTest);
                        }
                        ;
                      } else {
                        isSelected[buttonIndex] = false;
                      }
                    }
                  });
                },
              )
            ])));
  }

  Widget secondQuestion() {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 5,
      ),
      //color: color_elem,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              child: Text(
                'Есть ли у Вас сезонная аллергия?',
                style: new TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
            ),
            ToggleButtons(
              disabledColor: Colors.grey[300],
              disabledBorderColor: Colors.blueGrey,
              children: <Widget>[
                Icon(Icons.arrow_drop_down_outlined),
                Icon(Icons.self_improvement_sharp),
                Icon(Icons.arrow_drop_up_outlined),
              ],
              isSelected: isSelected1,
              onPressed: (int index1) {
                setState(() {
                  for (int buttonIndex1 = 0;
                      buttonIndex1 < isSelected1.length;
                      buttonIndex1++) {
                    if (buttonIndex1 == index1) {
                      isSelected1[buttonIndex1] = !isSelected1[buttonIndex1];
                      if (isSelected1[0]) {
                        print(countTest--);
                      }
                      if (isSelected1[1]) {
                        countTest;
                        print(countTest);
                      }
                      if (isSelected1[2]) {
                        countTest++;
                        print(countTest);
                      }
                      ;
                    } else {
                      isSelected1[buttonIndex1] = false;
                    }
                  }
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget thirdQuestion() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 5,
            ),
            child: Text(
              'Сколько пунктов соответствуют вашему здоровью?',
              style: new TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
          ),
          Container(
            child: Text(
              '- Сердечно-сосудистые заболевания' +
                  '\n' +
                  '- Хронические заболевания легких' +
                  '\n' +
                  '- Иммунодефицит' +
                  '\n' +
                  '- Онкологические заболевания' +
                  '\n' +
                  '- Вирусный гепатит' +
                  '\n' +
                  '- Почечная недостаточность' +
                  '\n' +
                  '- Цереброваскулярная болезнь' +
                  '\n' +
                  '- Повышенное давление',
              style: new TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ),
          TextFormField(
              textAlignVertical: TextAlignVertical.center,
              keyboardType: TextInputType.numberWithOptions(decimal: false),
              controller: ansPointsController,
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.all(15.0),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: cvet1, width: 2.0),
                  borderRadius: BorderRadius.all(Radius.circular(15.0)),
                ),
                fillColor: Color(0xD9D9D9),
                filled: true,
                hintText: "Введите количество совпадений",
              ))
        ],
      ),
    );
  }

  Widget fourthQuestion() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 5,
            ),
            child: const Text(
              'Сделайте глубокий вдох и задержите дыхание более чем на 10 секунд. Что Вы ощущаете?',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
          ),
          ToggleButtons(
            disabledColor: Colors.grey[300],
            disabledBorderColor: Colors.blueGrey,
            children: const <Widget>[
              Text('Ничего'),
              Icon(Icons.self_improvement_sharp),
              Text('Боль'),
            ],
            isSelected: isSelected2,
            onPressed: (int index2) {
              setState(() {
                for (int buttonIndex2 = 0;
                    buttonIndex2 < isSelected2.length;
                    buttonIndex2++) {
                  if (buttonIndex2 == index2) {
                    isSelected2[buttonIndex2] = !isSelected2[buttonIndex2];
                    if (isSelected2[0]) {
                      //countTest--;
                      print(countTest--);
                      //print(countTest);
                    }
                    if (isSelected2[1]) {
                      countTest;
                      print(countTest);
                    }
                    if (isSelected2[2]) {
                      countTest++;
                      print(countTest);
                    }
                    ;
                  } else {
                    isSelected2[buttonIndex2] = false;
                  }
                }
              });
            },
          ),
        ],
      ),
    );
  }

  Widget fifthQuestion() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 0,
            ),
            child: Text(
              'Сколько из перечисленных симптомов Вы у себя замечаете?',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
          ),
          Container(
            child: Text(
              '- повышение температуры' +
                  '\n' +
                  '- кашель' +
                  '\n' +
                  '- утомляемость' +
                  '\n' +
                  '- потеря обоняния и вкусовых ощущений' +
                  '\n' +
                  '- боль в горле' +
                  '\n' +
                  '- головная боль' +
                  '\n' +
                  '- диарея' +
                  '\n' +
                  '- сыпь на коже или изменение цвета кожи на пальцах рук или ног',
              style: new TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ),
          TextFormField(
              textAlignVertical: TextAlignVertical.center,
              keyboardType: TextInputType.number,
              controller: ansPointsController1,
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.all(15.0),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: cvet1, width: 2.0),
                  borderRadius: BorderRadius.all(Radius.circular(15.0)),
                ),
                fillColor: Color(0xD9D9D9),
                filled: true,
                hintText: "Введите количество симптомов",
              ))
        ],
      ),
    );
  }
}
