import 'package:com_4_all/Globals.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:com_4_all/SpeakerPage.dart';
import 'package:com_4_all/AttendeePage.dart';

int index = 1;
bool settings = false;
Future<FirebaseApp> _initialization = initiateFuture();

Future<FirebaseApp> initiateFuture() async{
  var init;
  if (Firebase.apps.length == 0) {
    try {
      init = Firebase.initializeApp(
        name: 'db',
        options: FirebaseOptions(
          appId: '1:1288171748:android:6cf94dac89814af44e7cf1',
          apiKey: 'VC3lpiVM9cQb2opJNZKP70uc64iniz4JKiCmuNGo',
          messagingSenderId: '297855924061',
          projectId: 'com4all',
          databaseURL: 'https://com4all-36c11.firebaseio.com/',
        ),
      );
    }
    finally{
      init = Firebase.initializeApp();
    }
  }
  else{
    init = Firebase.initializeApp();
  }
  return init;
}

void main(){
  runApp(AppInitializer());
}

class AppInitializer extends StatelessWidget {
  // Create the initialization Future outside of `build`:
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          //return SomethingWentWrong();
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return App();
        }

        return LoadingApp();
      },
    );
  }
}

class App extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primaryColor: Colors.deepPurpleAccent,
        primarySwatch: Colors.purple,
      ),
      home: HomePage(title: 'Com4All'),
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void goToAttendeePage(){
    setState(() {
      index = 2;
      settings = false;
    });
  }
  void goToSpeakerPage(){
    setState(() {
      index = 0;
      settings = false;
    });
  }
  void toggleDarkMode(bool value){
    setState(() {
      darkMode = value;
    });
    print(translatorLanguage);
  }
  void _switchLang(String lang){
    translatorLanguage = lang;
    setState(() {

    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new Stack(
        children: <Widget>[
          new Offstage(
            offstage: settings == false,
            child: new TickerMode(
                enabled: index == 2,
                child:  Scaffold(
                  appBar: new AppBar(
                    backgroundColor: Theme.of(context).primaryColor,
                    title: Text("Settings"),
                    actions: [
                      Padding(padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                        child:
                        GestureDetector(
                          child: Icon(Icons.keyboard_return),
                          onTap: (){
                            setState(() {
                              settings = false;
                            });
                          }
                        )
                      )
                    ],
                  ),
                  body: Scaffold(
                    backgroundColor: backgroundColor(),
                    body: Center(
                        child:
                            Column(children: [
                              Container(
                                margin: EdgeInsets.fromLTRB(0, 100, 0, 0),
                                child:
                                Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                  Text("Dark Mode",style: TextStyle(
                                    color: (darkMode ? Color.fromARGB(255, 255, 255, 255) : Colors.black87),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                                  ),
                                  Switch(
                                  value: darkMode,
                                  onChanged: toggleDarkMode,
                                  activeColor: buttonColor(),
                                  activeTrackColor: Colors.grey,
                                )
                              ])
                            ),
                              Container(
                                margin: EdgeInsets.fromLTRB(0, 50, 0, 0),
                                width: 250,
                                child:
                                TextFormField(
                                initialValue: displayName,
                                onChanged: (text) => {
                                  setState(() {
                                  displayName = text;
                                  })},
                                  style: whiteBlackTextStyle(),
                                decoration: InputDecoration(
                                    labelText: "Display name",
                                    labelStyle: TextStyle(
                                        color: Colors.deepPurpleAccent,
                                        fontWeight: FontWeight.bold),
                                  contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                                  enabledBorder:
                                  OutlineInputBorder(
                                      borderSide:  BorderSide(color: Colors.deepPurpleAccent, width:2.0),
                                      borderRadius: BorderRadius.circular(32.0),
                                  ),
                                  focusedBorder:
                                  OutlineInputBorder(
                                    borderSide:  BorderSide(color: Colors.deepPurpleAccent, width:2.0),
                                    borderRadius: BorderRadius.circular(32.0),
                                  ),
                                ),
                                expands: false,
                                maxLines: 1,
                                minLines: 1,
                              )),
                              DropdownButton(
                                dropdownColor: darkMode ? Colors.black : Colors.white,
                                onChanged: (selectedVal) => _switchLang(selectedVal),
                                value: translatorLanguage,
                                items: languages
                                    .map(
                                      (localeName) => DropdownMenuItem(
                                    value: localeName,
                                    child: Text(localeName,style: whiteBlackTextStyle(),),
                                  ),
                                )
                                    .toList(),
                              )
                            ]
                        ),
                    ),
                  ),
                )
            ),
          ),
          new Offstage(
            offstage: (index != 2) || (settings == true),
            child: new TickerMode(
              enabled: index == 2,
              child: new AttendeePage(title: 'Attendee',),
            ),
          ),
          new Offstage(
            offstage: (index != 0) || (settings == true),
            child: new TickerMode(
              enabled: index == 0,
              child: new SpeakerPage(title: 'Speaker',),
            ),
          ),
          new Offstage(
            offstage: (index != 1) || (settings == true),
            child: new TickerMode(
              enabled: index == 1,
              child: Scaffold(
                backgroundColor: backgroundColor(),
                appBar: AppBar(
                  backgroundColor: buttonColor(),
                  title: Text(widget.title),
                  actions: [
                    Padding(padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            settings = true;
                          });
                        },
                        child: Icon(Icons.settings),
                      ),
                    )
                  ],
                ),
                body:  Column(
                    children:[
                    Container(
                        child: RichText(
                          text: TextSpan(
                            style: TextStyle(
                                color: (darkMode ? Color.fromARGB(255, 255, 255, 255) : Colors.black87),
                                fontWeight: FontWeight.bold, fontSize: 38),
                            children: [
                              TextSpan(text: "Welcome to "),
                              TextSpan(text: "Com4All!", style: TextStyle(
                                  color: Theme.of(context).primaryColor)
                              )
                            ]
                          )
                        ),
                        margin: EdgeInsets.all(60),
                      ),
                      Container(
                          child: Text(
                          "Join as", style: TextStyle(
                                  color: (darkMode ? Colors.white : Colors.black87),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 28
                              )
                          ),
                          margin: EdgeInsets.fromLTRB(0, 80, 0, 30)
                      ),
                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                          SizedBox(
                            width: 140,
                            height: 80,
                            child:
                            FlatButton(
                              key: Key("attendeeBtn"),
                              disabledTextColor: Colors.white,
                              disabledColor: Colors.white,
                              color: buttonColor(),
                              child: Text("Attendee",
                                  style:  TextStyle(color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20
                                  )
                              ),
                              onPressed: goToAttendeePage,
                            ),
                          ),
                          SizedBox(
                            width: 30,
                          ),
                          SizedBox(
                            width: 140,
                            height: 80,
                            child:
                            FlatButton(
                              key: Key("speakerBtn"),
                              color: buttonColor(),
                              disabledTextColor: Colors.white,
                              disabledColor: Colors.white,
                              child: Text("Speaker",
                                  style:  TextStyle(color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20
                                  )
                              ),
                              onPressed: goToSpeakerPage,
                        )),
                      ],
                    ),
                  )]
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar:
          new Theme(
            data: Theme.of(context).copyWith(
              // sets the background color of the `BottomNavigationBar`
                canvasColor: Colors.deepPurpleAccent,
                // sets the active color of the `BottomNavigationBar` if `Brightness` is light
                primaryColor: Colors.white,
                textTheme: Theme
                    .of(context)
                    .textTheme
                    .copyWith(caption: new TextStyle(color: Colors.black54))), // sets the inactive color of the `BottomNavigationBar`
            child:
            new BottomNavigationBar(
              currentIndex: index,
              onTap: (int i) {
              setState((){
                index = i;
                settings = false;
                });
              },
              items: <BottomNavigationBarItem>[
              new BottomNavigationBarItem(
                icon: new Icon(Icons.mic),
                label: "Speaker",
              ),
              new BottomNavigationBarItem(
                icon: new Icon(Icons.home),
                label: "Home",
              ),
              new BottomNavigationBarItem(
                icon: new Icon(Icons.speaker_phone),
                label: "Attendee",
            ),
        ],
      )),
    );
  }
}

class LoadingApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Com4All',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: LoadingPage(title: 'Com4All'),
    );
  }
}
class LoadingPage extends StatefulWidget {
  LoadingPage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _LoadingPageState createState() => _LoadingPageState();
}
class _LoadingPageState extends State<LoadingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 20,
            ),
            Text("Loading")
          ],
        ),
      ),
    );
  }
}


