import 'package:flutter/material.dart';
import 'package:medical_app/widgets/sliver_appbar.dart';

class AboutPage extends StatefulWidget {
  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.all(12.0),
            child: Card(
              color: Colors.grey[200],
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                        "Provider is the officially recommended way to manage app states, "
                        "it's quite similar to ScopedModel in sharing/updating of app's "
                        "state from children widgets down the widgets tree. In addition, "
                        "you can provider multiple states at app root.\n\n"
                        "In this example, the app's root widget is a MultiProvider, which "
                        "provides two states: the number of seconds elapsed (StreamProvider) "
                        "and the counter value(ChangeNotifierProvider).\n\n"
                        "There's a text widget showing the seconds elapsed, and tow card "
                        "widgets showing the counter value. Clicking on child widget's "
                        "button would update the _MyCounterState of the app.\n"
                        "Provider is the officially recommended way to manage app states, "
                        "it's quite similar to ScopedModel in sharing/updating of app's "
                        "state from children widgets down the widgets tree. In addition, "
                        "you can provider multiple states at app root.\n\n"),
                  ),
                ],
              ),
            ),
          ),
        ),
        Expanded(
          flex: 1,
            child: Container(
          child: null,
          width: double.infinity,
        ))
      ],
    );
  }
}
