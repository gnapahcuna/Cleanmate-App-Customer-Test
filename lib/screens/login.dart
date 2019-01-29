import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  @override
  LoginPageState createState() => new LoginPageState();
}
class LoginPageState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: new BoxDecoration(
          image: new DecorationImage(
            image: new AssetImage("assets/images/bg.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.all(15.0),
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(10.0),
                child: Column(
                  children: <Widget>[
                    Hero(
                      tag: 'hero',
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 20.0),
                        child: Image.asset('assets/images/logo.png'),
                      ),
                    ),
                    TextField(
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.person, color: Colors.grey,),
                        labelText: "Username or Email",
                      ),
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    TextField(
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.lock, color: Colors.grey),
                        labelText: "Password",
                      ),

                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    Material(
                      borderRadius: BorderRadius.circular(30.0),
                      //elevation: 5.0,
                      child: MaterialButton(
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.of(context).pushNamed('/HomeScreen');
                        },
                        minWidth: 150.0,
                        height: 50.0,
                        color: Color(0xFF179CDF),
                        child: Text(
                          "LOGIN",
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 25.0,
              ),
              Row(
                children: <Widget>[
                  Expanded(child: Text("Don't Have a Account?",
                      style: TextStyle(
                        color: Colors.grey,
                      )
                  )
                  ),
                  Text("Sign Up",
                      style: TextStyle(
                        color: Colors.grey,
                      )),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}