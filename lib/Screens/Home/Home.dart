import 'dart:async';
import 'dart:collection';
import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:weight_app_firebase/AppConsts/AppConsts.dart';
import 'package:weight_app_firebase/CommonFunctions/CommonFunctions.dart';
import 'package:weight_app_firebase/Screens/Home/bloc/home_bloc.dart';

class HomeScreen extends StatefulWidget {
  static String id = 'home';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeBloc homeBloc;

  final GlobalKey<ScaffoldState> globalkey = GlobalKey();

  DateTime dateTime = DateTime.now();
  int currentMonth;

  Stream<QuerySnapshot> weightsData;
  String weight;
  int currentDay;
  bool isUpdating = false;
  String newWeight;
  Timer _timer;

  @override
  void initState() {
    homeBloc = BlocProvider.of<HomeBloc>(context);
    homeBloc.add(FetchWeights());
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      bloc: homeBloc,
      listener: (context, state) {
        if (state is LoadingState) {
        } else if (state is ErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(state.error),
          ));
        } else if (state is InfoMessage) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(state.message),
          ));
        } else if (state is WeightsFetched) {
          weightsData = state.data;
        }
      },
      builder: (context, state) {
        return Scaffold(
          key: globalkey,
          backgroundColor: AppConsts.primaryColor,
          appBar: AppBar(
            backgroundColor: AppConsts.primaryColor,
            elevation: 0,
            centerTitle: true,
            actions: [],
            title: Column(
              children: [
                AutoSizeText(
                  'Home',
                  style: AppConsts.whiteBoldWithSpacing,
                  presetFontSizes: [24],
                ),
              ],
            ),
          ),
          body: ListView(
            children: [
              SizedBox(
                height: deviceHeight(context) * 0.05,
              ),
              Container(
                height: 50,
                width: deviceWidth(context) * 0.8,
                margin: EdgeInsets.symmetric(
                    horizontal: deviceWidth(context) * 0.05),
                child: TextFormField(
                    onChanged: (var value) {
                      weight = value;
                    },
                    decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.person,
                          color: AppConsts.secTextColor,
                        ),
                        fillColor: AppConsts.primaryTextColor,
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        hintText: "Enter weight in kg",
                        hintStyle: AppConsts.blackBold,
                        suffixIcon: state is LoadingState
                            ? IconButton(
                                icon: Icon(
                                  Icons.more_horiz_outlined,
                                  color: AppConsts.secTextColor,
                                ),
                                onPressed: () {},
                              )
                            : IconButton(
                                icon: Icon(
                                  Icons.send,
                                  color: AppConsts.secTextColor,
                                ),
                                onPressed: () {
                                  homeBloc.add(AddWeight(
                                      weight: weight,
                                      time: DateTime.now().toString()));
                                  setState(() {
                                    weight = null;
                                  });
                                },
                              ))),
              ),
              SizedBox(
                height: 8.0,
              ),
              weights(),
            ],
          ),
        );
      },
    );
  }

  Widget weights() {
    return StreamBuilder(
        stream: weightsData,
        builder: (context, snapshot) {
          var asyncdata = snapshot.data;

          return Container(
            height: deviceHeight(context) * 0.8,
            width: deviceWidth(context),
            child: ListView.builder(
                physics: ScrollPhysics(),
                itemCount: asyncdata != null
                    ? asyncdata.docs != null
                        ? asyncdata.docs.length
                        : 0 ?? 0
                    : 0,
                itemBuilder: (context, index) {
                  if (snapshot.hasData) {
                    return Container(
                      height: 50,
                      width: deviceWidth(context) * 0.8,
                      margin: EdgeInsets.symmetric(
                          horizontal: deviceWidth(context) * 0.05),
                      child: TextFormField(
                          onChanged: (var value) {
                            newWeight = value;
                          },
                          decoration: InputDecoration(
                              prefixIcon: IconButton(
                                icon: Icon(
                                  Icons.edit,
                                  color: AppConsts.secTextColor,
                                ),
                                onPressed: () {
                                  homeBloc.add(UpdateWeight(
                                      weight: newWeight,
                                      time: DateTime.now().toString(),
                                      id: snapshot.data.docs[index]['id']));
                                },
                              ),
                              fillColor: AppConsts.primaryTextColor,
                              filled: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              hintText: snapshot.data.docs[index]['weight'],
                              hintStyle: AppConsts.blackBold,
                              suffixText: snapshot.data.docs[index]['time'],
                              suffixStyle: AppConsts.blackBold,
                              suffixIcon: IconButton(
                                icon: Icon(
                                  Icons.delete,
                                  color: AppConsts.secTextColor,
                                ),
                                onPressed: () {
                                  homeBloc.add(DeleteWeight(
                                      id: snapshot.data.docs[index]['id']));
                                },
                              ))),
                    );
                  } else {
                    return CircularProgressIndicator();
                  }
                }),
          );
        });
  }
}
