import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icare4u_ui/bloc/user_details_bloc/user_details_bloc.dart';
import 'package:icare4u_ui/models/user.dart';
import 'package:provider/provider.dart';

class UserDetailsComponent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userId = Provider.of<User>(context).uid;
    BlocProvider.of<UserDetailsBloc>(context)
        .add(FetchUserDetails(userId: userId));
    return Container(
      child: Center(
        child: BlocBuilder<UserDetailsBloc, UserDetailsState>(
          builder: (context, state) {
            if (state is UserDetailsEmpty) {
              return Center(child: Text('Please Select a Location'));
            }
            if (state is UserDetailsLoading) {
              return Center(child: CircularProgressIndicator());
            }
            if (state is UserDetailsLoaded) {
              final userDetails = state.userDetails;

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
                          color: Colors.white,
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
