import 'package:bu_edmrs/API/login_api.dart';
import 'package:bu_edmrs/common/styles/spacing_styles.dart';
import 'package:bu_edmrs/utils/constants/colors.dart';
import 'package:bu_edmrs/utils/constants/image_strings.dart';
import 'package:bu_edmrs/utils/constants/size.dart';
import 'package:bu_edmrs/utils/popups/popups.dart';
import 'package:bu_edmrs/utils/constants/text_strings.dart';
import 'package:bu_edmrs/utils/helpers/helper_functions.dart';
import 'package:bu_edmrs/utils/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final controller = Get.put(LoginController());
    return Scaffold(
      // key: controller.popUpkey,
      body: SingleChildScrollView(
        child: Padding(
          padding: TSpacingStyles.paddingWithAppBarHeight,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image(
                    height: 110,
                    image: AssetImage(
                        dark ? TImages.lightAppLogo : TImages.darkAppLogo),
                  ),
                  Text(
                    TTexts.loginTitle,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(
                    height: ConstSizes.sm,
                  ),
                  Text(
                    TTexts.loginSubTitle,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
              Form(
                key: controller.loginFormKey,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: ConstSizes.spaceBtwSections),
                  child: Column(
                    children: [
                      TextFormField(
                        controller: controller.username,
                        validator: (value) =>
                            TValidator.validateUsername(value),
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Iconsax.user),
                          labelText: 'Username',
                        ),
                      ),
                      const SizedBox(
                        height: ConstSizes.spaceBtwInputFields,
                      ),
                      Obx(
                        () => TextFormField(
                          controller: controller.password,
                          validator: (value) =>
                              TValidator.validatePassword(value),
                          obscureText: controller.hidePassword.value,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Iconsax.password_check),
                            labelText: TTexts.password,
                            suffixIcon: IconButton(
                              onPressed: () => controller.hidePassword.value =
                                  !controller.hidePassword.value,
                              icon: Icon(controller.hidePassword.value
                                  ? Iconsax.eye_slash
                                  : Iconsax.eye),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: ConstSizes.spaceBtwInputFields / 2,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () {
                              PopUps.showForgotPass(
                                  context: context,
                                  icon: 'success',
                                  message: 'Please Contact IT');
                            },
                            child: const Text(TTexts.forgetPassword),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: ConstSizes.spaceBtwSections,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            // Get.to(() => const BottomNav());
                            controller.usernamePasswordLogin(context);
                          },
                          child: const Text(TTexts.signIn),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
