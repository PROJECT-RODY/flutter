import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

_postRequest(user_title, user_story, user_counter) async {
  String url = 'http://ec2-3-37-243-73.ap-northeast-2.compute.amazonaws.com:8080/create_story';

  http.Response response = await http.post(
    url,
    headers: <String, String> {
      'Content-Type': 'application/x-www-form-urlencoded',
    },
    body: <String, String> {
      'user_title': user_title,
      'user_story': user_story,
      'user_counter': user_counter.toString()
    },
  );
  return utf8.decode(response.bodyBytes).replaceAll('\\','');
}

image_postRequest(user_description1, user_description2, user_description3) async {
  String url = 'http://ec2-3-37-243-73.ap-northeast-2.compute.amazonaws.com:8080/create_image';

  http.Response response = await http.post(
    url,
    headers: <String, String> {
      'Content-Type': 'application/x-www-form-urlencoded',
    },
    body: <String, String> {
      'situation_field_1': user_description1,
      'situation_field_2': user_description2,
      'situation_field_3': user_description3
    },
  );
  return utf8.decode(response.bodyBytes).replaceAll('\\','');
}

pdf_postRequest(user_title, user_story, user_image, user_email) async {
  String url = 'http://ec2-3-37-243-73.ap-northeast-2.compute.amazonaws.com:8080/create_result';

  http.Response response = await http.post(
    url,
    headers: <String, String> {
      'Content-Type': 'application/x-www-form-urlencoded',
    },
    body: <String, String> {
      'user_title': user_title,
      'user_story': user_story,
      'user_image': user_image,
      'user_email': user_email,
    },
  );
  return utf8.decode(response.bodyBytes).replaceAll('\\','');
}

class Todo {
  final String title;
  final String story;
  final String img_src;

  Todo(this.title, this.story, this.img_src);
}


void main() {
  runApp(MaterialApp(
    title: 'Named routes Demo',
    // "/"을 앱이 시작하게 될 route로 지정합니다. 본 예제에서는 FirstScreen 위젯이 첫 번째 페이지가
    // 될 것입니다.
    initialRoute: '/',
    routes: {
      // When we navigate to the "/" route, build the FirstScreen Widget
      // "/" Route로 이동하면, FirstScreen 위젯을 생성합니다.
      '/': (context) => MainScreen(),
      '/first': (context) => FirstScreen(),
      // "/second" route로 이동하면, SecondScreen 위젯을 생성합니다.
      '/second': (context) => SecondScreen(),
      '/third': (context) => ThirdScreen(),
    },
  ));
}
class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "RODY",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 30,
              color: Colors.purple,
            ),
          ),
          backgroundColor: Colors.yellow,
        ),
        body : Center(
          child: Column(
            children: <Widget>[
              Padding(
                  padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 10.0),
                  child: Column(
                    children: [
                      Container(
                          width: 500,
                          height: 450,
                          margin: const EdgeInsets.only(top: 15.0),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10)
                          ),
                          child : Center(
                            child: Text(
                              "로디와 함께 이야기 만들기!",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 30,
                                color: Colors.purple,
                              ),
                            ),
                          )
                          // child: ClipRRect(
                          //
                          //     borderRadius: BorderRadius.circular(10),
                          //     child:Image.network('http://ec2-3-37-243-73.ap-northeast-2.compute.amazonaws.com:8080/static/user_image/'+todos.img_src+'.png')
                          // )
                      ),
                      Container(
                        height: 500,
                      ),
                      Container(
                          child: Row (
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Container(
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      primary: Colors.yellowAccent, // background
                                      onPrimary: Colors.purple, // foreground
                                    ),
                                    child: Text('시작하기!',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                      ),
                                    ),
                                    onPressed: () async {
                                      Navigator.pushNamed(context, '/first');
                                    },
                                  ),
                                ),
                              ]
                          )
                      ),
                    ],
                  )
              ),
            ],
          ),
        )
    );
  }
}


