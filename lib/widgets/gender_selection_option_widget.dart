import 'package:flutter/material.dart';

class ServiceOption extends StatelessWidget {
  final String service;
  final bool isSelected;
  final VoidCallback onTap;

  const ServiceOption({
    super.key,
    required this.service,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
        height: 64,
        child: Card(
          color: isSelected ? Colors.green : Colors.white,
          child: InkWell(
            onTap: onTap,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  service == 'Unisex'
                      ? Icons.wc
                      : service == 'Gents'
                          ? Icons.male
                          : Icons.female,
                  color: isSelected ? Colors.white : Colors.black,
                ),
                Text(
                  service,
                  style: TextStyle(
                    color: isSelected ? Colors.white : Colors.black,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
