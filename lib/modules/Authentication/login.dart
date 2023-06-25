import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meshawery/modules/Authentication/cubit/cubit.dart';
import 'package:meshawery/modules/Authentication/cubit/states.dart';
import 'package:meshawery/shared/Components.dart';
import 'package:meshawery/shared/Style.dart';


class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AuthenticationCubit(),
      child: BlocConsumer<AuthenticationCubit, AuthenticationStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Image.asset(
                      "assets/images/signup.png",
                      height: 370,
                    ),
                  ),
                ),
                Form(
                  key: AuthenticationCubit.get(context).formKeyLogin,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Email can not empty';
                            }
                            return null;
                          },
                          controller:
                          AuthenticationCubit.get(context).emailLogin,
                          decoration: InputDecoration(
                            labelText: 'Email',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(17.0)),
                            prefixIcon: const Icon(
                              Icons.email,
                              color: backgroundColor2,
                            ),
                          ),
                          keyboardType: TextInputType.emailAddress,
                          onFieldSubmitted: (value) {},
                          onChanged: (value) {},
                        ),
                      ),
                      SizedBox(
                        height: sizeFromHeight(context, 80),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(

                          child: defaultFormField(
                            emailAddress:
                            AuthenticationCubit.get(context).passwordLogin,
                            text: 'Password',
                            returnSyntex: 'password can not empty',
                            prefixicon: const Icon(Icons.lock,
                                color: backgroundColor2),
                            suffix: AuthenticationCubit.get(context).suffix,
                            keyboardtype: TextInputType.visiblePassword,
                            suffixPressed: () {
                              AuthenticationCubit.get(context)
                                  .changePasswordVisibility();
                            },
                            ispassword:
                            AuthenticationCubit.get(context).isPassword,
                          ),
                        ),
                      ),

                    ],
                  ),
                ),
                SizedBox(
                  height: sizeFromHeight(context, 10),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: backgroundColor2,
                    padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                  ),
                  onPressed: ()
                  {
                    if (AuthenticationCubit.get(context).formKeyLogin.currentState!.validate()) {
                      AuthenticationCubit.get(context).userLogin(
                        email: AuthenticationCubit.get(context).emailLogin.text.trim(),
                        password: AuthenticationCubit.get(context).passwordLogin.text.trim(),
                         context: context,
                      );
                    }
                    else{
                      showToast(text: 'Try again,and enter right data',state: ToastStates.ERROR);
                    }

                   // formValidation();

                  },
                  child: const Text(
                    "Login",
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold,fontSize: 22),
                  ),
                ),
                const SizedBox(height: 30,),
              ],
            ),
          );
        },
      ),
    );

  }
}

