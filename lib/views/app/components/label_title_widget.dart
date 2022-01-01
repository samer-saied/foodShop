import 'package:flutter/material.dart';
import 'package:onlinefooddeliverysystem/constant/colors.dart';

class LabelTitleWidget extends StatelessWidget {
  final String title;
  final bool seeAllEnabled;
  final void Function()? onTapSeeAll;

  const LabelTitleWidget({
    Key? key,
    required this.title,
    required this.seeAllEnabled,
    this.onTapSeeAll,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.headline1,
          ),
          const Spacer(),
          seeAllEnabled
              ? GestureDetector(
                  onTap: seeAllEnabled
                      ? onTapSeeAll
                      : () {
                          print("Disabled");
                        },
                  child: Text(
                    "see all  > ",
                    style: Theme.of(context)
                        .textTheme
                        .headline5!
                        .copyWith(color: greyColor),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
