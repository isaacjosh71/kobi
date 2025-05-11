import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:kobi/presentation/screen/transaction_detail.dart';

import '../../cubit/transaction_cubit.dart';
import '../../data/model/transaction_model.dart';
import '../widget/reusables.dart';
import '../widget/expense_chart.dart';
import '../widget/transaction_card.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  FilterType _currentFilter = FilterType.may;

  @override
  void initState() {
    super.initState();
    context.read<TransactionCubit>().filterTransactions(_currentFilter);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFAFA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        title: reusableText('History', Colors.black, 18.sp, FontWeight.w500, 0),
        leading: Platform.isIOS
            ? const Icon(Icons.arrow_back_ios)
            : const Icon(Icons.arrow_back),
        actions: const [Icon(Icons.more_vert)],
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: 16.h),
          child: Column(
            children: [
              CircleAvatar(
                backgroundImage: Image.asset(
                    'assets/image/netflix.png',
                    fit: BoxFit.contain).image,
                radius: 30.r,
              ),
              sb(h: 4.h),
              reusableText('Netflix', textColor, 22.sp, FontWeight.w700, 0.2),
              sb(h: 2.h),
              reusableText('Production Company', textColor, 13.sp, FontWeight.w600, 0),
              sb(h: 16.h),
              BlocBuilder<TransactionCubit, TransactionState>(
                builder: (context, state) {
                  if (state is TransactionLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is TransactionLoaded) {
                    final expenses = _calculateExpenses(state.transactions);
                    final total = state.transactions.fold(0.0, (sum, item) => sum + item.amount);
                    return Column(
                      children: [
                        _buildTotalSection(context, state.transactions),
                        ExpenseChart(dataMap: expenses, total: total, currentFilter: _currentFilter.name,),
                        AnimationLimiter(
                          child: ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: state.transactions.length,
                            itemBuilder: (context, index) {
                              return AnimationConfiguration.staggeredList(
                                position: index,
                                duration: const Duration(milliseconds: 600),
                                child: SlideAnimation(
                                    verticalOffset: 50.0,
                                    child: FadeInAnimation(
                                        child: TransactionCard(transaction: state.transactions[index],
                                          onTap: () {
                                            NavigationHelper.navigateToPageRLW(
                                              context, TransactionDetailScreen(
                                                transaction: state.transactions[index]), widget);
                                          }))),
                              );
                            },
                          ),
                        ),
                      ],
                    );
                  } else if (state is TransactionError) {
                    return Center(child: Text(state.message));
                  }
                  return Container();
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFilterDropdown(BuildContext context) {
    return Flexible(
      child: Container(
        height: 40.h,
        width: 80.w,
        padding: EdgeInsets.symmetric(horizontal: 12.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<FilterType>(
            value: _currentFilter,
            icon: const Icon(Icons.keyboard_arrow_down_rounded),
            isExpanded: true,
            style: const TextStyle(color: textColor, fontWeight: FontWeight.w600),
            items: const [
              DropdownMenuItem(value: FilterType.may, child: Text("May")),
              DropdownMenuItem(value: FilterType.april, child: Text("April")),
              DropdownMenuItem(value: FilterType.all, child: Text("All")),
            ],
            onChanged: (value) {
              if (value != null) {
                setState(() => _currentFilter = value);
                context.read<TransactionCubit>().filterTransactions(value);
              }
            },
          ),
        ),
      ),
    );
  }


  Widget _buildTotalSection(BuildContext context, List<Transaction> transactions) {
    final total = transactions.fold(0.0, (sum, item) => sum + item.amount);
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Total Payment", style: TextStyle(fontSize: 13.sp)),
              reusableText("\$${total.toStringAsFixed(2)}", textColor, 32.sp, FontWeight.bold, 0)
            ],
          ),
          _buildFilterDropdown(context)
        ],
      ),
    );
  }

  Map<String, double> _calculateExpenses(List<Transaction> transactions) {
    final Map<String, double> dataMap = {};
    for (var t in transactions) {
      dataMap.update(t.category, (value) => value + t.amount, ifAbsent: () => t.amount);
    }
    return dataMap;
  }
}
