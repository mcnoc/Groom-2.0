import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:groom/states/provider_state.dart';

class GroomerTypeChoice extends StatelessWidget {
  final formController = Get.put(FormController());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Obx(() {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Groomer Type:"),
            SizedBox(height: 8.0),
            Row(
              children: [
                ChoiceChip(
                  label: Text('Salon'),
                  selected: formController.selectedGroomerType.value == 'Salon',
                  onSelected: (selected) {
                    if (selected) {
                      formController.selectedGroomerType.value = 'Salon';
                    }
                  },
                ),
                SizedBox(width: 8.0),
                ChoiceChip(
                  label: Text('Independent'),
                  selected: formController.selectedGroomerType.value == 'Independent',
                  onSelected: (selected) {
                    if (selected) {
                      formController.selectedGroomerType.value = 'Independent';
                    }
                  },
                ),

              ],
            ),
            if (formController.selectedGroomerType.value == 'Salon')
              SizedBox(
                child: Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: TextFormField(
                    decoration: InputDecoration(labelText: 'Salon Description'),
                    onChanged: (value) {
                      formController.salonDescription.value = value;
                    },
                  ),
                ),
              ),

          ],
        );
      }),
    );
  }
}