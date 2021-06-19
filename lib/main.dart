import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:multi_runapp/bloc/home_bloc.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';
import 'app_state.dart';

void main() {
  runApp(MultiProvider(
    providers: [ChangeNotifierProvider(create: (_) => AppState())],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: LoadingResource());
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  HomeBLoC homeBLoC = HomeBLoC();

  @override
  Widget build(BuildContext context) {
    print('rebuild');
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Container(
              child: buildTextField().pSymmetric(h: 20,v: 20),
            ).h(100),
          ),
          StreamBuilder(
            initialData: [],
            stream: homeBLoC.channelStrList,
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              return SliverList(
                delegate: SliverChildListDelegate(List.generate(snapshot.data.length, (index){
                 String title = snapshot.data[index];
                  return ListTile(
                    title: title.text.make(),
                  );
                })),
              );
            },)
        ],
      ),
    );
  }

  TextField buildTextField() {
    return TextField(
              onSubmitted: (val) {
                homeBLoC.addValToChannel(val);
              },
            );
  }
}

class LoadingResource extends StatefulWidget {
  const LoadingResource({Key? key}) : super(key: key);

  @override
  _LoadingResourceState createState() => _LoadingResourceState();
}

class _LoadingResourceState extends State<LoadingResource> {
  @override
  Widget build(BuildContext context) {
    final token = context.watch<AppState>().token;
    return token == null ? Login() : Home();
  }
}

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TextButton(
        onPressed: () {
          context.read<AppState>().setToken('mother lywat');
        },
        child: "Login now".text.make(),
      ).centered(),
    );
  }
}
