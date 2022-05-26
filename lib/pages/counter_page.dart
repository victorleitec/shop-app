import 'package:flutter/material.dart';
import 'package:shop/providers/counter.dart';

class CounterPage extends StatefulWidget {
  const CounterPage({Key? key}) : super(key: key);

  @override
  State<CounterPage> createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Counter Example"),
      ),
      body: Column(
        children: [
          Text(
            CounterProvider.of(context)?.state.value.toString() ?? "0",
            style: const TextStyle(color: Colors.black),
          ),
          IconButton(
            onPressed: () {
              setState(() {
                CounterProvider.of(context)?.state.inc();
              });
            },
            icon: const Icon(Icons.add),
          ),
          IconButton(
            onPressed: () {
              setState(() {
                CounterProvider.of(context)?.state.dec();
              });
              print(CounterProvider.of(context)?.state.value);
            },
            icon: const Icon(Icons.remove),
          )
        ],
      ),
    );
  }
}
