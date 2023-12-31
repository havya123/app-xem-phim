import 'package:baitap08/config/size_config.dart';
import 'package:baitap08/config/widget/button.dart';
import 'package:baitap08/config/widget/button_list_title.dart';
import 'package:baitap08/config/widget/dialog.dart';
import 'package:baitap08/model/user.dart';
import 'package:baitap08/provider/login_provider.dart';
import 'package:baitap08/provider/user_detail_provider.dart';
import 'package:baitap08/route/routes.dart';
import 'package:baitap08/screen/profile/widget/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';

class DetailProfileScreen extends StatefulWidget {
  DetailProfileScreen({this.controller, super.key});

  PersistentTabController? controller;

  @override
  State<DetailProfileScreen> createState() => _DetailProfileScreenState();
}

class _DetailProfileScreenState extends State<DetailProfileScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController mailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<UserModel?>(builder: (context, userDetail, child) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                spaceHeight(context, height: 0.1),
                SizedBox(
                  width: 120,
                  height: 120,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        height: 100,
                        width: 100,
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100)),
                        child: FadeInImage.memoryNetwork(
                          fit: BoxFit.cover,
                          placeholder: kTransparentImage,
                          image: userDetail!.avatar,
                          imageErrorBuilder: (context, error, stackTrace) =>
                              const Image(
                            fit: BoxFit.cover,
                            image: AssetImage("assets/img/detail/avatar.png"),
                          ),
                        ),
                      ),
                      StreamBuilder(
                          stream: context
                              .read<UserDetailProvider>()
                              .loadingStatus
                              .stream,
                          initialData: 0,
                          builder: (context, snapshot) {
                            if (snapshot.data == 0 || snapshot.data == 1) {
                              return Container(
                                color: Colors.transparent,
                              );
                            }
                            return LinearProgressIndicator(
                              color: Colors.blue,
                              value: snapshot.data,
                            );
                          }),
                      Positioned(
                        right: 0,
                        bottom: 0,
                        child: IconButton(
                            onPressed: () {
                              showModalBottomSheet(
                                  context: context,
                                  builder: (context) {
                                    return const ImageSelected();
                                  });
                            },
                            icon: const Icon(
                              FontAwesomeIcons.camera,
                              color: Colors.white,
                            )),
                      ),
                    ],
                  ),
                ),
                spaceHeight(context),
                ButtonListTile(
                  title: userDetail.name,
                  icon: FontAwesomeIcons.userLarge,
                  iconbutton: FontAwesomeIcons.penToSquare,
                  onPressIcon: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return DialogWidget(
                          controller: nameController,
                          function: () async {
                            await context.read<UserDetailProvider>().updateName(
                                nameController.text,
                                context.read<LoginProvider>().userPhone);
                            Navigator.pop(context);
                            nameController.clear();
                          },
                          textMg: 'Address',
                        );
                      },
                    );
                  },
                ),
                ButtonListTile(
                  title: userDetail.phone.toString(),
                  icon: FontAwesomeIcons.phone,
                  iconbutton: FontAwesomeIcons.plus,
                  onPressIcon: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return DialogWidget(
                          controller: phoneController,
                          function: () async {
                            await context
                                .read<UserDetailProvider>()
                                .updatePhone(phoneController.text,
                                    context.read<LoginProvider>().userPhone);
                            Navigator.pop(context);
                            phoneController.clear();
                          },
                          textMg: 'Address',
                        );
                      },
                    );
                  },
                ),
                ButtonListTile(
                  title: userDetail.email,
                  icon: FontAwesomeIcons.envelope,
                  iconbutton: FontAwesomeIcons.penToSquare,
                  onPressIcon: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return DialogWidget(
                          controller: mailController,
                          function: () async {
                            await context
                                .read<UserDetailProvider>()
                                .updateEmail(mailController.text,
                                    context.read<LoginProvider>().userPhone);
                            Navigator.pop(context);
                            mailController.clear();
                          },
                          textMg: 'Address',
                        );
                      },
                    );
                  },
                ),
                ButtonListTile(
                  title: 'Nam',
                  icon: FontAwesomeIcons.genderless,
                  iconbutton: FontAwesomeIcons.penToSquare,
                  onPressIcon: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return DialogWidget(
                          controller: addressController,
                          function: () async {
                            await context
                                .read<UserDetailProvider>()
                                .updateAddress(addressController.text,
                                    context.read<LoginProvider>().userPhone);
                            Navigator.pop(context);
                            addressController.clear();
                          },
                          textMg: 'Address',
                        );
                      },
                    );
                  },
                ),
                ButtonListTile(
                  title: userDetail.address ?? "",
                  icon: FontAwesomeIcons.mapLocation,
                  iconbutton: FontAwesomeIcons.penToSquare,
                  onPressIcon: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return DialogWidget(
                          controller: addressController,
                          function: () async {
                            await context
                                .read<UserDetailProvider>()
                                .updateAddress(addressController.text,
                                    context.read<LoginProvider>().userPhone);
                            Navigator.pop(context);
                            addressController.clear();
                          },
                          textMg: 'Address',
                        );
                      },
                    );
                  },
                ),
                const Divider(color: Colors.black87),
                spaceHeight(context),
                ButtonWidget(
                  function: () async {
                    await context
                        .read<LoginProvider>()
                        .logOut()
                        .then((value) => widget.controller!.jumpToTab(0));
                  },
                  textButton: "Đăng xuất",
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
