import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icare4u_ui/medicaments/bloc/medicaments_bloc.dart';
import 'package:icare4u_ui/models/models.dart';
import 'package:icare4u_ui/patient/bloc/patient_details_bloc.dart';
import 'package:icare4u_ui/patient/patient_details_screen.dart';
import 'package:icare4u_ui/repositories/repositories.dart';
import 'package:icare4u_ui/service_locator.dart';

class PatientRow extends StatefulWidget {
  final Patient patient;

  PatientRow(this.patient);

  @override
  _PatientRowState createState() => _PatientRowState();
}

class _PatientRowState extends State<PatientRow> {
  @override
  Widget build(BuildContext context) {
    final patientThumbnail = new Container(
      margin: new EdgeInsets.symmetric(vertical: 16.0),
      alignment: FractionalOffset.centerLeft,
      child: new Image(
        image: new AssetImage('assets/img/icon-png-person-5.png'),
        height: 92.0,
        width: 92.0,
      ),
    );

    final baseTextStyle = const TextStyle(fontFamily: 'Poppins');
    final regularTextStyle = baseTextStyle.copyWith(
        color: const Color(0xffb6b2df),
        fontSize: 11.0,
        fontWeight: FontWeight.w400);
    final subHeaderTextStyle = regularTextStyle.copyWith(fontSize: 12.0);
    final headerTextStyle = baseTextStyle.copyWith(
        color: Colors.white, fontSize: 18.0, fontWeight: FontWeight.w600);

    Widget _patientValue({String value, String image}) {
      return new Row(children: <Widget>[
        Image.asset(
          image,
          color: const Color(0xffb6b2df),
          height: 18.0,
        ),
        new Container(width: 8.0),
        new Text(value, style: regularTextStyle),
      ]);
    }

    final patientCardContent = new Container(
      margin: new EdgeInsets.fromLTRB(60.0, 16.0, 16.0, 16.0),
      constraints: new BoxConstraints.expand(),
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Container(height: 4.0),
          new Text(widget.patient.name, style: headerTextStyle),
          new Container(height: 10.0),
          new Text(widget.patient.patientId, style: subHeaderTextStyle),
          new Container(
              margin: new EdgeInsets.symmetric(vertical: 8.0),
              height: 2.0,
              width: 18.0,
              color: new Color(0xff00c6ff)),
          new Row(
            children: <Widget>[
              new Expanded(
                  child: _patientValue(
                      value: widget.patient.height.toString() +
                          " " +
                          widget.patient.heightUom,
                      image: 'assets/img/height.png')),
              new Expanded(
                  child: _patientValue(
                      value: widget.patient.weight.toString() +
                          " " +
                          widget.patient.weightUom,
                      image: 'assets/img/weight_machine.png'))
            ],
          ),
        ],
      ),
    );

    final patientCard = new Container(
      child: patientCardContent,
      height: 124.0,
      margin: new EdgeInsets.only(left: 46.0),
      decoration: new BoxDecoration(
        color: new Color.fromRGBO(14, 107, 168, 1),
        shape: BoxShape.rectangle,
        borderRadius: new BorderRadius.circular(8.0),
        boxShadow: <BoxShadow>[
          new BoxShadow(
            color: Colors.black12,
            blurRadius: 10.0,
            offset: new Offset(0.0, 10.0),
          ),
        ],
      ),
    );

    return Container(
      height: 120.0,
      margin: const EdgeInsets.symmetric(
        vertical: 16.0,
        horizontal: 16.0,
      ),
      child: GestureDetector(
        onTap: () => {
          debugPrint(widget.patient.name),
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MultiBlocProvider(
                providers: [
                  BlocProvider<PatientDetailsBloc>(
                    create: (context) => PatientDetailsBloc(
                      repository: locator<PatientDetailsRepository>(),
                    ),
                  ),
                  BlocProvider<MedicamentsBloc>(
                    create: (context) => MedicamentsBloc(
                      repository: locator<MedicamentsRepository>(),
                    ),
                  ),
                ],
                child: PatientDetailsScreen(
                  patientId: widget.patient.patientId,
                  patientDetailsBloc: PatientDetailsBloc(
                    repository: locator<PatientDetailsRepository>(),
                  ),
                  medicamentsBloc: MedicamentsBloc(
                    repository: locator<MedicamentsRepository>(),
                  ),
                ),
              ),
            ),
          ),
        },
        child: new Stack(
          children: <Widget>[
            patientCard,
            patientThumbnail,
          ],
        ),
      ),
    );
  }
}
