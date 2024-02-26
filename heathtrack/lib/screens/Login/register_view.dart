import 'package:flutter/material.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
        centerTitle: true,
        leading: BackButton(
            onPressed: () {
              Navigator.of(context).pop();
            }
        ),
      ),
      body: const RegisterForm(),
      resizeToAvoidBottomInset: false,
      floatingActionButton:const FooterView(),
    );
  }
}
class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordCheckController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  bool _passwordVisible = false;
  bool _repeatPasswordVisible = false;
  @override
  Widget build(BuildContext context) {
    return Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width*0.8,
          // height: MediaQuery.of(context).size.height*0.9,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 16.0),
                  child: Text('Username'),
                ),
                TextField(
                  controller: userNameController,
                  keyboardType: TextInputType.name,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.account_circle),
                    hintText: 'Type your username',
                    border: UnderlineInputBorder(),
                    // labelText: "Username"
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 16.0, top: 10),
                  child: Text('Password'),
                ),
                TextField(
                  controller: passwordController,
                  obscureText: true,
                  // keyboardType: TextInputType.,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.lock),
                    suffixIcon: IconButton(
                        onPressed: (){
                          setState(() {
                            _passwordVisible = !_passwordVisible;
                          });
                        },
                        icon: Icon(
                            _passwordVisible
                                ? Icons.visibility
                                : Icons.visibility_off
                        )
                    ),
                    hintText: 'Type your password',
                    // border: OutlineInputBorder(),
                    // labelText: "Password"
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 16.0, top: 10),
                  child: Text('Repeat your password'),
                ),
                TextField(
                  controller: passwordCheckController,
                  keyboardType: TextInputType.name,
                  obscureText: true,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.lock),
                    hintText: 'Repeat your password',
                    border: const UnderlineInputBorder(),
                    suffixIcon: IconButton(
                        onPressed: (){
                          setState(() {
                            _repeatPasswordVisible = !_repeatPasswordVisible;
                          });
                        },
                        icon: Icon(
                            _repeatPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off
                        )
                    )
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 16.0, top: 10),
                  child: Text('Email'),
                ),
                TextField(
                  controller: emailController,
                  keyboardType: TextInputType.name,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.mail),
                    hintText: 'abc@gmail.com',
                    border: UnderlineInputBorder(),
                    // labelText: "Username"
                  ),
                ),
                const SizedBox(height: 20,),
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    width: MediaQuery.of(context).size.width*0.8,
                    decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Colors.lightBlueAccent, Colors.blue],
                        ),
                        borderRadius: BorderRadius.circular(20)
                    ),
                    child: TextButton(
                        onPressed: (){},
                        child: const Text(
                          'Create',
                          style: TextStyle
                            (
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                              letterSpacing: 2
                          ),
                        )
                    ),
                  ),
                ),
                // Padding(
                //   padding: const EdgeInsets.only(top: 16.0, bottom: 16),
                //   child: Row(
                //     children: [
                //       Expanded(
                //           child: Divider(
                //             thickness: 1,
                //             color: Colors.grey[400],
                //           )
                //       ),
                //       Padding(
                //         padding: const EdgeInsets.symmetric(horizontal: 8.0),
                //         child: Text(
                //           'Or sign up using',
                //           style: TextStyle(
                //               color: Colors.grey[700]
                //           ),
                //         ),
                //       ),
                //       Expanded(
                //           child: Divider(
                //             thickness: 1,
                //             color: Colors.grey[400],
                //           )
                //       ),
                //     ],
                //   ),
                // ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     TextButton(
                //       style: TextButton.styleFrom(
                //         shape:  const CircleBorder(),
                //       ),
                //       onPressed: (){},
                //       child: Image.asset(
                //           'images/googleBtn.png',
                //           height: 32
                //       ),
                //     ),
                //     TextButton(
                //       style: TextButton.styleFrom(
                //         shape:  const CircleBorder(),
                //       ),
                //       onPressed: (){},
                //       child: Image.asset(
                //           'images/facebookBtn.png',
                //           height: 32
                //       ),
                //     ),
                //   ],
                // ),
              ],
            ),
          ),
        )
    );
  }
}
class FooterView extends StatelessWidget {
  const FooterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              'Having an account ?',
              style: TextStyle(
                  fontSize: 16
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width*0.35,
            decoration: BoxDecoration(
                gradient: const LinearGradient(
                    colors: [Colors.greenAccent, Colors.cyan],
                    stops: [0.1, 0.5]
                ),
                borderRadius: BorderRadius.circular(20)
            ),
            child: TextButton(
              onPressed: (){
                // Navigator.push(
                //     context,
                //     MaterialPageRoute(builder: (context) => const LoginView())
                // );
                Navigator.of(context).pop();
              },
              child: const Text(
                'Login',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    letterSpacing: 1.5
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}


