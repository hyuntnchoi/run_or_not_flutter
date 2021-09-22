import 'dart:convert';
import 'package:xml2json/xml2json.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class Subway extends StatefulWidget {
  @override
  _SubwayState createState() => _SubwayState();
}

class _SubwayState extends State<Subway> {

  String apiUrl = 'http://swopenapi.seoul.go.kr/api/subway/'
                + '646b55564768797535374a76614678' + '/xml/realtimeStationArrival/0/5/'
                + '부천';
  String stationName = "부천";
  List<dynamic> _stationInfo = [];
  late Future<List<dynamic>> _initStationInfo;

  @override
  void initState() {
    super.initState();
    _initStationInfo = _initData();
  }

  Future<List<dynamic>> _initData() async {
    final info =  await fetchStationInfo();
    _stationInfo = info;
    return info;
  }

  Future<void> _refreshData() async {
    final info = await fetchStationInfo();
    setState(() {
      _stationInfo = info;
    });
  }

  Future<List<dynamic>> fetchStationInfo() async {

    Map<String, dynamic> result = new Map<String, dynamic>();

    Map<String, String> headers = {"Accept": "text/html,application/xml"};
    http.Response res = await http.get(Uri.parse(apiUrl), headers: headers);

    if(res.statusCode == 200) {
      final transformer = Xml2Json();
      transformer.parse(utf8.decode(res.bodyBytes));
      String jsonString = transformer.toParker();

      result = jsonDecode(jsonString)['realtimeStationArrival'];
    }

    return result['row'];
  }

  String getDestination(dynamic info) {
    var destination = info['bstatnNm'];
    return destination.toString();
  }

  String getStatus(dynamic info) {
    var status = info['arvlMsg2'];
    return status.toString();
  }

  String getTimeDiff(dynamic info) {
    String result;

    var receivedTime = info['recptnDt'];

    var formattedReceivedTime = DateTime.parse(receivedTime);

    var currentTime = DateTime.now();

    var diff = currentTime.difference(formattedReceivedTime).inSeconds;

    if(diff < 60) {
      result = '업데이트: ' + diff.toString() + '초 전';
    } else {
      var minute = diff ~/ 60;
      var second = diff % 60;
      result = '업데이트: ' + minute.toString() + '분' + second.toString() + '초 전';
    }

    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(stationName + '역에서 뛸까 말까?'),
      ),
      body: FutureBuilder(
        future: _initStationInfo,
        builder: (BuildContext context, snapshot) {
          if(snapshot.hasData) {
            return RefreshIndicator(
              onRefresh: _refreshData,
              child: ListView.builder(
                padding: EdgeInsets.all(8),
                itemCount: _stationInfo.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card (
                    child: Column(
                      children: <Widget>[
                        ListTile (
                            title: Text(getDestination(_stationInfo[index])),
                            subtitle: Text(getStatus(_stationInfo[index])),
                            trailing: Text(getTimeDiff(_stationInfo[index]))
                        )
                      ],
                    ),
                  );
                },
              )
            );
          } else {
            return Center(
              child: CircularProgressIndicator()
            );
          }
        },
      ),
    );
  }
}

