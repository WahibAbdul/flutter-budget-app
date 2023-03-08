import 'package:flutter/material.dart';

class BarChart extends StatelessWidget {
  final List<double> expenses;
  final _days = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];

  BarChart({super.key, required this.expenses});

  @override
  Widget build(BuildContext context) {
    double mostExpensive = 0;
    for (var element in expenses) {
      if (element > mostExpensive) {
        mostExpensive = element;
      }
    }

    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        children: [
          Text(
            "Weekly Spending",
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 10.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.arrow_back),
              ),
              Text(
                'Nov 10, 2022 - Nov 16, 2022',
                style: Theme.of(context).textTheme.labelLarge,
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.arrow_forward),
              ),
            ],
          ),
          const SizedBox(height: 30.0),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(
              _days.length,
              (index) {
                return Bar(
                  label: _days[index],
                  amountSpent: expenses[index],
                  mostExpensive: mostExpensive,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class Bar extends StatelessWidget {
  final String label;
  final double amountSpent;
  final double mostExpensive;

  final double _maxBarHeight = 150.0;

  const Bar({
    super.key,
    required this.label,
    required this.amountSpent,
    required this.mostExpensive,
  });

  @override
  Widget build(BuildContext context) {
    final barHeight = amountSpent / mostExpensive * _maxBarHeight;
    return Column(
      children: [
        Text(
          "\$${amountSpent.toStringAsFixed(2)}",
          style: Theme.of(context).textTheme.labelMedium,
        ),
        const SizedBox(height: 6.0),
        Container(
          height: barHeight,
          width: 18.0,
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(6.0),
          ),
        ),
        const SizedBox(height: 8.0),
        Text(
          label,
          style: Theme.of(context).textTheme.labelMedium,
        )
      ],
    );
  }
}
