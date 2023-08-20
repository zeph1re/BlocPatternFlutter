import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_pattern/provider/counter_cubit.dart';
import 'package:flutter_bloc_pattern/provider/theme.dart';

// Bloc Provider

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final ThemeData dark = ThemeData.dark();
  final ThemeData light = ThemeData.light();

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => CounterCubit()),
          BlocProvider(create: (context) => ThemeBloc(false)),
        ],
        child: BlocBuilder<ThemeBloc, bool>(
          builder: (context, state) => MaterialApp(
            theme: state ? dark : light,
            debugShowCheckedModeBanner: false,
            home: HomePage(),
          ),
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
    return Scaffold(
      appBar: AppBar(title: const Text('Counter Apps')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Text
            BlocBuilder<CounterCubit, int>(
              builder: (context, state) => Text(
                "Angka saat ini : $state",
                style: TextStyle(fontSize: 20),
              ),
            ),
            // Button
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FloatingActionButton(
                  onPressed: () {
                    context.read<CounterCubit>().decrement();
                  },
                  child: const Icon(Icons.remove),
                ),
                FloatingActionButton(
                    onPressed: () {
                      context.read<CounterCubit>().increment();
                    },
                    child: const Icon(Icons.add))
              ],
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.read<ThemeBloc>().changeTheme(),
        child: const Icon(Icons.color_lens),
      ),
    );
  }
}
