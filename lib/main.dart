import 'package:dev_todo/models/task_Data.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dev_todo/screens/task_screen.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:firebase_core/firebase_core.dart';
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(ToDo());
}

class ToDo extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
        builder: (context, snapshot) {
          if (snapshot.hasError){
            return Error();
          } else if (snapshot.hasData){
            return ChangeNotifierProvider(
              create: (context) => TaskData(),
              child: MaterialApp(
                theme: ThemeData.light().copyWith(
                    bottomSheetTheme: BottomSheetThemeData(backgroundColor: Colors.black12),
                    textTheme: TextTheme(bodyText2: TextStyle(color: Colors.black))
                ),
                debugShowCheckedModeBanner: false,
                home: SplashScreen(),
              ),
            );
          } else {
            return Loading();
          }
        }

    );
  }
}


class SplashScreen extends StatefulWidget{

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin{
  late AnimationController controller;
  late Animation animation;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3),
    );
    controller.forward();
    controller.addListener(() {
      setState(() {});
    });
    animation = CurvedAnimation(
      parent: controller,
      curve: Curves.bounceOut,
    );
//    Timer(Duration(seconds: 5), () => Navigator.push(context, MaterialPageRoute(builder: (context) => TaskScreen())) );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Future<User?> _signIn() async{
      final GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();
        GoogleSignInAuthentication gSA = await googleSignInAccount
            !.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: gSA.accessToken,
          idToken: gSA.idToken,
        );
        final UserCredential authResult = await _auth.signInWithCredential(
            credential);
        User? user = authResult.user;
        return user;

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Image.asset(
              "assets/logo.png",
            height: animation.value*200,
            width: 200,
          ),
          Text(
            "TodoAy",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              letterSpacing: 2.0,
              fontSize: 70.0,
            ),
          ),
          Container(width: 100,child: Divider(thickness: 2.0,)),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 50.0),
            child: Material(
              elevation: 8.0,
              color: Color(0xFF7C83FD),
              borderRadius: BorderRadius.circular(12.0),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0),
                child: MaterialButton(
                  onPressed: () =>
                    _signIn()
                        .then((User? user) => Navigator.push(context, MaterialPageRoute(builder:  (context) => TaskScreen(user: user,)))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      FaIcon(FontAwesomeIcons.google,color: Colors.white,),
                      SizedBox(width: 20,),
                      Text(
                          "Sign In with Google",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                          fontWeight: FontWeight.w700
                        ),
                      ),
                    ],
                  ),

                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class Error extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: Column(
            children: [
              Icon(Icons.error),
              Text("Oops, SomethingWent Wrong")
            ],
          ),
        ),
      ),
    );
  }
}
class Loading extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: Column(
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 10,),
              Text("Loading.."),
            ],
          ),
        ),
      ),
    );
  }
}