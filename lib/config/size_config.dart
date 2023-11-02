import 'package:flutter/material.dart';

double getWidth(context, {width = 0.04}) =>
    MediaQuery.sizeOf(context).width * width;

double getHeight(context, {height = 0.04}) =>
    MediaQuery.sizeOf(context).height * height;

SizedBox spaceHeight(context, {height = 0.04}) =>
    SizedBox(height: MediaQuery.sizeOf(context).height * height);

SizedBox spaceWidth(context, {width = 0.04}) =>
    SizedBox(width: MediaQuery.sizeOf(context).width * width);
