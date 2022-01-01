import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:onlinefooddeliverysystem/constant/colors.dart';
import 'package:onlinefooddeliverysystem/views/user/register_screen.dart';

import 'components/login_register_comp.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _userController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          ////////////// Screen Decoration ////////////////////////////////
          Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: ColorFiltered(
                colorFilter: ColorFilter.mode(mainColor, BlendMode.modulate),
                child: Image(
                  image: AssetImage('assets/images/brand/Shape_bg.png'),
                  fit: BoxFit.contain,
                ),
              )),

          ////////////// Screen Content ////////////////////////////////
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            alignment: AlignmentDirectional.center,
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ////////////////////////////////Brand LOGO & NAME /////////////////////////////////////////
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            CachedNetworkImage(
                              imageUrl:
                                  'https://freeiconshop.com/wp-content/uploads/edd/hotdog-outline-filled.png',
                              width: MediaQuery.of(context).size.width * .20,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Food Shop",
                              style: Theme.of(context)
                                  .textTheme
                                  .headline1!
                                  .copyWith(color: mainColor),
                            ),
                          ],
                        )
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    //////////////////////////////// LOGIN /////////////////////////////////////////
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 8),
                        child: Text('Login',
                            style: Theme.of(context)
                                .textTheme
                                .headline2!
                                .copyWith(color: whiteColor)),
                      ),
                      decoration: BoxDecoration(
                          color: mainColor,
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(25),
                            bottomRight: Radius.circular(25),
                          )),
                    ),
                    //////////////////////////////// Form /////////////////////////////////////////
                    Form(
                        key: _formKey,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, top: 25),
                          child: Column(
                            children: [
                              myTextFormField(
                                icon: CupertinoIcons.person_alt,
                                textFormController: _userController,
                                labelText: 'Enter your username',
                                validatorFunc: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter some text';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              myTextFormField(
                                icon: CupertinoIcons.lock_fill,
                                textFormController: _passwordController,
                                labelText: 'Enter your password',
                                validatorFunc: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter some text';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              CupertinoButton(
                                  child: Text(
                                    "logIn",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline3!
                                        .copyWith(
                                            color: whiteColor,
                                            fontWeight: FontWeight.normal),
                                  ),
                                  color: mainColor,
                                  onPressed: () {}),
                              SizedBox(
                                height: 15,
                              ),
                              InkWell(
                                onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => RegisterScreen(),
                                  ),
                                ),
                                child: Text(
                                  "Don't have account, Register now",
                                  style: TextStyle(color: mainColor),
                                ),
                              )
                            ],
                          ),
                        )),
                    SizedBox(
                      height: 50,
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
