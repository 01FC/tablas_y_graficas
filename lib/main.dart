import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graficas_tablas/graficas.dart';
import 'package:graficas_tablas/tablas.dart';

import 'bloc/home_bloc.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: BlocProvider(
        create: (context) => HomeBloc()..add(ShowDataTableEvent()),
        child: HomePage(),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Visualizacion de datos"),
        actions: [
          IconButton(
            tooltip: "Tabla",
            icon: Icon(Icons.table_chart),
            onPressed: () {
              BlocProvider.of<HomeBloc>(context).add(ShowDataTableEvent());
            },
          ),
          IconButton(
            tooltip: "Barras",
            icon: Icon(Icons.insert_chart),
            onPressed: () {
              BlocProvider.of<HomeBloc>(context).add(
                ShowChartsEvent(showBarChart: true),
              );
            },
          ),
          IconButton(
            tooltip: "Pay",
            icon: Icon(Icons.pie_chart),
            onPressed: () {
              BlocProvider.of<HomeBloc>(context).add(
                ShowChartsEvent(showBarChart: false),
              );
            },
          ),
        ],
      ),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state is DataTableState) {
            return Tablas(listaDeDatos: state.listaDatos);
          } else if (state is BarChartsState) {
            return Graficas(
              listaDeDatos: state.listaDatos,
              showBarChart: true,
            );
          } else if (state is PieChartsState) {
            return Graficas(
              listaDeDatos: state.listaDatos,
              showBarChart: false,
            );
          }
          return Container();
        },
      ),
    );
  }
}
