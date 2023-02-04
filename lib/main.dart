import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'Pages/SlotPage.dart';
import 'package:git/git.dart';



void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override

  List<String> list = <String>['01', '02','03', '04','05','06','07','08','09','10','11','12'];
  String dropdownValue = '01';

  List slots = [];


  final TextEditingController _pincontrol = TextEditingController();
  final TextEditingController _datecotrol = TextEditingController();

  fetchSlots()async{
  await http.get(Uri.parse('https://cdn-api.co-vin.in/api/v2/appointment/sessions/public/findByPin?pincode='
      +_pincontrol.text + '&date='
      +_datecotrol.text+
      '%2F' + dropdownValue +
      '%2F2023')).then((value) {
        Map result = jsonDecode(value.body);
        print(result);

        setState(() {
          slots = result['sessions'];
        });

        Navigator.push(context,
            MaterialPageRoute(builder: (context){
              return SlotPage(slots: slots);
            }));

      });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Vacination Slot App"),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Image.network("https://th.bing.com/th/id/OIP.fzpmuKb0HhUHHvwLjgu77wHaEK?w=299&h=180&c=7&r=0&o=5&dpr=1.3&pid=1.7"),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: _pincontrol,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: "Enter Your PIN",
                  
                  prefixIcon: Icon(
                    Icons.pin,
                    color: Colors.red,
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 2,
                      color: Colors.red,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 2,
                      color: Colors.red,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),

              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 66,
                      child:TextFormField(
                        controller: _datecotrol,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: "Enter Date",
                          prefixIcon: Icon(
                            Icons.date_range,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ),
                  ),


                  Expanded(
                    child: DropdownButton<String>(

                      value: dropdownValue,
                      icon: const Icon(Icons.arrow_downward,size:25),
                      elevation: 16,
                      style: const TextStyle(color: Colors.deepPurple),
                      underline: Container(
                        height: 2,
                        color: Colors.deepPurpleAccent,
                      ),
                      onChanged: (String? value) {
                        // This is called when the user selects an item.
                        setState(() {
                          dropdownValue = value!;
                        });
                      },
                      items: list.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 20),

              CupertinoButton(
                color: Colors.blue,
                child: Text("Find Slots"),
                onPressed: (){
                  fetchSlots();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

