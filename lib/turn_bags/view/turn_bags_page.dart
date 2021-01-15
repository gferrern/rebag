import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../turn_bags.dart';
import 'turn_bags_view.dart';

/// {@template counter_page}
/// A [StatelessWidget] which is responsible for providing a
/// [ConfirmationCubit] instance to the [ConfirmationView].
/// {@endtemplate}
class ConfirmationPage extends StatelessWidget {
  /// {@macro counter_page}
  const ConfirmationPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ConfirmationCubit(),
      child: ConfirmationView(),
    );
  }
}
