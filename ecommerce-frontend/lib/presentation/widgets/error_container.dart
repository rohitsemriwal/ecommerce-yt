import 'package:ecommerce/core/ui.dart';
import 'package:ecommerce/presentation/widgets/gap_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class ErrorContainer extends StatelessWidget {
  final String error;
  const ErrorContainer({super.key, required this.error});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.red
        ),
        borderRadius: BorderRadius.circular(7),
        color: Colors.red.withOpacity(0.1)
      ),
      child: Row(
        children: [
          const Icon(Icons.warning, color: Colors.red,),

          const GapWidget(),

          Flexible(
            child: Text(error, style: TextStyles.body3.copyWith(
              color: Colors.red
            )),
          ),
        ],
      ),
    );
  }
}