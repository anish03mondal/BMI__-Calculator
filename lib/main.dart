import 'package:flutter/material.dart';
import 'package:myapp/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: SplashScreen(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var wtController = TextEditingController();
  var ftController = TextEditingController();
  var inController = TextEditingController();
  var result = '';
  var bgColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Container(
        color: bgColor,
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              width: 300,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'BMI',
                    style: TextStyle(fontSize: 34, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 25),
                  // Weight Input
                  Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextField(
                        controller: wtController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          label: Text('Enter your weight (in kg)'),
                          prefixIcon: Icon(Icons.line_weight),
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 11),
                  // Height Input in Feet
                  Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextField(
                        controller: ftController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          label: Text('Enter your height (in feet)'),
                          prefixIcon: Icon(Icons.height),
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 8),

                  Text('OR', style: TextStyle(fontSize: 18,
                   fontWeight: FontWeight.bold),),

                  SizedBox(height: 8),
                  // Height Input in Inches
                  Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextField(
                        controller: inController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          label: Text('Enter your height (in inch)'),
                          prefixIcon: Icon(Icons.height),
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      if (wtController.text.isNotEmpty &&
                          (ftController.text.isNotEmpty || inController.text.isNotEmpty)) {
                        var wt = double.tryParse(wtController.text.toString());
                        var ft = double.tryParse(ftController.text.toString());
                        var inc = double.tryParse(inController.text.toString());

                        if (wt != null && wt > 0) {
                          double tInch = 0;

                          // Convert height to inches based on input
                          if (ft != null && ft > 0) {
                            // Prioritize feet if both feet and inches are given
                            tInch = ft * 12;  // Feet to inches conversion
                          } else if (inc != null && inc > 0) {
                            tInch = inc;  // Inches input
                          }

                          if (tInch > 0) {
                            var tcm = tInch * 2.54;  // Convert inches to cm
                            var tm = tcm / 100;  // Convert cm to meters
                            var bmi = wt / (tm * tm);  // Calculate BMI
                            var msg = '';

                            if (bmi > 25) {
                              msg = 'You are overWeight!!';
                              bgColor = Colors.red.shade400;
                            } else if (bmi < 18) {
                              msg = 'You are underWeight!!';
                              bgColor = Colors.orange.shade400;
                            } else {
                              msg = 'You are healthy!!';
                              bgColor = Colors.green.shade400;
                            }

                            setState(() {
                              result = '$msg\nYour BMI is: ${bmi.toStringAsFixed(2)}';
                            });
                          } else {
                            setState(() {
                              result = 'Please enter valid height.';
                            });
                          }
                        } else {
                          setState(() {
                            result = 'Please enter a valid weight.';
                          });
                        }
                      } else {
                        setState(() {
                          result = 'Please fill the required fields';
                        });
                      }
                    },
                    child: Text(
                      'Calculate',
                      style: TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.amber),
                  ),
                  SizedBox(height: 16),
                  Text(
                    result,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
