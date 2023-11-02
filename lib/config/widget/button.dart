import 'package:baitap08/config/size_config.dart';
import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  ButtonWidget({
    required this.function,
    super.key,
    this.textButton = "",
  });
  VoidCallback function;
  String textButton;
  @override
  Widget build(BuildContext context) {
    bool loading = false;
    return Material(
      color: Colors.transparent,
      child: StatefulBuilder(builder: (context, setState) {
        return InkWell(
          onTap: () async {
            if (loading) return;
            setState(() {
              loading = !loading;
            });
            await Future.delayed(const Duration(seconds: 2));
            setState(() {
              loading = !loading;
            });
            function();
          },
          child: Ink(
            child: Container(
              width: double.infinity,
              height: getHeight(context, height: 0.08),
              decoration: BoxDecoration(
                  gradient: const LinearGradient(colors: [
                    Color(0xff363ff5),
                    Color(0xff6357CC),
                  ]),
                  borderRadius: BorderRadius.circular(20)),
              child: Center(
                  child: !loading
                      ? Text(
                          textButton,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 19,
                              fontWeight: FontWeight.bold),
                        )
                      : const CircularProgressIndicator()),
            ),
          ),
        );
      }),
    );
  }
}
