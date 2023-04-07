import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';

import '../../app_scaffold.dart';
import '../../common/socket_service.dart';
import '../../common/form_input/input_fields.dart';
import '../../common/form_input/image_save.dart';
import './lend_library_item_class.dart';
import './lend_library_item_state.dart';
import '../user_auth/current_user_state.dart';

class LendLibraryItemSave extends StatefulWidget {
  @override
  _LendLibraryItemSaveState createState() => _LendLibraryItemSaveState();
}

class _LendLibraryItemSaveState extends State<LendLibraryItemSave> {
  List<String> _routeIds = [];
  SocketService _socketService = SocketService();
  InputFields _inputFields = InputFields();
  Location _location = Location();

  final _formKey = GlobalKey<FormState>();
  var formVals = {};
  bool _loading = false;
  String _message = '';
  var _formValsUser = {
    'latitude': -999.0,
    'longitude': -999.0,
  };

  bool _loadedLendLibraryItem = false;
  bool _skipCurrentLocation = false;

  @override
  void initState() {
    super.initState();

    _routeIds.add(_socketService.onRoute('saveLendLibraryItem', callback: (String resString) {
      var res = jsonDecode(resString);
      var data = res['data'];
      if (data['valid'] == 1) {
        context.go('/lend-library');
      } else {
        setState(() { _message = data['msg'].length > 0 ? data['msg'] : 'Error, please try again.'; });
      }
      setState(() { _loading = false; });
    }));

    if (!Provider.of<CurrentUserState>(context, listen: false).isLoggedIn) {
      Timer(Duration(milliseconds: 200), () {
        context.go('/lend-library');
      });
    } else {
      WidgetsBinding.instance.addPostFrameCallback((_){
        _init();
      });
    }
  }

  @override
  void dispose() {
    _socketService.offRouteIds(_routeIds);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var lendLibraryItemState = context.watch<LendLibraryItemState>();
    if (lendLibraryItemState.lendLibraryItem != null && !_loadedLendLibraryItem) {
      _loadedLendLibraryItem = true;
      setFormVals(lendLibraryItemState.lendLibraryItem);
    }

    if (!Provider.of<CurrentUserState>(context, listen: false).isLoggedIn) {
      return Text("You must be logged in");
    }
    var currentUserState = context.watch<CurrentUserState>();

    return AppScaffoldComponent(
      body: ListView(
        children: [
          Align(
            alignment: Alignment.center,
            child: Container(
              width: 900,
              padding: EdgeInsets.only(top: 20, left: 10, right: 10),
              child: Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildUserLngLat(context, currentUserState),
                    ImageSaveComponent(formVals: formVals, formValsKey: 'imageUrl', multiple: false,
                      label: 'Image', imageUploadSimple: true, maxImageSize: 1200),
                    SizedBox(height: 10),
                    _inputFields.inputText(context, formVals, 'title', label: 'Title', required: true),
                    SizedBox(height: 10),
                    _inputFields.inputText(context, formVals, 'description', label: 'Description', required: false, minLines: 5, maxLines: 5),
                    SizedBox(height: 10),
                    _buildSubmit(context, currentUserState),
                    _buildMessage(context),
                    SizedBox(height: 50),
                  ]
                )
              )
            )
          )
        ]
      )
    );
  }

  void _init() async {
    if (!_skipCurrentLocation) {
      var coordinates = await _location.getLocation();
      if (coordinates.latitude != null) {
        _formValsUser['latitude'] = coordinates.latitude!;
        _formValsUser['longitude'] = coordinates.longitude!;
        setState(() {
          _formValsUser = _formValsUser;
        });
      }
    }
  }

  Widget _buildSubmit(BuildContext context, currentUserState) {
    if (_loading) {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 16.0),
        child: LinearProgressIndicator(),
      );
    }
    return Padding(
      padding: EdgeInsets.only(top: 15, bottom: 5),
      child: ElevatedButton(
        onPressed: () {
          _message = '';
          _loading = false;
          if (formValid(currentUserState)) {
            _loading = true;
            _formKey.currentState?.save();
            save(currentUserState);
          } else {
            _message = 'Please fill out all fields and try again.';
          }
          setState(() {
            _message = _message;
            _loading = _loading;
          });
        },
        child: Text('Save Item'),
      ),
    );
  }

  Widget _buildMessage(BuildContext context) {
    if (_message.length > 0) {
      return Text(_message);
    }
    return SizedBox.shrink();
  }

  Widget _buildUserLngLat(BuildContext context, currentUserState) {
    if (currentUserState.currentUser.lngLat.length < 1) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                flex: 1,
                child: _inputFields.inputNumber(context, _formValsUser, 'longitude', label: 'Longitude', required: true, onChange: (double? val) {
                  saveUser(currentUserState);
                }),
              ),
              SizedBox(width: 10),
              Expanded(
                flex: 1,
                child: _inputFields.inputNumber(context, _formValsUser, 'latitude', label: 'Latitude', required: true, onChange: (double? val) {
                  saveUser(currentUserState);
                }),
              ),
              SizedBox(width: 10),
            ]
          ),
          SizedBox(height: 10),
        ]
      );
    }
    return SizedBox.shrink();
  }

  void setFormVals(LendLibraryItemClass lendLibraryItem) {
    formVals['_id'] = lendLibraryItem.id;
    formVals['title'] = lendLibraryItem.title;
    formVals['description'] = lendLibraryItem.description;
    formVals['imageUrl'] = lendLibraryItem.imageUrl;
    //formVals['tags'] = lendLibraryItem.tags;
    formVals['tags'] = [];
  }

  bool formValid(currentUserState) {
    if (!_formKey.currentState!.validate()) {
      return false;
    }
    if (currentUserState.currentUser.lngLat.length < 1 && 
      (_formValsUser['latitude'] == null || _formValsUser['longitude'] == null)) {
      return false;
    }
    return true;
  }

  void save(currentUserState) {
    if (currentUserState.currentUser.lngLat.length < 1) {
      saveUser(currentUserState);
    }

    var data = {
      'lendLibraryItem': formVals,
    };
    _socketService.emit('saveLendLibraryItem', data);
  }

  void saveUser(currentUserState) {
    if (_formValsUser['latitude'] != null && _formValsUser['longitude'] != null) {
      var user = {
        '_id': currentUserState.currentUser.id,
        'lngLat': [_formValsUser['longitude']!, _formValsUser['latitude']!],
      };
      _socketService.emit('saveUser', { 'user': user });
      var user1 = currentUserState.currentUser;
      user1.lngLat = user['lngLat'];
      Provider.of<CurrentUserState>(context, listen: false).setCurrentUser(user1);
    }
  }

}
