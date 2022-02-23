import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sample_b/bloc/counter_bloc.dart';
import 'package:sample_b/cubit/counter_cubit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CounterCubit(),
      // create: (context) => CounterBloc(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.teal,
        ),
        // ignore: prefer_const_constructors
        home: MyHomePage(title: 'BLOC & CUBIT'),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    log("Initial stage");
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        centerTitle: true,
      ),
      body: BlocListener<CounterCubit, CounterStates>(
        //
        listener: (context, state) {
          if (state.wasIncremented == true) {
            Scaffold.of(context).showSnackBar(const SnackBar(
              content: Text("Incremented"),
              duration: Duration(seconds: 1),
            ));
          } else if (state.wasIncremented == false) {
            Scaffold.of(context).showSnackBar(const SnackBar(
              content: Text("Decremented"),
              duration: Duration(seconds: 1),
            ));
          }
        },
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'You have pushed the button this many times:',
              ),
              BlocBuilder<CounterCubit, CounterStates>(
                builder: (context, state) {
                  log("Button pressed stage");
                  return Text(
                    '${state.counterValue}',
                    style: Theme.of(context).textTheme.headline4,
                  );
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          FloatingActionButton(
            onPressed: () {
              // context.read<CounterBloc>().add(Decrement()); this is new method

              // BlocProvider.of<CounterBloc>(context).add(Decrement());

              BlocProvider.of<CounterCubit>(context).decrement();
            },
            tooltip: 'Decrement',
            child: const Icon(Icons.remove),
          ),
          FloatingActionButton(
            onPressed: () {
              // context.read<CounterBloc>().add(Increment());

              // BlocProvider.of<CounterBloc>(context).add(Increment());

              BlocProvider.of<CounterCubit>(context).increment();
            },
            tooltip: 'Increment',
            child: const Icon(Icons.add),
          ),
        ],
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
