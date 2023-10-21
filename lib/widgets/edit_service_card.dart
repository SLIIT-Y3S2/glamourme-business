import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:glamourmebusiness/models/service_model.dart';

class EditServiceCard extends StatelessWidget {
  const EditServiceCard({
    required this.salonId,
    required this.service,
    super.key,
  });
  final String salonId;
  final ServiceModel service;

  @override
  Widget build(BuildContext context) {
    return Card(
      surfaceTintColor: Colors.white,
      color: Colors.white,
      clipBehavior: Clip.hardEdge,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            clipBehavior: Clip.hardEdge,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(8),
                bottomRight: Radius.circular(8),
              ),
            ),
            child: Image.network(
              service.imageUrl,
              height: 90,
              width: 90,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  service.name,
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                ),
                const SizedBox(
                  width: 8,
                ),
                Text(
                  service.price.toString(),
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontSize: 13,
                        color: Colors.grey.shade600,
                        fontWeight: FontWeight.w400,
                      ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.av_timer_outlined,
                      size: 20,
                      color: Colors.grey,
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    Text(
                      '${service.duration} min',
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            fontSize: 13,
                            color: Colors.grey.shade600,
                            fontWeight: FontWeight.w400,
                          ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
              ],
            ),
          ),
          const Spacer(),
          ElevatedButton(
              onPressed: () {
                // Navigator.of(context).push(
                //   MaterialPageRoute(
                //     builder: (context) => PlaceAppointmentScreen(
                //       salonId: salonId,
                //       service: service,
                //       openingTime: openingTime,
                //       closingTime: closingTime,
                //     ),
                //   ),
                // );
              },
              style: ElevatedButton.styleFrom(
                elevation: 8,
                surfaceTintColor: Colors.white,
                backgroundColor: Colors.white,
                shadowColor: Colors.black54,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                  side: BorderSide(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
              child: const Text("Edit"))
        ],
      ),
    );
  }
}
