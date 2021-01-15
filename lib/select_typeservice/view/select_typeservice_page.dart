import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../select_typeservice.dart';
import 'select_typeservice_view.dart';

/// {@template counter_page}
/// A [StatelessWidget] which is responsible for providing a
/// [SelectTypeServiceCubit] instance to the [SelectTypeServiceView].
/// {@endtemplate}
class BagsCounterPage extends StatelessWidget {
  /// {@macro counter_page}
  const BagsCounterPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SelectTypeServiceCubit(),
      child: SelectTypeServiceView(),
    );
  }
}
