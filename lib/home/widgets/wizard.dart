import 'package:flutter/material.dart';

class Wizard extends StatefulWidget {
  @override
  _Wizard createState() => _Wizard();
}

class _Wizard extends State<Wizard> {
  
  @override
  void initState() {
    super.initState();

    final textTheme = Theme.of(context).textTheme;
    steps = [
      Step(
        title: const Text('Nombre completo'),
        isActive: true,
        state: StepState.complete,
        content: Column(
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Nombre',
              ),
            ),
            TextFormField(
              decoration: InputDecoration(
                  labelText: 'Apellidos', labelStyle: textTheme.bodyText1),
            ),
          ],
        ),
      ),
      Step(
        isActive: false,
        state: StepState.editing,
        title: const Text('Dirección'),
        content: Column(
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(
                  labelText: '1º Fila', labelStyle: textTheme.bodyText1),
            ),
            TextFormField(
              decoration: InputDecoration(
                  labelText: '2º Fila', labelStyle: textTheme.bodyText1),
            ),
          ],
        ),
      ),
            Step(
        isActive: false,
        state: StepState.editing,
        title: const Text('Dirección'),
        content: Column(
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(
                  labelText: '1º Fila', labelStyle: textTheme.bodyText1),
            ),
            TextFormField(
              decoration: InputDecoration(
                  labelText: '2º Fila', labelStyle: textTheme.bodyText1),
            ),
          ],
        ),
      ),
      Step(
        state: StepState.complete,
        title: const
        Text('Ultimo paso, Necesitamos una imágen para poder reconocerte :-)'),
        subtitle: const Text('Clicka y sonrie :-)'),
        content: Column(
          children: <Widget>[
            const CircleAvatar(
              backgroundColor: Colors.greenAccent,
            )
          ],
        ),
      ),
    ];
  }

  int currentStep = 0;
  bool complete = false;
  List<Step> steps = [];

  void next() {
    currentStep + 1 != steps.length
        ? goTo(currentStep + 1)
        : setState(() => complete = true);
  }

  void cancel() {
    if (currentStep > 0) {
      goTo(currentStep - 1);
    }
  }

  void goTo(int step) {
    setState(() => currentStep = step);
  }

  @override
  Widget build(BuildContext context) {
    return 
          Expanded(
            child: Stepper(
              steps: steps,
              currentStep: currentStep,
              onStepContinue: next,
              onStepTapped: goTo,
              onStepCancel: cancel,
            ),
          )
        ;
  }
}
