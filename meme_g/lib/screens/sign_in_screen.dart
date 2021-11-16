import 'package:flutter/material.dart';
import 'account_details_screen.dart';
class signIn extends  StatelessWidget
{
  @override
  Widget build(BuildContext context)
  {
    return  Scaffold(
        /*appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),*/
        body: Center(
      // Center is a layout widget. It takes a single child and positions it
      // in the middle of the parent.
      child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              child: FlatButton(
                textColor: Colors.white,
                color: Colors.green,
                //foregroundColor: Colors.green,
                //backgroundColor: Colors.white,
                onPressed: () {},
                child: const Text(
                  'Sign In',
                ),
              ),
            ),
            Container(
              child: FlatButton(
                textColor: Colors.white,
                color: Colors.green,
                //foregroundColor: Colors.green,
                //backgroundColor: Colors.white,
                onPressed: () {},
                child: const Text(
                  'Guest',
                ),
              ),
            ),
            Row(mainAxisAlignment: MainAxisAlignment.center,
                children: [
              Container(
                child: TextButton(

                  //foregroundColor: Colors.green,
                  //backgroundColor: Colors.white,
                  onPressed: () {},
                  child: const Text(
                    'New user ?',
                  ),
                ),
              ),
              Container(
                child: TextButton(

                  onPressed: (){Navigator.pushNamed(context, Account_det.route);
                  print('accounts_det screen called');},
                  child: const Text('Create Account'),
                ),
              )
            ])
          ]
          /*floatingActionButton : FloatingActionButton(child : const Text(
        'You have pushed the button this many times:',
      ),
        Text(
          '$_counter',
          style: Theme.of(context).textTheme.headline4,
        ),*/
          ),
    ));
    /* floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),*/ // This trailing comma makes auto-formatting nicer for build methods.
  }
  }


  
  