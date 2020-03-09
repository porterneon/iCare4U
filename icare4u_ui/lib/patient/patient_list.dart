import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icare4u_ui/models/patient.dart';
import 'package:icare4u_ui/patient/bloc/patient_list_bloc.dart';
import 'package:icare4u_ui/patient/patient_row.dart';

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
  PatientListBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = BlocProvider.of<PatientListBloc>(context);

    _bloc.add(FetchPatientCollection(
      userId: widget._userId,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PatientListBloc, PatientListState>(
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

        if ((state is PatientCollectionEmpty ||
                state is PatientCollectionEmpty) &&
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
      child: BlocBuilder<PatientListBloc, PatientListState>(
        builder: (context, state) {
          if (state is PatientCollectionLoading) {
            return Column(
              children: <Widget>[
                Center(
                  child: SizedBox(
                    height: 100.0,
                    width: 100.0,
                    child: CircularProgressIndicator(),
                  ),
                ),
              ],
            );
          }

          if (state is PatientCollectionLoaded) {
            return Column(
              children: <Widget>[
                buildPatientSilverList(state.patients),
              ],
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }

  Widget buildPatientSilverList(List<Patient> patients) {
    return new Expanded(
      child: new Container(
        color: Colors.transparent,
        child: new CustomScrollView(
          scrollDirection: Axis.vertical,
          shrinkWrap: false,
          slivers: <Widget>[
            new SliverPadding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              sliver: new SliverList(
                delegate: new SliverChildBuilderDelegate(
                  (context, index) => new PatientRow(patients[index]),
                  childCount: patients.length,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
