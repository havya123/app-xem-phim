import 'package:baitap08/provider/login_provider.dart';
import 'package:baitap08/provider/user_detail_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ImageSelected extends StatelessWidget {
  const ImageSelected({super.key});

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      heightFactor: 0.3,
      child: Column(
        children: [
          TextButton(
            onPressed: () async {
              await context
                  .read<UserDetailProvider>()
                  .pickImageFromGallery()
                  .then((value) async {
                await context
                    .read<UserDetailProvider>()
                    .saveImage(context.read<LoginProvider>().userPhone)
                    .then((value) => Navigator.pop(context));
              });
            },
            child: const Text('Lấy ảnh từ thư viện'),
          ),
          TextButton(
            onPressed: () async {
              await context
                  .read<UserDetailProvider>()
                  .pickImageFromCamera()
                  .then((value) async {
                await context
                    .read<UserDetailProvider>()
                    .saveImage(context.read<LoginProvider>().userPhone)
                    .then((value) => Navigator.pop(context));
              });
            },
            child: const Text('Lấy ảnh từ camera'),
          ),
        ],
      ),
    );
  }
}
