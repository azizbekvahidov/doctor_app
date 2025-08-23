import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import '../../../core/design_system/styles/text_styles.dart';

class ActiveCard extends StatelessWidget {
  const ActiveCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      width: 300,
      height: double.infinity,
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            // height: 175,
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.amber,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(Icons.pie_chart, size: 65),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        "Lorem ipsum dolor sit amet, consec tetur",
                        style: WorkSansStyle.bodyLarge,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10),
              Text("Lorem Ipsum"),
              SizedBox(height: 2),
              Row(
                children: [Icon(LucideIcons.mapPin), Text("Lorem ipsum text")],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
