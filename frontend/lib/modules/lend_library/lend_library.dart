import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';

import '../../app_scaffold.dart';
import '../../common/socket_service.dart';
import '../../common/form_input/input_fields.dart';
import './lend_library_item_class.dart';
import './lend_library_item_state.dart';
import '../user_auth/current_user_state.dart';

class LendLibrary extends StatefulWidget {
  @override
  _LendLibraryState createState() => _LendLibraryState();
}

class _LendLibraryState extends State<LendLibrary> {
  List<String> _routeIds = [];
  SocketService _socketService = SocketService();
  InputFields _inputFields = InputFields();
  Location _location = Location();

  final _formKey = GlobalKey<FormState>();
  var _filters = {
    'title': '',
    //'tags': '',
    'lng': -999.0,
    'lat': -999.0,
  };
  bool _loading = false;
  String _message = '';
  bool _canLoadMore = false;
  int _lastPageNumber = 1;
  int _itemsPerPage = 25;
  bool _skipCurrentLocation = false;
  bool _locationLoaded = false;

  List<LendLibraryItemClass> _lendLibraryItems = [];
  bool _firstLoadDone = false;
  var _selectedLendLibraryItem = {
    'id': '',
  };

  @override
  void initState() {
    super.initState();

    _routeIds.add(_socketService.onRoute('getLendLibraryItems', callback: (String resString) {
      var res = jsonDecode(resString);
      var data = res['data'];
      if (data['valid'] == 1) {
        if (data.containsKey('lendLibraryItems')) {
          _lendLibraryItems = [];
          for (var lendLibraryItem in data['lendLibraryItems']) {
            _lendLibraryItems.add(LendLibraryItemClass.fromJson(lendLibraryItem));
          }
          if (_lendLibraryItems.length == 0) {
            _message = 'No results found.';
          }
        } else {
          _message = 'Error.';
        }
      } else {
        _message = data['msg'].length > 0 ? data['msg'] : 'Error.';
      }
      setState(() {
        _loading = false;
        _message = _message;
        _lendLibraryItems = _lendLibraryItems;
      });
    }));

    _routeIds.add(_socketService.onRoute('removeLendLibraryItem', callback: (String resString) {
      var res = jsonDecode(resString);
      var data = res['data'];
      if (data['valid'] == 1) {
        _getLendLibraryItems();
      } else {
        _message = data['msg'].length > 0 ? data['msg'] : 'Error.';
      }
      setState(() {
        _loading = false;
        _message = _message;
      });
    }));

    WidgetsBinding.instance.addPostFrameCallback((_){
      _init();
    });
  }

  @override
  void dispose() {
    _socketService.offRouteIds(_routeIds);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    checkFirstLoad();

    var currentUserState = context.watch<CurrentUserState>();

    var columnsCreate = [
      Align(
        alignment: Alignment.topRight,
        child: ElevatedButton(
          onPressed: () {
            Provider.of<LendLibraryItemState>(context, listen: false).clearLendLibraryItem();
            context.go('/lend-library-save');
          },
          child: Text('Lend New Item'),
        ),
      ),
      SizedBox(height: 10),
    ];

    return AppScaffoldComponent(
      body: ListView(
        children: [
          Align(
            alignment: Alignment.center,
            child: Container(
              padding: EdgeInsets.only(top: 20, bottom: 30, left: 10, right: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ...columnsCreate,
                  Align(
                    alignment: Alignment.center,
                    child: Form(
                      key: _formKey,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      child: Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        alignment: WrapAlignment.center,
                        children: [
                          SizedBox(
                            width: 200,
                            child: _inputFields.inputText(context, _filters, 'title', hint: 'title',
                              label: 'Filter by Title', debounceChange: 1000, onChange: (String val) {
                              _getLendLibraryItems();
                            }),
                          ),
                        ]
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: _buildLendLibraryItemResults(context, currentUserState),
                  ),
                ]
              )
            )
          )
        ]
      )
    );
  }

  void checkFirstLoad() {
    if (!_firstLoadDone && _locationLoaded) {
      _firstLoadDone = true;
      _getLendLibraryItems();
    }
  }

  void _init() async {
    if (!_skipCurrentLocation) {
      var coordinates = await _location.getLocation();
      if (coordinates.latitude != null) {
        _filters['lat'] = coordinates.latitude!;
        _filters['lng'] = coordinates.longitude!;
        setState(() {
          _filters = _filters;
        });
      }
      _locationLoaded = true;
      checkFirstLoad();
    }
  }

