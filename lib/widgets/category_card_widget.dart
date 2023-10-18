import 'package:flutter/material.dart';
import 'package:glamourmebusiness/constants.dart';
import 'package:glamourmebusiness/models/category_model.dart';
import 'package:glamourmebusiness/screens/business_create_screen2.dart';

class CategoryCardWidget extends StatelessWidget {
  const CategoryCardWidget(this.checkBoxItem, this.onTap, {super.key});

  final CategoryCheckboxType checkBoxItem;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 160,
            height: 190,
            decoration: BoxDecoration(
              border: Border.all(
                color: checkBoxItem.isChecked ? green1 : borderGrey,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Card(
                  shape: const CircleBorder(),
                  elevation: 0,
                  child: InkWell(
                    child: Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: checkBoxItem.isChecked ? green1 : borderGrey,
                          width: checkBoxItem.isChecked ? 3 : 1,
                        ),
                        image: DecorationImage(
                          image: NetworkImage(
                            checkBoxItem.category.imageUrl,
                          ),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                ),
                Text(
                  checkBoxItem.category.name,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: checkBoxItem.isChecked ? green1 : black1,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
