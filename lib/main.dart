import 'package:flutter/material.dart';
import 'package:translator/translator.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:flutter/services.dart' show rootBundle;

void main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Translator App",
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
        '/second': (context) => const SecondRoute()
      },
    ));

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String dropdownFrom = "English";
  String dropdownTo = "Hindi";
  String userinput = "";
  String result = "";

  List<String> availableLang = <String>[
    'English',
    'Nepali',
    'Japnease',
    'Korean',
    'Telugu',
    'Gujarati',
    'Hindi',
    'Kannada',
    'Malayalam',
    'Marathi',
    'Tamil'
  ];
  List<String> languageCode = <String>[
    'en',
    'ne',
    'ja',
    'ko',
    'te',
    'gu',
    'hi',
    'kn',
    'ml',
    'mr',
    'ta'
  ];

  getData() async {
    String response;
    response = await rootBundle.loadString('assets/trans_input.txt');
    setState(() {
      userinput = response;
    });
  }

  clear() {
    setState(() {
      result = '';
    });
  }

//Translate
  resultTranslate() async {
    String response;
    response = await rootBundle.loadString('assets/trans_input.txt');
    setState(() {
      userinput = response;
    });
    final FlutterTts tts = FlutterTts();
    tts.setLanguage(languageCode[availableLang.indexOf(dropdownTo)]);
    tts.setSpeechRate(0.8);
    final translator = GoogleTranslator();
    translator
        .translate(userinput,
            from: languageCode[availableLang.indexOf(dropdownFrom)],
            to: languageCode[availableLang.indexOf(dropdownTo)])
        .then(print);
    var translation = await translator.translate(userinput,
        to: languageCode[availableLang.indexOf(dropdownTo)]);

    setState(() {
      result = translation.text;
      tts.speak(result);
    });
    // prints exemplo
  }

// Translate
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Translator App"),
        backgroundColor: const Color(0xFF35BDD0),
      ),
      body: Padding(
        padding: const EdgeInsets.all(40),
        child: ListView(
          children: [
            // First Row
            Row(
              children: [
                const Expanded(flex: 1, child: Text('From:  ')),
                Expanded(
                  flex: 5,
                  child: DropdownButton<String>(
                    value: dropdownFrom,
                    icon: const Icon(Icons.arrow_downward),
                    iconSize: 24,
                    elevation: 16,
                    style: const TextStyle(color: Colors.deepPurple),
                    underline: Container(
                      height: 2,
                      color: Colors.deepPurpleAccent,
                    ),
                    onChanged: (String? newValue) {
                      setState(() {
                        dropdownFrom = newValue!;
                      });
                    },
                    items: availableLang
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
            // Second Row
            Row(
              children: [
                const Expanded(flex: 1, child: Text('To:  ')),
                Expanded(
                  flex: 5,
                  child: DropdownButton<String>(
                    value: dropdownTo,
                    icon: const Icon(Icons.arrow_downward),
                    iconSize: 24,
                    elevation: 16,
                    style: const TextStyle(color: Colors.deepPurple),
                    underline: Container(
                      height: 2,
                      color: Colors.deepPurpleAccent,
                    ),
                    onChanged: (String? newValue) {
                      setState(() {
                        dropdownTo = newValue!;
                      });
                    },
                    items: availableLang
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
            // TextFeild

            const SizedBox(
              height: 10,
            ),
            MaterialButton(
                height: 50,
                color: Colors.blue,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                    side: const BorderSide(
                      color: Colors.blue,
                    )),
                child: const Text('Translate',
                    style: TextStyle(color: Colors.white, fontSize: 20)),
                onPressed: () {
                  resultTranslate();
                }),

            ElevatedButton(
              onPressed: () {
                clear();
              },
              child: const Text(' Clear'),
            ),

            // Result
            const SizedBox(
              height: 10,
            ),
            Center(
                child: Text('Result: $result',
                    style: const TextStyle(color: Colors.black, fontSize: 20))),

            const SizedBox(
              height: 100,
            ),
            const Center(
                child: Text('ASL TRANSLATION',
                    style: TextStyle(color: Colors.black, fontSize: 20))),

            MaterialButton(
                height: 50,
                color: Colors.blue,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                    side: const BorderSide(
                      color: Colors.blue,
                    )),
                child: const Text('Speak Again',
                    style: TextStyle(color: Colors.white, fontSize: 20)),
                onPressed: () {
                  resultTranslate();
                }),
            // ElevatedButt
          ],
        ),
      ),
    );
  }
}

class SecondRoute extends StatelessWidget {
  const SecondRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Click Me Page"),
        backgroundColor: Colors.green,
      ), // AppBar
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Back!'),
        ), // ElevatedButton
      ), // Center
    ); // Scaffold
  }
}