//이야기 생성 페이지 시작
class FirstScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var todos;
    var result;
    var counter = 1;
    final title_value = TextEditingController();
    final story_value = TextEditingController();
    todos = Todo('First Screen', '', '');

    return Scaffold(
        appBar: AppBar(
          title: Text(
            "RODY",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 30,
              color: Colors.purple,
            ),
          ),
          backgroundColor: Colors.yellow,
        ),
        body : SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: 300,
                height: 0,
                margin: EdgeInsets.all(40.0),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 10.0),
                child: Column(
                  children: [
                    Container(
                      width: 600,
                      margin: EdgeInsets.all(40.0),
                      child : TextField(
                        decoration: InputDecoration(
                          labelText: '제목',
                          hintText: '제목을 입력 하세요',
                          labelStyle: TextStyle(color: Colors.black54),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
                            borderSide: BorderSide(width: 1, color: Colors.black54),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
                            borderSide: BorderSide(width: 1, color: Colors.black54),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          ),
                        ),
                        controller: title_value,
                      ),
                    ),
                    Container(
                      width: 600,
                      height: 300,
                      child : TextField(
                        maxLines: null,
                        decoration: InputDecoration(
                          labelText: '이야기',
                          hintText: '이야기를 입력하세요.',
                          labelStyle: TextStyle(color: Colors.blueAccent),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
                            borderSide: BorderSide(width: 1, color: Colors.blueAccent),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
                            borderSide: BorderSide(width: 1, color: Colors.blueAccent),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          ),
                        ),
                        controller: story_value,
                      ),
                    ),
                    Container( //임시로 만들어둔거 버튼 맨 아래로 보내기 위해..
                      height: 500,
                    ),
                    Container(
                      child: Row (
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[

                            Container(
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.yellowAccent, // background
                                  onPrimary: Colors.purple, // foreground
                                ),
                                child: Text('이야기 생성!'),
                                onPressed: () async {
                                  result = await _postRequest(title_value.text, story_value.text, counter);
                                  counter += 1;
                                  todos = Todo(title_value.text, result.toString().substring(1, result.lastIndexOf('"')), '');
                                  // Named route를 사용하여 두 번째 화면으로 전환합니다.
                                  story_value.text = todos.story;
                                },
                              ),
                            ),
                            Container(
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.yellowAccent, // background
                                  onPrimary: Colors.purple, // foreground
                                ),
                                onPressed: () {
                                  // 현재 route를 스택에서 제거함으로써 첫 번째 스크린으로 되돌아 갑니다.
                                  Navigator.pushNamed(context, '/second', arguments:todos);
                                },
                                child: Text('이미지 생성!'),
                              ),
                            ),
                          ]
                      )
                    ),
                  ],
                )
              ),
            ],
          ),
        )
    );
  }
}

//이미지 생성 페이지 시작
class SecondScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var todos = ModalRoute.of(context)!.settings.arguments as Todo;
    var result;
    final description1_value = TextEditingController();
    final description2_value = TextEditingController();
    final description3_value = TextEditingController();

    return Scaffold(
        appBar: AppBar(
          title: Text(
            "RODY",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 30,
              color: Colors.purple,
            ),
          ),
          backgroundColor: Colors.yellow,
        ),
        body : SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.all(20.0),

              ),
              Padding(
                  padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 10.0),
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.all(15.0),
                        child : TextField(
                          decoration: InputDecoration(
                            labelText: '상황을 입력 하세요',
                            hintText: '1가지 이상의 상황이 더 정확합니다.',
                            labelStyle: TextStyle(color: Colors.black54),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10.0)),
                              borderSide: BorderSide(width: 1, color: Colors.black54),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10.0)),
                              borderSide: BorderSide(width: 1, color: Colors.black54),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10.0)),
                            ),
                          ),
                          controller: description1_value,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(15.0),
                        child : TextField(
                          decoration: InputDecoration(
                            labelText: '상황을 입력 하세요',
                            hintText: '2가지 상황이 가장 정확합니다.',
                            labelStyle: TextStyle(color: Colors.black54),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10.0)),
                              borderSide: BorderSide(width: 1, color: Colors.black54),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10.0)),
                              borderSide: BorderSide(width: 1, color: Colors.black54),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10.0)),
                            ),
                          ),
                          controller: description2_value,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(15.0),
                        child : TextField(
                          decoration: InputDecoration(
                            labelText: '상황을 입력 하세요',
                            hintText: '2가지 상황이 가장 정확합니다.',
                            labelStyle: TextStyle(color: Colors.black54),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10.0)),
                              borderSide: BorderSide(width: 1, color: Colors.black54),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10.0)),
                              borderSide: BorderSide(width: 1, color: Colors.black54),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10.0)),
                            ),
                          ),
                          controller: description3_value,
                        ),
                      ),

                      Container(
                          child: Row (
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Container(
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      primary: Colors.yellowAccent, // background
                                      onPrimary: Colors.purple, // foreground
                                    ),
                                    child: Text('이미지 생성!'),
                                    onPressed: () async {
                                      result = await image_postRequest(description1_value.text, description1_value.text, description3_value.text);
                                      todos = Todo(todos.title, todos.story, result.toString().substring(1, result.lastIndexOf('"')));
                                      // Named route를 사용하여 두 번째 화면으로 전환합니다.
                                      // result
                                      Navigator.pushNamed(context, '/third', arguments:todos);

                                    },
                                  ),
                                ),
                              ]
                          )
                      ),
                    ],
                  )
              ),
            ],
          ),
        )
    );
  }
}

class ThirdScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var todos = ModalRoute.of(context)!.settings.arguments as Todo;
    var result;
    final title_value = TextEditingController();
    final story_value = TextEditingController();
    final email_value = TextEditingController();
    title_value.text = todos.title;
    story_value.text = todos.story;

    return Scaffold(
        appBar: AppBar(
          title: Text(
            "RODY",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 30,
              color: Colors.purple,
            ),
          ),
          backgroundColor: Colors.yellow,
        ),
        body : Center(
          child: Column(
            children: <Widget>[
              Padding(
                  padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 10.0),
                  child: Column(
                    children: [
                      RepaintBoundary(
                        child: Column(
                          children: [
                            Container(
                                width: 200,
                                height: 200,
                                margin: const EdgeInsets.only(top: 15.0),

                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10)
                                ),
                                child: ClipRRect(

                                    borderRadius: BorderRadius.circular(10),
                                    child:Image.network('http://ec2-3-37-243-73.ap-northeast-2.compute.amazonaws.com:8080/static/user_image/'+todos.img_src+'.png')
                                )
                            ),
                            Container(
                              width: 600,
                              margin: EdgeInsets.all(20.0),
                              child : TextField(
                                decoration: InputDecoration(
                                  labelText: '제목',
                                  hintText: '제목을 입력 하세요',
                                  labelStyle: TextStyle(color: Colors.black54),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                    borderSide: BorderSide(width: 1, color: Colors.black54),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                    borderSide: BorderSide(width: 1, color: Colors.black54),
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                  ),
                                ),
                                controller: title_value,
                              ),
                            ),
                            Container(
                              width: 600,
                              height: 200,
                              child : TextField(
                                maxLines: null,
                                decoration: InputDecoration(
                                  labelText: '이야기',
                                  hintText: '이야기를 입력하세요.',
                                  labelStyle: TextStyle(color: Colors.blueAccent),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                    borderSide: BorderSide(width: 1, color: Colors.blueAccent),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                    borderSide: BorderSide(width: 1, color: Colors.blueAccent),
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                  ),
                                ),
                                controller: story_value,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 600,
                        height: 200,
                        child : TextField(
                          maxLines: null,
                          decoration: InputDecoration(
                            labelText: '이메일',
                            hintText: '이메일 주소를 입력하세요.',
                            labelStyle: TextStyle(color: Colors.blueAccent),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10.0)),
                              borderSide: BorderSide(width: 1, color: Colors.blueAccent),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10.0)),
                              borderSide: BorderSide(width: 1, color: Colors.blueAccent),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10.0)),
                            ),
                          ),
                          controller: email_value,
                        ),
                      ),

                      Container(
                          child: Row (
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[

                                Container(
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      primary: Colors.yellowAccent, // background
                                      onPrimary: Colors.purple, // foreground
                                    ),
                                    child: Text('PDF 발송!'),
                                    onPressed: () async {
                                      result = await pdf_postRequest(todos.title, todos.story, todos.img_src, email_value.text);
                                      // Named route를 사용하여 두 번째 화면으로 전환합니다.
                                      email_value.text = result.toString();
                                    },
                                  ),
                                ),
                              ]
                          )
                      ),
                    ],
                  )
              ),
            ],
          ),
        )
    );
  }
}