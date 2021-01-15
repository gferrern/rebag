import 'package:flutter/material.dart';

const _max = 10;

class BagCont extends StatefulWidget {
  final int initNumber;
  final int typebag;
  final Function(int) counterCallback;
  final Function increaseCallback;
  final Function decreaseCallback;
  BagCont(int this.typebag,
      {this.initNumber,
      this.counterCallback,
      this.increaseCallback,
      this.decreaseCallback});
  @override
  _BagCont createState() => _BagCont();
}

class _BagCont extends State<BagCont> {
  int _currentCount;
  Function _counterCallback;
  Function _increaseCallback;
  Function _decreaseCallback;
  int _typebag;
  @override
  void initState() {
    _typebag =  widget.typebag ?? 1;
    _currentCount = widget.initNumber ?? 1;
    _counterCallback = widget.counterCallback ?? (int number) {};
    _increaseCallback = widget.increaseCallback ?? () {};
    _decreaseCallback = widget.decreaseCallback ?? () {};
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

        return Container(
          padding: EdgeInsets.zero,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30.0),
            color: Colors.lightGreenAccent,
          ),
          child:Column(
              children:[
                Card(
                  child:Image.asset('images/typebag${_typebag}.png',fit: BoxFit.cover),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0),)
              ),
            Row(
              children: [
                _createIncrementDicrementButton(Icons.remove, _dicrement),
                Text(_currentCount.toString()),
                _createIncrementDicrementButton(Icons.add, _increment),
            ])
          ]
        )
    );
  }

  void _increment() {
    setState(() {
      if (_currentCount + 1 <= _max) {
        _currentCount++;
      }
      _counterCallback(_currentCount);
      _increaseCallback();
    });
  }

  void _dicrement() {
    setState(() {
      if (_currentCount > 0) {
        _currentCount--;
        _counterCallback(_currentCount);
        _decreaseCallback();
      }
    });
  }

  Widget _createIncrementDicrementButton(IconData icon, Function() onPressed) {
    return RawMaterialButton(
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        constraints: BoxConstraints(minWidth: 32.0, minHeight: 32.0),
        onPressed: onPressed,
        elevation: 2.0,
        fillColor: Colors.lightGreen,
        child: Icon(
          icon,
          color: Colors.green,
          size: 12.0,
        ),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
            side: const BorderSide(color: Colors.red)));
  }
}
