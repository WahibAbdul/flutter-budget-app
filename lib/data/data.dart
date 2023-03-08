import 'dart:math';

import 'package:budget_app/models/category_model.dart';
import 'package:budget_app/models/expense_model.dart';

final rand = Random();

final List<double> weeklySpending = [
  rand.nextDouble() * 100,
  rand.nextDouble() * 100,
  rand.nextDouble() * 100,
  rand.nextDouble() * 100,
  rand.nextDouble() * 100,
  rand.nextDouble() * 100,
  rand.nextDouble() * 100,
];

_generateExpenses() {
  List<Expense> expenses = [
    Expense(name: 'Burger', cost: rand.nextDouble() * 90),
    Expense(name: 'Jeans', cost: rand.nextDouble() * 90),
    Expense(name: 'Movie', cost: rand.nextDouble() * 90),
    Expense(name: 'Tickets', cost: rand.nextDouble() * 90),
    Expense(name: 'Morgage', cost: rand.nextDouble() * 90),
    Expense(name: 'Electricity', cost: rand.nextDouble() * 90),
  ];
  return expenses;
}

List<Category> categories = [
  Category(name: 'Food', maxAmount: 450, expenses: _generateExpenses()),
  Category(name: 'Clothing', maxAmount: 500, expenses: _generateExpenses()),
  Category(name: 'Utilities', maxAmount: 600, expenses: _generateExpenses()),
  Category(name: 'Entertainment', maxAmount: 330, expenses: _generateExpenses()),
  Category(name: 'Transportation', maxAmount: 500, expenses: _generateExpenses()),
  Category(name: 'Housing', maxAmount: 1000, expenses: _generateExpenses()),
];
