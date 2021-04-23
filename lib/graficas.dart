import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class Graficas extends StatefulWidget {
  // Paso 1 parametros
  final List<Map<String, dynamic>> listaDeDatos;
  final bool showBarChart;
  Graficas({
    Key key,
    @required this.listaDeDatos,
    @required this.showBarChart,
  }) : super(key: key);

  @override
  _GraficasState createState() => _GraficasState();
}

class _GraficasState extends State<Graficas> {
  @override
  Widget build(BuildContext context) {
    var _colors =
        charts.MaterialPalette.getOrderedPalettes(widget.listaDeDatos.length);
    return _simpleCharts(_colors);
  }

  Widget _simpleCharts(dynamic colors) {
    // Datos x,y a pintar en una grafica
    // Lista de puntos con string label
    //
    List<charts.Series<_ChartObject, String>> _chartElements = [];

    // listado de puntos dados
    var chartData = widget.listaDeDatos
        .map(
          (item) => _ChartObject(
            xAxis: item["producto"],
            yAxis: item["cantidad"],
          ),
        )
        .toList();
    // agregar puntos a la lista de elementos de la grafica
    _chartElements.add(
      charts.Series<_ChartObject, String>(
        id: "Grafica321321",
        data: chartData,
        measureFn: (punto, index) => punto.yAxis,
        domainFn: (punto, index) => punto.xAxis,
        colorFn: (_, index) => colors[index].shadeDefault,
        labelAccessorFn: (punto, index) => "${punto.xAxis} : ${punto.yAxis}",
      ),
    );

    // pintar grafica de barras
    if (widget.showBarChart) {
      return charts.BarChart(
        _chartElements,
        animate: true,
        behaviors: [
          charts.ChartTitle("Productos"),
          charts.DatumLegend(desiredMaxRows: 2)
        ],
      );
    } else {
      return charts.PieChart(
        _chartElements,
        animate: true,
        behaviors: [
          charts.ChartTitle("Productos"),
          charts.DatumLegend(
            desiredMaxRows: 2,
            position: charts.BehaviorPosition.bottom,
          )
        ],
        defaultRenderer: charts.ArcRendererConfig(
          arcRatio: 1.0,
          arcRendererDecorators: [
            charts.ArcLabelDecorator(
              labelPosition: charts.ArcLabelPosition.auto,
            ),
          ],
        ),
      );
    }
  }
}

// Paso 2 objeto custom para los datos x,y
class _ChartObject {
  final String xAxis;
  final int yAxis;

  _ChartObject({
    @required this.xAxis,
    @required this.yAxis,
  });
}
