import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bagsCounter.dart';
import 'bagsCounter_view.dart';

/// {@template counter_page}
/// A [StatelessWidget] which is responsible for providing a
/// [BagsCounterCubit] instance to the [BagsCounterView].
/// {@endtemplate}
class BagsCounterPage extends StatelessWidget {
  /// {@macro counter_page}
  const BagsCounterPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => BagsCounterCubit(),
      child: BagsCounterView(),
    );
  }
}
