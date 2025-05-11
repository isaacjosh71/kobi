import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kobi/presentation/screen/home_screen.dart';
import 'package:kobi/presentation/widget/reusables.dart';
import 'cubit/transaction_cubit.dart';
import 'data/repository/transaction_repo.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  ScreenUtil.ensureScreenSize();
  runApp(const TransactionApp());
}

class TransactionApp extends StatelessWidget {
  const TransactionApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Transaction Tracker',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFF9F9FB),
        primarySwatch: Colors.deepPurple,
        fontFamily: 'Manrope',
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme: IconThemeData(color: textColor),
          titleTextStyle: TextStyle(color: textColor, fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
      home: RepositoryProvider(
        create: (_) => TransactionRepository(),
        child: BlocProvider(
          create: (context) =>
          TransactionCubit(context.read<TransactionRepository>())..loadTransactions(),
          child: ScreenUtilInit(
              ensureScreenSize: true,
              useInheritedMediaQuery: true,
              designSize: const Size(390, 844),
              minTextAdapt: true,
              splitScreenMode: true,
              builder: (context, child) {
              return const HomeScreen();
            }
          ),
        ),
      ),
    );
  }
}
