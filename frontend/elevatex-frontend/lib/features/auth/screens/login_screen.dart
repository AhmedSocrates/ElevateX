import 'package:elevatex/core/theme/app_text_styles.dart';
import 'package:elevatex/features/auth/providers/auth_provider.dart';
import 'package:elevatex/features/auth/providers/loading_provider.dart';
import 'package:elevatex/features/auth/widgets/text_input_field.dart';
import 'package:elevatex/shared/widgets/custom_primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';


class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController =  TextEditingController();
  final TextEditingController _passwordController=  TextEditingController();


  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
        backgroundColor: Colors.transparent,
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsetsGeometry.only(left: 20, right: 20),
        child: Center(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Form(
              key: _formKey,
              child: Column(
              
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsetsGeometry.symmetric(vertical: 5),
                    child: Container(
                      height: 100,
                      width: 100,
                      
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 0, 0, 0),
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.blue, width: 2.0)
                      ),
                      child: Center(
                        child: Text("ElevateX Icon"),
                      ),
                      
                    ),
                  ),
                  ElevateTextField(
                    label: "Email",
                    hintText: "example@test.com",
                    textEditingController: _emailController, 
                    textInputAction: TextInputAction.next, 
                    textInputType: TextInputType.emailAddress,
                    validator: (value) {
                      final RegExp emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                      if(value == null || value.isEmpty) {
                        return "Please enter your email address";
                      }
              
                      else if (!emailRegex.hasMatch(value)) {
                        return "Please enter a valid email address";
                      }
              
                      else {
                        return null;
                      }
                    },
                  ),
            
                  ElevateTextField(
                    label: "Password",
                    hintText: "Passowrd1@12",
                    textEditingController: _passwordController, 
                    textInputAction: TextInputAction.done,
                    textInputType: TextInputType.text,
                    obscureText: true,
                    validator: (value) {
                      // capital letter, small letter, number, special character, and length 8
                      final RegExp passwordRegex = RegExp(r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$');
                      if(value == null || value.isEmpty) {
                        return "Please enter your password";
                      }
              
                      else if (!passwordRegex.hasMatch(value)) {
                        return "Please enter a valid passowrd";
                      }
              
                      else {
                        return null;
                      }
                    }
                  ),
                  
                  Row(
                    children: [
            
                      Text("Don't have an account?  ", style: AppTextStyles.bodyLg),
                      GestureDetector(
                        onTap: () {
                          context.go("/register");
                        },
                        child: Text("Register Now", style: AppTextStyles.bodySm),
                      ),
                    ],
                  ),
            
                  Padding(
                    padding: EdgeInsetsGeometry.symmetric(vertical: 5),
                    child: ref.watch(loadingProvider)? CircularProgressIndicator(): null
                  ),
              
                  CustomPrimaryButton(
                    onPressed: () async {
                      if(_formKey.currentState!.validate()) {
                        // enhance the logic
                        ref.read(loadingProvider.notifier).setLoading(true);
                        // **************************************************
                        // auth handling
                        // **************************************************
                        await ref.read(authProvider.notifier).login(_emailController.text, _passwordController.text);
                        if (!context.mounted) return;
                        context.go("/"); 
                      }
                    }, 
                  text: "Login"
                  )
                ],
              ),
            ),
          )
        ),
      ),
      
    );
  }
}