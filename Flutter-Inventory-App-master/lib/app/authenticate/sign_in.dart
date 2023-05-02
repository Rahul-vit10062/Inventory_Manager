import 'package:Stock_Manager/services/auth.dart';
import 'package:Stock_Manager/utils/loading.dart';
import 'package:Stock_Manager/utils/window.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String error = '';
  bool loading = false;

  TextEditingController userEmailController = TextEditingController();
  TextEditingController userPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.titleLarge;
    return loading
        ? Loading()
        : Scaffold(
            appBar: AppBar(
              elevation: 0.0,
              title: Text('Sign in'),
              actions: <Widget>[
                TextButton.icon(
                  icon: Icon(Icons.person),
                  label: Text('Register'),
                  onPressed: () => widget.toggleView(),
                ),
              ],
            ),
            body: Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
              child: Form(
                key: _formKey,
                child: ListView(
                  children: <Widget>[
                    SizedBox(height: 20.0),

                    // No of items
                    WindowUtils.genTextField(
                      labelText: "Email",
                      hintText: "example@gmail.com",
                      textStyle: textStyle,
                      controller: this.userEmailController,
                      onChanged: (val) {
                        //setState(() => this.userEmailController.text = val);
                        this.userEmailController.value = this
                            .userEmailController
                            .value
                            .copyWith(
                              text: val,
                              selection:
                                  TextSelection.collapsed(offset: val.length),
                            );
                      },
                    ),

                    // No of items
                    WindowUtils.genTextField(
                      labelText: "Password",
                      textStyle: textStyle,
                      controller: this.userPasswordController,
                      obscureText: true,
                      validator: (val, labelText) => val.length < 6
                          ? 'Enter a $labelText 6+ chars long'
                          : null,
                      onChanged: (val) {
                        //setState(() => this.userPasswordController.text = val);
                        this.userPasswordController.value = this
                            .userEmailController
                            .value
                            .copyWith(
                              text: val,
                              selection:
                                  TextSelection.collapsed(offset: val.length),
                            );
                      },
                    ),

                    SizedBox(height: 20.0),
                    MaterialButton(
                        color: Theme.of(context).colorScheme.secondary,
                        child: Text(
                          'Sign In',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            setState(() => loading = true);
                            String email = this.userEmailController.text;
                            String password = this.userPasswordController.text;
                            dynamic result = await _auth
                                .signInWithEmailAndPassword(email, password);
                            if (result == null) {
                              setState(() {
                                loading = false;
                                error =
                                    'Could not sign in with those credentials';
                              });
                            }
                          }
                        }),
                    SizedBox(height: 12.0),
                    Text(
                      error,
                      style: TextStyle(color: Colors.red, fontSize: 14.0),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
