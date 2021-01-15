import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class TypeService extends StatefulWidget {

  @override
  _TypeService createState() => _TypeService();
}

class _TypeService extends State<TypeService> {

  @override
  void initState() { 
    super.initState();
  }
  List<String> typeService = ['Depósito','Préstamo'];
  List<String> typeServiceImg = ['deposit.json','loan.json'];
  
  int selectedIndex = -1;

  @override
  Widget build(BuildContext context) {

        return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            height: 200,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: typeService.length,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: () => setState(() => selectedIndex=index),
                  child: Container(
                    width: 150,
                    child: Card(
                          shape: (selectedIndex==index)
                              ? RoundedRectangleBorder(
                                  side: BorderSide(color: Colors.green))
                              : null,
                      elevation: 5,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Text(typeService[index]),
                          Lottie.asset('images/${typeServiceImg[index]}'),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          )
        ],
    );
  }
}