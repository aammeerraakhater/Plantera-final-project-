import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

Column ambair(
    double min, double max, double value, String tx1, String tx2, Color col) {
  return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
    SizedBox(
      height: 140,
      width: 140,
      child: SfRadialGauge(axes: <RadialAxis>[
        RadialAxis(
            startAngle: 270,
            endAngle: 270,
            minimum: min,
            maximum: max,
            axisLineStyle: const AxisLineStyle(
                //cornerStyle: CornerStyle.bothCurve,

                thickness: 0.15,
                thicknessUnit: GaugeSizeUnit.factor),
            showTicks: false,
            showLabels: false,
            pointers: <GaugePointer>[
              RangePointer(
                  cornerStyle: CornerStyle.endCurve,
                  color: col,
                  value: value,
                  enableDragging: true,
                  width: 0.15,
                  sizeUnit: GaugeSizeUnit.factor),
            ],
            annotations: <GaugeAnnotation>[
              GaugeAnnotation(
                widget: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15.0),
                        child: Text(
                          tx1.tr,
                          style: new TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15.0),
                        ),
                      ),
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15.0),
                        child: Text(
                          value.toString(),
                          style: new TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15.0),
                        ),
                      ),
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15.0),
                        child: Text(
                          tx2,
                          style: new TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15.0),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ])
      ]),
    )
  ]);
}
