import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../data/model/transaction_model.dart';
import '../widget/reusables.dart';

class TransactionDetailScreen extends StatefulWidget {
  final Transaction transaction;

  const TransactionDetailScreen({super.key, required this.transaction});

  @override
  State<TransactionDetailScreen> createState() => _TransactionDetailScreenState();
}

class _TransactionDetailScreenState extends State<TransactionDetailScreen> {
  late String _status;
  bool _refunded = false;

  @override
  void initState() {
    super.initState();
    _status = widget.transaction.status;
  }

  void _handleRefund() {
    setState(() {
      _status = "Refunded";
      _refunded = true;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Transaction refunded successfully!'),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final transaction = widget.transaction;

    return Scaffold(
      backgroundColor: const Color(0xFFFFFAFA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Platform.isIOS
            ? IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => NavigationHelper.pop(context),
        )
            : IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => NavigationHelper.pop(context),
        ),
        title: reusableText('Transaction Detail', Colors.black, 18.sp, FontWeight.w500, 0),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: Platform.isIOS ? 20.h : 10.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Hero(
              tag: transaction.id,
              child: CircleAvatar(
                backgroundImage: const AssetImage('assets/image/netflix.png'),
                radius: 40.r,
              ),
            ),
            sb(h: 16.h),
            reusableText(transaction.title, textColor, 22.sp, FontWeight.w700, 0.2),
            sb(h: 2.h),
            reusableText('Production Company', textColor, 13.sp, FontWeight.w600, 0),
            sb(h: 20.h),
            Divider(color: Colors.grey.shade300),
            _buildRow("Amount", "\$${transaction.amount.toStringAsFixed(2)}"),
            _buildRow("Payment Method", "Credit Card"),
            _buildRow("Date", "${transaction.date.toLocal()}"),
            _buildRow("Status", _status, color: _status == "Refunded" ? Colors.red : Colors.green),
            const Spacer(),
            ElevatedButton(
              onPressed: _refunded ? null : _confirmRefund,
              style: ElevatedButton.styleFrom(
                backgroundColor: _refunded ? Colors.grey : textColor,
                padding: EdgeInsets.symmetric(horizontal: 50.w, vertical: 14.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
              child: reusableText(_refunded ? "Refunded" : "Refund", Colors.white, 17.sp, FontWeight.w600, 0.2)
            )
          ],
        ),
      ),
    );
  }

  Widget _buildRow(String title, String value, {Color? color}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          reusableText(title, Colors.grey[800]!, 14.sp, FontWeight.w400, 0),
          reusableText(value, color ?? Colors.black, 14.sp, FontWeight.w600, 0),
        ],
      ),
    );
  }

  void _confirmRefund() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Confirm Refund"),
          content: const Text("Are you sure you want to refund this transaction?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _handleRefund();
              },
              child: const Text("Confirm"),
            ),
          ],
        );
      },
    );
  }
}
