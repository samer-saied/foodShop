import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:onlinefooddeliverysystem/constant/colors.dart';

// ignore: must_be_immutable
class TitleSliderWidget extends StatelessWidget {
  final String titleTxt;
  Widget prefixIcon;
  final bool backAvaiable;
  TitleSliderWidget({
    Key? key,
    required this.titleTxt,
    required this.prefixIcon,
    required this.backAvaiable,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: MediaQuery.of(context).padding.top,
        left: 0,
        child: Container(
          // height: 70,
          //width: MediaQuery.of(context).size.width * .3,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                backAvaiable
                    ? InkWell(
                        onTap: () => Navigator.pop(context),
                        child: Icon(
                          CupertinoIcons.back,
                          color: whiteColor,
                        ),
                      )
                    : SizedBox(),
                backAvaiable
                    ? SizedBox(
                        width: 15,
                      )
                    : SizedBox(),
                prefixIcon,
                SizedBox(
                  width: 5,
                ),
                Text(titleTxt,
                    style: Theme.of(context)
                        .textTheme
                        .headline2!
                        .copyWith(color: whiteColor)),
              ],
            ),
          ),
          decoration: BoxDecoration(
              color: mainColor,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(25),
                bottomRight: Radius.circular(25),
              )),
        ));
  }
}
