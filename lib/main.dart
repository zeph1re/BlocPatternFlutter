import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_pattern/provider/counter.dart';

// Bloc Provider

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: BlocProvider(
      create: (context) => CounterBloc(),
      child: const HomePage(),
    ));
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    print("build");
    // var bloc = BlocProvider.of<CounterBloc>(context, listen : true);
    // listen digunakan untuk memantau jika terdapat widget baru di luar HomePage

    // context.read, listen = false
    var bloc = context.read<CounterBloc>();

    // context.read, listen = false
    // var bloc = context.watch<CounterBloc>();
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Counter BLoc",
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BlocBuilder<CounterBloc, int>(
                bloc: bloc,
                builder: (context, state) {
                  print("State = $state .... Counter state : ${bloc.counter}");
                  return Text(
                      (state == bloc.counter)
                          ? "You have pushed the button this many times: $state"
                          : "You have pushed the button this many times: ${bloc.counter}",
                      style: const TextStyle(fontSize: 16));
                }),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FloatingActionButton(
                  onPressed: () {
                    bloc.add('minus');
                  },
                  tooltip: 'Decrement',
                  child: const Icon(Icons.remove),
                ),
                FloatingActionButton(
                  onPressed: () {
                    bloc.add("add");
                  },
                  tooltip: 'Increment',
                  child: const Icon(Icons.add),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
