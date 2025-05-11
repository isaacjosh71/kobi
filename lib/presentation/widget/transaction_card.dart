import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kobi/presentation/widget/reusables.dart';
import '../../data/model/transaction_model.dart';

class TransactionCard extends StatelessWidget {
  final Transaction transaction;
  final VoidCallback onTap;

  const TransactionCard({super.key, required this.transaction, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeIn,
        margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
        padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6.r,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Hero(
              tag: transaction.id,
              child: CircleAvatar(
                backgroundImage: Image.asset(
                    'assets/image/netflix.png',
                    fit: BoxFit.contain).image,
                radius: 27.r,
              ),
            ),
            sb(w: 16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  reusableText(transaction.title, textColor, 15.sp, FontWeight.w600, 0.5),
                  sb(h: 6.h),
                  reusableText(transaction.subtitle, textColor.withOpacity(0.9), 12.sp, FontWeight.w500, 0),
                ],
              ),
            ),
            reusableText('-\$${transaction.amount.toStringAsFixed(2)}',
                Colors.deepOrange, 14.sp, FontWeight.w500, 0),
          ],
        ),
      ),
    );
  }
}
