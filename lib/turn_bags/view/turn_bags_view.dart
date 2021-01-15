import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../turn_bags.dart';

/// {@template counter_view}
/// A [StatelessWidget] which reacts to the provided
/// [ConfirmationCubit] state and notifies it in response to user input.
/// {@endtemplate}
class ConfirmationView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(title: const Text('Counter')),
      body: Center(
        child: BlocBuilder<ConfirmationCubit, int>(
          builder: (context, state) {
            return Text('$state', style: textTheme.headline2);
          },
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          FloatingActionButton(
            key: const Key('counterView_increment_floatingActionButton'),
            child: const Icon(Icons.add),
            onPressed: () => context.read<ConfirmationCubit>().increment(),
          ),
          const SizedBox(height: 8),
          FloatingActionButton(
            key: const Key('counterView_decrement_floatingActionButton'),
            child: const Icon(Icons.remove),
            onPressed: () => context.read<ConfirmationCubit>().decrement(),
          ),
        ],
      ),
    );
  }
}
