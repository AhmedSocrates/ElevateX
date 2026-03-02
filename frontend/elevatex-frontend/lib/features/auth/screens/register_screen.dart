import 'package:elevatex/features/auth/providers/auth_provider.dart';
import 'package:elevatex/features/auth/providers/loading_provider.dart';
import 'package:elevatex/features/auth/widgets/text_input_field.dart';
import 'package:elevatex/shared/widgets/custom_primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_text_styles.dart';


class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController =  TextEditingController();
  final TextEditingController _emailController =  TextEditingController();
  final TextEditingController _passwordController =  TextEditingController();
  final TextEditingController _confirmPasswordController =  TextEditingController();

  bool isLoading = false;

  
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Text("Register"),
        centerTitle: true,
        backgroundColor: Colors.transparent,
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
                  Container(
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
                  ElevateTextField(
                    label: "Username",
                    textEditingController: _nameController, 
                    hintText: "username",
                    textInputAction: TextInputAction.next, 
                    textInputType: TextInputType.text,
                    validator: (value) {
                      if(value == null || value.isEmpty) {
                        return "Please enter your username";
                      }
                      else {
                        return null;
                      }
                    },
                  ),
        
                  ElevateTextField(
                    label: "Email",
                    textEditingController: _emailController, 
                    hintText: "example@Test.com",
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
                    hintText: "passowrd",
                    textEditingController: _passwordController, 
                    textInputAction: TextInputAction.next,
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
        
                  ElevateTextField(
                    label: "Confirm Password",
                    hintText: "confirm passowrd",
                    textEditingController: _confirmPasswordController, 
                    textInputAction: TextInputAction.done,
                    textInputType: TextInputType.text,
                    obscureText: true,
                    validator: (value) {
                      // capital letter, small letter, number, special character, and length 8
                      if(value == null || value.isEmpty) {
                        return "Please enter your password";
                      }
          
                      else if (value != _passwordController.text) {
                        return "Passwords must match";
                      }
          
                      else {
                        return null;
                      }
                    }
                  ),
        
                  Row(
                    children: [
        
                      Text("Already have an account?  ", style: AppTextStyles.bodyLg),
                      GestureDetector(
                        onTap: () {
                          context.go("/login");
                        },
                        child: Text("Log in", style: AppTextStyles.bodySm),
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
                        await ref.read(authProvider.notifier).signup(_nameController.text, _emailController.text, _passwordController.text);
                        if (!context.mounted) return;
                        context.go("/"); 
                      }
                    }, 
                  text: "Register")
                ],
              ),
            )
          ),
        ),
      ),
      
    );
  }
}