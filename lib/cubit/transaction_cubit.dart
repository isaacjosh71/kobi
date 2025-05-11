import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/model/transaction_model.dart';
import '../data/repository/transaction_repo.dart';

enum FilterType { may, april, all }

abstract class TransactionState {}

class TransactionInitial extends TransactionState {}

class TransactionLoading extends TransactionState {}

class TransactionLoaded extends TransactionState {
  final List<Transaction> transactions;

  TransactionLoaded(this.transactions);
}

class TransactionError extends TransactionState {
  final String message;

  TransactionError(this.message);
}

class TransactionCubit extends Cubit<TransactionState> {
  final TransactionRepository repository;
  List<Transaction> _allTransactions = [];

  TransactionCubit(this.repository) : super(TransactionInitial());

  Future<void> loadTransactions() async {
    try {
      emit(TransactionLoading());
      _allTransactions = await repository.fetchTransactions();
      emit(TransactionLoaded(_allTransactions));
    } catch (e) {
      emit(TransactionError(e.toString()));
    }
  }

  void filterTransactions(FilterType type) {
    final now = DateTime.now();
    final all = _allTransactions;
    List<Transaction> filtered;

    switch (type) {
      case FilterType.may:
        filtered = all.where((t) => t.date.month == 5 && t.date.year == now.year).toList();
        break;
      case FilterType.april:
        filtered = all.where((t) => t.date.month == 4 && t.date.year == now.year).toList();
        break;
      case FilterType.all:
      default:
        filtered = all;
    }

    emit(TransactionLoaded(filtered));
  }
}