  Widget _buildMessage(BuildContext context) {
    if (_message.length > 0) {
      return Container(
        padding: EdgeInsets.only(top: 20, bottom: 20, left: 10, right: 10),
        child: Text(_message),
      );
    }
    return SizedBox.shrink();
  }

  _buildLendLibraryItem(LendLibraryItemClass lendLibraryItem, BuildContext context, var currentUserState) {
    var buttons = [];
    if (currentUserState.isLoggedIn && lendLibraryItem.userIdOwner == currentUserState.currentUser.id) {
      buttons = [
        ElevatedButton(
          onPressed: () {
            Provider.of<LendLibraryItemState>(context, listen: false).setLendLibraryItem(lendLibraryItem);
            context.go('/lend-library-save');
          },
          child: Text('Edit'),
        ),
        SizedBox(width: 10),
        ElevatedButton(
          onPressed: () {
            _socketService.emit('removeLendLibraryItem', { 'id': lendLibraryItem.id });
          },
          child: Text('Delete'),
          style: ElevatedButton.styleFrom(
            primary: Theme.of(context).errorColor,
          ),
        ),
      ];
    }
    if (currentUserState.isLoggedIn && lendLibraryItem.userIdOwner != currentUserState.currentUser.id) {
      buttons += [
        SizedBox(width: 10),
        ElevatedButton(
          onPressed: () {
            _selectedLendLibraryItem = {
              'id': lendLibraryItem.id!,
            };
            setState(() {
              _selectedLendLibraryItem = _selectedLendLibraryItem;
            });
          },
          child: Text('Borrow'),
          //style: ElevatedButton.styleFrom(
          //  primary: Theme.of(context).successColor,
          //),
        ),
      ];
    }

    var columnsDistance = [];
    if (lendLibraryItem.xDistanceKm >= 0) {
      columnsDistance = [
        Text('${lendLibraryItem.xDistanceKm.toStringAsFixed(1)} km away'),
        SizedBox(height: 10),
      ];
    }

    var columnsSelected = [];
    if (lendLibraryItem.id == _selectedLendLibraryItem['id']) {
      columnsSelected = [
        Text('${lendLibraryItem.xOwner['email']}'),
        SizedBox(height: 10),
      ];
    }

    return SizedBox(
      width: 300,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(lendLibraryItem.imageUrl!, height: 300, width: double.infinity, fit: BoxFit.cover),
          SizedBox(height: 5),
          Text(lendLibraryItem.title!,
            style: Theme.of(context).textTheme.headline2,
          ),
          SizedBox(height: 5),
          //Text('Tags: ${lendLibraryItem.tags.join(', ')}'),
          //SizedBox(height: 5),
          Text('${lendLibraryItem.description}'),
          SizedBox(height: 10),
          ...columnsDistance,
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ...buttons,
            ]
          ),
          SizedBox(height: 10),
          ...columnsSelected,
          SizedBox(height: 10),
        ]
      )
    );
  }

  _buildLendLibraryItemResults(BuildContext context, var currentUserState) {
    if (_lendLibraryItems.length > 0) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20),
          Wrap(
            spacing: 20,
            runSpacing: 20,
            alignment: WrapAlignment.center,
            children: <Widget> [
              ..._lendLibraryItems.map((lendLibraryItem) => _buildLendLibraryItem(lendLibraryItem, context, currentUserState) ).toList(),
            ]
          ),
        ]
      );
    }
    return _buildMessage(context);
  }

  void _getLendLibraryItems({int lastPageNumber = 0}) {
    setState(() {
      _loading = true;
      _message = '';
      _canLoadMore = false;
    });
    if (lastPageNumber != 0) {
      _lastPageNumber = lastPageNumber;
    } else {
      _lastPageNumber = 1;
    }
    var data = {
      //'page': _lastPageNumber,
      'skip': (_lastPageNumber - 1) * _itemsPerPage,
      'limit': _itemsPerPage,
      //'sortKey': '-created_at',
      //'tags': [],
      'withOwnerInfo': 1,
      'lngLatOrigin': [_filters['lng'], _filters['lat']],
    };
    if (_filters['title'] != '') {
      data['title'] = _filters['title']!;
    }
    //if (_filters['tags'] != '') {
    //  data['tags'] = [ _filters['tags'] ];
    //}
    _socketService.emit('getLendLibraryItems', data);
  }

}
