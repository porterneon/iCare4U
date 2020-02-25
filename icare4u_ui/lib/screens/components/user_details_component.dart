import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icare4u_ui/bloc/user_details_bloc/user_details_bloc.dart';
// import 'package:icare4u_ui/models/user.dart';
import 'package:icare4u_ui/models/user_details.dart';
import 'package:icare4u_ui/repositories/user_repository.dart';
import 'package:icare4u_ui/service_locator.dart';
// import 'package:provider/provider.dart';
import 'package:icare4u_ui/repositories/repositories.dart';

class UserDetailsComponent extends StatefulWidget {
  @override
  _UserDetailsComponentState createState() => _UserDetailsComponentState();
}

class _UserDetailsComponentState extends State<UserDetailsComponent> {
  UserDetails userDetails = locator<UserDetails>();

  Future getUserDetails(BuildContext context) async {
    // final userId = Provider.of<User>(context).uid;

    final user = await locator<UserRepository>().getUser();
    BlocProvider.of<UserDetailsBloc>(context)
        .add(FetchUserDetails(userId: user.uid));
  }

  @override
  Widget build(BuildContext context) {
    if (userDetails == null || userDetails.userName == null) {
      getUserDetails(context);
    }

    return Container(
      child: Center(
        child: BlocBuilder<UserDetailsBloc, UserDetailsState>(
          builder: (context, state) {
            if (state is UserDetailsEmpty) {
              return Center(child: Text('Please LogIn to load user details.'));
            }
            if (state is UserDetailsLoading) {
              return Center(child: CircularProgressIndicator());
            }
            if (state is UserDetailsLoaded) {
              userDetails = state.userDetails;
              debugPrint(userDetails.userName);

              return ListView(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 10.0),
                    child: Center(
                      child: Text(
                        userDetails.userName,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w200,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10.0),
                    child: Center(
                      child: Text(
                        userDetails.email,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w200,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }
            if (state is UserDetailsError) {
              return Center(child: Text('Error getting user details.'));
            }

            return Center(child: Text('Nothis happen is bloc?'));
          },
        ),
      ),
    );
  }
}
