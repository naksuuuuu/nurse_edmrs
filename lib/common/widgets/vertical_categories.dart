
import 'package:bu_edmrs/utils/constants/colors.dart';
import 'package:bu_edmrs/utils/constants/size.dart';
import 'package:bu_edmrs/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class VerticalCategories extends StatelessWidget {
  const VerticalCategories({
    super.key, required this.image, required this.title, required this.textColor, this.backgroundColor, this.onTap,
  });

  final String image, title;
  final Color textColor;
  final Color? backgroundColor;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(right: ConstSizes.spaceBtwItems),
        child: Column(
          children: [
            Container(
              width: 56,
              height: 56,
              padding:
                  const EdgeInsets.all(ConstSizes.sm),
              decoration: BoxDecoration(
                  color: backgroundColor ?? (THelperFunctions.isDarkMode(context) ? ConstColors.black : ConstColors.white),
                  borderRadius:
                      BorderRadius.circular(100)),
              child: Center(
                child: Image(
                    image: AssetImage(image),
                    fit: BoxFit.cover,
                    color: THelperFunctions.isDarkMode(context) ? ConstColors.light : ConstColors.dark),
              ),
            ),
            const SizedBox(
              height: ConstSizes.spaceBtwItems / 2,
            ),
            SizedBox(
              width: 55,
              child: Text(
                title,
                style: Theme.of(context)
                    .textTheme
                    .labelMedium!
                    .apply(color: textColor),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}