import 'package:baitap08/config/size_config.dart';
import 'package:flutter/material.dart';

class NotificationWidget extends StatelessWidget {
  const NotificationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: getHeight(context, height: 0.2),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 100,
              height: 100,
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                color: Colors.amber,
                borderRadius: BorderRadius.circular(100),
              ),
            ),
            spaceWidth(context),
            const Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Title",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                      'Reiciendis earum ea non doloribus exercitationem omnis. Commodi id inventore nostrum eos aut. Voluptatibus et et eos laudantium et.'),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
