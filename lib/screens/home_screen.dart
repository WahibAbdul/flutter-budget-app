import 'package:budget_app/data/data.dart';
import 'package:budget_app/helpers/color_helper.dart';
import 'package:budget_app/models/category_model.dart';
import 'package:budget_app/screens/category_screen.dart';
import 'package:budget_app/widgets/bar_chart.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _buildAppBar(),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              childCount: 1 + categories.length,
              (context, index) {
                if (index == 0) {
                  return Container(
                    margin: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 10.0),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: const [
                          BoxShadow(color: Colors.black12, offset: Offset(0, 2), blurRadius: 6.0),
                        ],
                        borderRadius: BorderRadius.circular(10.0)),
                    child: BarChart(expenses: weeklySpending),
                  );
                } else {
                  final category = categories[index - 1];
                  double totalAmountSpent =
                      category.expenses.fold<double>(0, (previousValue, element) => previousValue + element.cost);
                  return _buildCategory(context, category, totalAmountSpent);
                }
              },
            ),
          )
        ],
      ),
    );
  }

  SliverAppBar _buildAppBar() {
    return SliverAppBar(
      // expandedHeight: 100.0,
      forceElevated: true,
      pinned: true,
      floating: true,
      flexibleSpace: const FlexibleSpaceBar(title: Text("Simple Budget")),
      leading: IconButton(
        onPressed: () {},
        icon: const Icon(Icons.settings),
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.add),
        )
      ],
    );
  }
}

Widget _buildCategory(BuildContext context, Category category, double totalAmountSpent) {
  return GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => CategoryScreen(category: category),
        ),
      );
    },
    child: Container(
      margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      padding: const EdgeInsets.all(20.0),
      height: 100,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: const [
          BoxShadow(color: Colors.black12, offset: Offset(0, 2), blurRadius: 6.0),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                category.name,
                style: Theme.of(context).textTheme.labelLarge,
              ),
              Text(
                '\$${(category.maxAmount - totalAmountSpent).toStringAsFixed(2)} / \$${category.maxAmount.toStringAsFixed(2)}',
                style: Theme.of(context).textTheme.labelLarge,
              ),
            ],
          ),
          const SizedBox(height: 10.0),
          LayoutBuilder(
            builder: (context, constraints) {
              final double maxBarWidth = constraints.maxWidth;
              final double percent = (category.maxAmount - totalAmountSpent) / category.maxAmount;
              double barWidth = percent * maxBarWidth;
              barWidth = barWidth < 0 ? 0 : barWidth;
              return Stack(
                children: [
                  Container(
                    height: 20.0,
                    decoration: BoxDecoration(color: Colors.grey[200], borderRadius: BorderRadius.circular(15.0)),
                  ),
                  Container(
                    height: 20.0,
                    width: barWidth,
                    decoration:
                        BoxDecoration(color: getColor(context, percent), borderRadius: BorderRadius.circular(15.0)),
                  ),
                ],
              );
            },
          )
        ],
      ),
    ),
  );
}
