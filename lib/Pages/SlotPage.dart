import 'package:flutter/material.dart';
import 'package:covidvacineapp/main.dart';


class SlotPage extends StatefulWidget {

  final List slots;

  const SlotPage({super.key, required this.slots});


  @override
  State<SlotPage> createState() => _SlotPageState();
}

class _SlotPageState extends State<SlotPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Available Slot"),
      ),
      body: Container(
        child: ListView.builder(
          itemCount: widget.slots.length,
          itemBuilder: (context,index){
            return Container(
              margin: EdgeInsets.all(9),
              height: 250,
              color: Colors.black38,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Center ID - ' +
                        widget.slots[index]['center_id'].toString(),
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    'Center Name - ' + widget.slots[index]['name'].toString(),
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    'Center Address - ' +
                        widget.slots[index]['address'].toString(),
                    style: TextStyle(fontSize: 16),
                  ),
                  Divider(),
                  Text(
                    'Vaccine Name - ' +
                        widget.slots[index]['vaccine'].toString(),
                    style: TextStyle(fontSize: 16),
                  ),
                  Divider(),
                  Text(
                    'Slots - ' + widget.slots[index]['slots'].toString(),
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
