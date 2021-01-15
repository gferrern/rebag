import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:rebag_frontend/home/home.dart';
import 'package:rebag_frontend/home/widgets/type_service.dart';
import 'package:rebag_frontend/home/widgets/payment.dart';



class BagWizard extends StatefulWidget {
  @override
  _Wizard createState() => _Wizard();
}

class _Wizard extends State<BagWizard> {
  void onItemPress(BuildContext context, int index) async {
    switch (index) {
      case 0:
        payViaNewCard(context);
        break;
      case 1:
        Navigator.pushNamed(context, '/existing-cards');
        break;
    }
  }

  void payViaNewCard(BuildContext context) async {
    var dialog = ProgressDialog(context);
    dialog.style(message: 'Please wait...');
    await dialog.show();
    var response =
        await StripeService.payWithNewCard(amount: '0,10', currency: 'EUR');
    await dialog.hide();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(response.message),
        duration: new Duration(
            milliseconds: response.success == true ? 1200 : 3000)));
  }

  @override
  void initState() {
    super.initState();
    StripeService.init();
  
    final textTheme = Theme.of(context).textTheme;
    steps = [
      Step(
        title: const Text('Nombre completo'),
        isActive: true,
        state: StepState.indexed,
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
        state: StepState.indexed,
        title: const Text('Dirección'),
        subtitle: const Text('(y guardaremos tus datos para tu proxima vez)'),
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
        state: StepState.indexed,
        title: const Text('¿Cuantas bolsas quieres? ¿de que tamaño?'),
        content: Column(
          children: <Widget>[BagCont(1), BagCont(2)],
        ),
      ),
      Step(
          isActive: false,
          state: StepState.indexed,
          title:
              const Text('¿Que tipo de servicio deseas? ¿Préstamo o Depósito?'),
          content: TypeService()),
      Step(
        state: StepState.indexed,
        title: const Text(
            'Ultimo paso, Necesitamos una imágen para poder reconocerte :-)'),
        subtitle: const Text('Clicka y sonrie :-)'),
        content: Column(
          children: <Widget>[
            const CircleAvatar(
              backgroundColor: Colors.greenAccent,
            )
          ],
        ),
      ),
      Step(
          state: StepState.indexed,
          title: const Text(
              'Ultimo paso, Por favor, revise los datos para poder confirmar el pedido'),
          content: Container(
              padding: EdgeInsets.all(20),
              child: ListView.separated(
                  itemBuilder: (context, index) {
                    Icon icon;
                    Text text;
                    switch (index) {
                      case 0:
                        icon = Icon(Icons.add_circle, color: Colors.blue);
                        text = Text('Pay via new card');
                        break;
                      case 1:
                        icon = Icon(Icons.credit_card, color: Colors.black26);
                        text = Text('Pay via existing card');
                        break;
                    }
                    return InkWell(
                        onTap: () {
                          onItemPress(context, index);
                        },
                        child: ListTile(title: text, leading: icon));
                  },
                  separatorBuilder: (context, index) =>
                      Divider(color: Colors.black26),
                  itemCount: 2)))
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
    return Expanded(
      child: Stepper(
        steps: steps,
        type: StepperType.vertical,
        currentStep: currentStep,
        onStepContinue: next,
        onStepTapped: goTo,
        onStepCancel: cancel,
      ),
    );
  }
}
