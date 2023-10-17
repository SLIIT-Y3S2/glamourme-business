import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:glamourmebusiness/constants.dart';
import 'package:glamourmebusiness/data/service_categories.dart';
import 'package:glamourmebusiness/models/category_model.dart';
import 'package:glamourmebusiness/screens/business_create_screen3.dart';
import 'package:glamourmebusiness/widgets/category_card_widget.dart';

class BusinessCreationServiceSelection extends StatefulWidget {
  const BusinessCreationServiceSelection({super.key});

  @override
  State<BusinessCreationServiceSelection> createState() =>
      _BusinessCreationServiceSelectionState();
}

class _BusinessCreationServiceSelectionState
    extends State<BusinessCreationServiceSelection> {
  late List<CustomCheckboxType> _checkboxList;

  @override
  void initState() {
    super.initState();
    _checkboxList = [...categoryData.map((e) => CustomCheckboxType(e, false))];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          // title: const Text('Create Business'),
          ),
      body: Container(
        padding: const EdgeInsets.fromLTRB(24, 16, 24, 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'What services do you offer?',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFF1C1C28),
                fontSize: 23,
                fontFamily: 'DM Sans',
                fontWeight: FontWeight.w700,
                height: 0,
                letterSpacing: -0.46,
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: SizedBox(
                height: 200,
                child: OrientationBuilder(builder: (context, orientation) {
                  return GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount:
                          orientation == Orientation.portrait ? 2 : 4,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                    ),
                    itemBuilder: (context, index) => CategoryCardWidget(
                      _checkboxList[index],
                      () {
                        setState(() {
                          _checkboxList[index].isChecked =
                              !_checkboxList[index].isChecked;
                        });
                      },
                    ),
                    itemCount: categoryData.length,
                  );
                }),
              ),
            ),
            // TODO remove: diplay all the selected services in a list
            Text(
              _checkboxList
                  .where((element) => element.isChecked)
                  .map((e) => e.category.name)
                  .toList()
                  .toString(),
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.fromLTRB(24, 8, 24, 16),
        child: _nextButton(context),
      ),
    );
  }

  Widget _nextButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          _checkboxList
                  .where((element) => element.isChecked)
                  .map((e) => null)
                  .isNotEmpty
              ? Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        const BusinessCreationLocationDetails(),
                  ),
                )
              : null;
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: _checkboxList
                  .where((element) => element.isChecked)
                  .map((e) => null)
                  .isNotEmpty
              ? Color(signupScreenColor)
              : Colors.grey,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: const Text(
          'Next',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontFamily: 'DM Sans',
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}

class CustomCheckboxType {
  final CategoryModel category;
  bool isChecked;

  CustomCheckboxType(this.category, this.isChecked);
}
