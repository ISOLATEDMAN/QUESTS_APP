import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:jdds/home.dart";

class Auths extends StatefulWidget {
  const Auths({Key? key}) : super(key: key);

  @override
  State<Auths> createState() => _AuthsState();
}

class _AuthsState extends State<Auths> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final _formKey = GlobalKey<FormState>();

  TextEditingController _email = TextEditingController();
  TextEditingController _pass = TextEditingController();
  TextEditingController _username = TextEditingController();
  TextEditingController _conform = TextEditingController();
  bool isLoading = false;

  createUserWithEmailAndPassword() async{
    try {
       await FirebaseAuth.instance.createUserWithEmailAndPassword(
    email: _email.text,
    password: _pass.text,
  );
} on FirebaseAuthException catch (e) {
  if (e.code == 'weak-password') {
    print('The password provided is too weak.');
  } else if (e.code == 'email-already-in-use') {
    print('The account already exists for that email.');
  }
} catch (e) {
  print(e);
}
  }

  Future<void> signInWithEmailAndPassword() async {
  try {
    setState(() {
      isLoading = true;
    });
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: _email.text,
      password: _pass.text,
    );
    Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>todo()));

        setState(() {
      isLoading = false;
    });
  } on FirebaseAuthException catch (e) {
        setState(() {
      isLoading = false;
    });
    if (e.code == 'user-not-found') {
      _showSnackBar("Wrong email by the user");
    } else if (e.code == 'wrong-password') {
      _showSnackBar("Wrong password by the user");
    }
  }
}

void _showSnackBar(String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(message)),
  );
}


  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(0, 0, 0, 0),
      body: DefaultTabController(
        length: 2,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 50,),
            Image.asset("assets/TODO-3.png", width: 150, height: 200,),
            SizedBox(height: 50),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TabBar(
                controller: _tabController,
                tabs: [
                  Tab(
                    icon: Icon(
                      Icons.login,
                      size: 35.0,
                      color: Colors.white,
                    ),
                    text: "LOGIN",
                  ),
                  Tab(
                    icon: Icon(
                      Icons.person_add,
                      size: 35.0,
                      color: Colors.white,
                    ),
                    text: "SIGN UP",
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(20),
                      child: Form(
                        key: _formKey,
                        child: SingleChildScrollView(
                          child: Column(
                            children: <Widget>[
                              TextFormField(
                                controller: _email,
                                validator: (text) {
                                  if (text == null || text.isEmpty) {
                                    return "Email is empty";
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  hintText: "Email",
                                  hintStyle: TextStyle(color: Colors.white, fontSize: 20),
                                ),
                                style: TextStyle(color: Colors.white),
                              ),
                              SizedBox(height: 20,),
                              TextFormField(
                                controller: _pass,
                                validator: (text) {
                                  if (text == null || text.isEmpty) {
                                    return "Password is empty";
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  hintText: "Password",
                                  hintStyle: TextStyle(color: Colors.white, fontSize: 20),
                                ),
                                obscureText: true,
                                style: TextStyle(color: Colors.white),
                              ),
                              SizedBox(height: 30,),
                              ElevatedButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    
                                    signInWithEmailAndPassword();
                                  }
                                },
                                child:Center(child: isLoading?CircularProgressIndicator(color: Colors.white,): Text("SIGN IN")),
                                style: getCustomButtonStyle(),
                              ),
                              SizedBox(height: 10,),
                              ElevatedButton(
                                onPressed: () {},
                                child: Text("SIGN IN WITH GOOGLE"),
                                style: getCustomButtonStyle(),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Center(
                      child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Form(
                          key: _formKey,
                          child: SingleChildScrollView(
                            child: Column(
                              children: <Widget>[
                                TextFormField(
                                  controller: _username,
                                  validator: (text) {
                                    if (text == null || text.isEmpty) {
                                      return "username is empty";
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    hintText: "User Name",
                                    hintStyle: TextStyle(color: Colors.white, fontSize: 20),
                                  ),
                                  style: TextStyle(color: Colors.white),
                                ),
                                SizedBox(height: 20,),
                                TextFormField(
                                  controller: _email,
                                  validator: (text) {
                                    if (text == null || text.isEmpty) {
                                      return "Email is empty";
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    hintText: "Email",
                                    hintStyle: TextStyle(color: Colors.white, fontSize: 20),
                                  ),
                                  
                                  style: TextStyle(color: Colors.white),
                                ),
                                SizedBox(height: 20,),
                                TextFormField(
                                  controller: _pass,
                                  validator: (text) {
                                    if (text == null || text.isEmpty) {
                                      return "Password is empty";
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    
                                    hintText: "Password",
                                    
                                    hintStyle: TextStyle(color: Colors.white, fontSize: 20),
                                  ),
                                  obscureText: true,
                                  style: TextStyle(color: Colors.white),
                                ),
                                SizedBox(height: 20,),
                                TextFormField(
                                  controller: _conform,
                                  validator: (text) {
                                    if (text == null || text.isEmpty) {
                                      return "pass is empty";
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    hintText: "Conform Password",
                                    hintStyle: TextStyle(color: Colors.white, fontSize: 20),
                                  ),
                                  obscureText: true,
                                  style: TextStyle(color: Colors.white),
                                ),
                                SizedBox(height: 20,),
                                ElevatedButton(
                                  onPressed: () {
    if (_formKey.currentState!.validate()) {
      if (_pass.text == _conform.text) {
        createUserWithEmailAndPassword();
      } else {
        _showSnackBar("Passwords do not match");
      }
    }
  },
                                  child: Text("SIGN UP"),
                                  style: getCustomButtonStyle(),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  ButtonStyle getCustomButtonStyle() {
    return ButtonStyle(
      fixedSize: MaterialStateProperty.all<Size>(Size(270, 40)),
      elevation: MaterialStateProperty.all<double>(100),
      backgroundColor: MaterialStateProperty.all<Color>(Color.fromARGB(255, 255, 255, 255)),
    );
  }
}
