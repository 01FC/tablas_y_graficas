import 'package:flutter/material.dart';

class Tablas extends StatefulWidget {
  // Paso 1 parametro
  final List<Map<String, dynamic>> listaDeDatos;
  Tablas({Key key, @required this.listaDeDatos}) : super(key: key);

  @override
  _TablasState createState() => _TablasState();
}

class _TablasState extends State<Tablas> {
  // Paso 2 lista de filas y columnas
  List<DataColumn> _columnas = [];
  List<DataRow> _renglones = [];

  // paso 4 inicializar las listas de filas y columnas
  @override
  void initState() {
    _fillColumns();
    _fillRows();
    super.initState();
  }

  // Paso 5 pintar la tabla
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columns: _columnas,
        rows: _renglones,
      ),
    );
  }

  // Paso 3 obtener datos y llenar filas y columna

  void _fillColumns() {
    _columnas = widget.listaDeDatos[0].entries
        .map(
          (item) => DataColumn(
            label: Text("${item.key}"),
          ),
        )
        .toList();
  }

  void _fillRows() {
    for (var item in widget.listaDeDatos) {
      List<DataCell> celdas = item.entries
          .map(
            (entry) => DataCell(
              entry.key == "color"
                  ? Container(
                      height: 8,
                      width: 8,
                      color: Color(
                        int.parse("${entry.value}"),
                      ),
                    )
                  : Text("${entry.value}"),
            ),
          )
          .toList();
      _renglones.add(DataRow(cells: celdas));
    }
  }
}
