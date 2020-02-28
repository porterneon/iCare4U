import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icare4u_ui/models/patient.dart';
import 'package:icare4u_ui/patient/bloc/patient_details_bloc.dart';

class PatientList extends StatefulWidget {
  final String _userId;

  PatientList({
    Key key,
    String userId,
  })  : _userId = userId,
        super(key: key);

  @override
  _PatientListState createState() => _PatientListState();
}

class _PatientListState extends State<PatientList> {
  PatientDetailsBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = BlocProvider.of<PatientDetailsBloc>(context);

    _bloc.add(FetchPatientCollection(
      userId: widget._userId,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PatientDetailsBloc, PatientDetailsState>(
      listener: (context, state) {
        if (state is PatientCollectionError) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [Text('Fetch patients failure'), Icon(Icons.error)],
                ),
                backgroundColor: Colors.red,
              ),
            );
        }

        if ((state is PatientCollectionEmpty || state is PatientDetailsEmpty) &&
            widget._userId != null) {
          debugPrint('fetch patient collection');
          _bloc.add(FetchPatientCollection(
            userId: widget._userId,
          ));
        }

        if (state is PatientCollectionLoading) {
          debugPrint('loading patient collection');
        }

        if (state is PatientCollectionLoaded) {
          debugPrint("patients loaded");
        }
      },
      child: BlocBuilder<PatientDetailsBloc, PatientDetailsState>(
        builder: (context, state) {
          if (state is PatientCollectionLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is PatientCollectionLoaded) {
            return Center(
              child: buildPatientList(state.patients),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }

  Widget buildPatientList(List<Patient> data) {
    return ListView.builder(
        physics: AlwaysScrollableScrollPhysics(),
        itemCount: data.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            child: _tile(data[index], Icons.person),
          );
        });
  }

  Widget _tile(Patient patient, IconData icon) => ExpansionTile(
        // onTap: () => {
        //   debugPrint(patient.name),
        // },
        children: <Widget>[
          Container(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Row(
                  children: <Widget>[
                    Text("Age:"),
                    Text(patient.age),
                  ],
                ),
              ),
            ),
          ),
          Container(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Text("Weight:"),
                    SizedBox(
                      width: 5,
                    ),
                    Text(patient.weight.toString()),
                    SizedBox(
                      width: 5,
                    ),
                    Text(patient.weightUom),
                  ],
                ),
              ),
            ),
          ),
          Container(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Text("Height:"),
                    SizedBox(
                      width: 5,
                    ),
                    Text(patient.height.toString()),
                    SizedBox(
                      width: 5,
                    ),
                    Text(patient.heightUom),
                  ],
                ),
              ),
            ),
          ),
        ],
        title: Text(
          patient.name,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 20,
          ),
        ),
        // subtitle: Text(patient.patientId),
        leading: Icon(
          icon,
          color: Colors.blue[500],
        ),
      );
}
