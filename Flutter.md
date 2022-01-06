# Flutter

## CLI

```shell
flutter pub upgrade	// 의존성 업데이트
flutter pub run build_runner build	// 모델 업데이트	
```



### StatelessWidget, StatelessWidget

- 두개의 가장 큰 차이점은 State 오브젝트를 가지고 있는지에 대한 유무

- 플로팅 버튼을 눌렀을 때 텍스트가 변경되게하는 예제

  ```dart
  class SampleApp extends StatelessWidget {
    // This widget is the root of your application.
    @override
    Widget build(BuildContext context) {
      return MaterialApp(
        title: 'Sample App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: SampleAppPage(),
      );
    }
  }
  
  class SampleAppPage extends StatefulWidget {
    SampleAppPage({Key key}) : super(key: key);
  
    @override
    _SampleAppPageState createState() => _SampleAppPageState();
  }
  
  class _SampleAppPageState extends State<SampleAppPage> {
    // Default placeholder text
    String textToShow = "I Like Flutter";
    void _updateText() {
      //setState()를 호출하면 위젯 전체적으로 리프레시!!
      setState(() {	
        // update the text
        textToShow = "Flutter is Awesome!";
      });
    }
    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Sample App"),
        ),
        body: Center(child: Text(textToShow)),
        floatingActionButton: FloatingActionButton(
          onPressed: _updateText,
          tooltip: 'Update Text',
          child: Icon(Icons.update),
        ),
      );
    }
  }
  ```

- 위 예제와 같이 setState()가 호출되면 페이지 전체를 다시 그리기 때문에 뷰를 추가하거나 삭제하는 일 없이 그냥 전부 새로 그린다고 생각하면 된다.



### 애니메이션

- AnimationController가 애니메이션의 시작, 중단, 재개 등을 판단하고 Transition 객체등을 컨트롤할다.

- 다음 예제는 플로팅 버튼을 눌렀을 때 AnimationController가 FadeTransition을 실행시키는 예제이다.

  ```dart
  class SampleApp extends StatelessWidget {
    // This widget is the root of your application.
    @override
    Widget build(BuildContext context) {
      return MaterialApp(
        title: 'Fade Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MyFadeTest(title: 'Fade Demo'),
      );
    }
  }
  
  class MyFadeTest extends StatefulWidget {
    MyFadeTest({Key key, this.title}) : super(key: key);
  
    final String title;
  
    @override
    _MyFadeTest createState() => _MyFadeTest();
  }
  
  class _MyFadeTest extends State<MyFadeTest> with TickerProviderStateMixin {
    AnimationController controller;
    CurvedAnimation curve;
  
    @override
    void initState() {
      controller = AnimationController(duration: const Duration(milliseconds: 2000), vsync: this);
      curve = CurvedAnimation(parent: controller, curve: Curves.easeIn);
    }
  
    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
          child: Container(
            child: FadeTransition(
              opacity: curve,
              child: FlutterLogo(
                size: 100.0,
              )
            )
          )
        ),
        floatingActionButton: FloatingActionButton(
          tooltip: 'Fade',
          child: Icon(Icons.brush),
          onPressed: () {
            controller.forward();
          },
        ),
      );
    }
  
    @override
    dispose() {
      controller.dispose();
      super.dispose();
    }
  }
  ```

  

### Canvas

- CustomPaint와 CustomPainter을 이용하여 그리게 된다.

- 도형 그려서 해당 포인트에 집어넣는 예제

  ```dart
  class SignaturePainter extends CustomPainter {
    SignaturePainter(this.points);
  
    final List<Offset> points;
  
    void paint(Canvas canvas, Size size) {
      var paint = Paint()
        ..color = Colors.black
        ..strokeCap = StrokeCap.round
        ..strokeWidth = 5.0;
      for (int i = 0; i < points.length - 1; i++) {
        if (points[i] != null && points[i + 1] != null)
          canvas.drawLine(points[i], points[i + 1], paint);
      }
    }
  
    bool shouldRepaint(SignaturePainter other) => other.points != points;
  }
  
  class Signature extends StatefulWidget {
    SignatureState createState() => SignatureState();
  }
  
  class SignatureState extends State<Signature> {
  
    List<Offset> _points = <Offset>[];
  
    Widget build(BuildContext context) {
      return GestureDetector(
        onPanUpdate: (DragUpdateDetails details) {
          setState(() {
            RenderBox referenceBox = context.findRenderObject();
            Offset localPosition =
            referenceBox.globalToLocal(details.globalPosition);
            _points = List.from(_points)..add(localPosition);
          });
        },
        onPanEnd: (DragEndDetails details) => _points.add(null),
        child: CustomPaint(painter: SignaturePainter(_points), size: Size.infinite),
      );
    }
  }
  ```

  

### Navigation

```dart
//선언은 이렇게
void main() {
  runApp(CupertinoApp(
    home: MyAppHome(), // becomes the route named '/'
    routes: <String, WidgetBuilder> {
      '/a': (BuildContext context) => MyPage(title: 'page A'),
      '/b': (BuildContext context) => MyPage(title: 'page B'),
      '/c': (BuildContext context) => MyPage(title: 'page C'),
    },
  ));
}

//화면 이동은 이렇게
Navigator.of(context).pushNamed('/b');

//화면간의 값 전달은 이렇게 한다.
Map coordinates = await Navigator.of(context).pushNamed('/location');
//로케이션 뷰에서 다음을 불렀을 때
Navigator.of(context).pop({"lat":43.821757,"long":-79.226392});
//coordinates으로 값이 들어오게된다.
```



### 통신

- 다음은 api를 통해 값을 받아온 후 뷰를 업데이트 시켜주는 예제이다.

```dart
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(SampleApp());
}

class SampleApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sample App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SampleAppPage(),
    );
  }
}

class SampleAppPage extends StatefulWidget {
  SampleAppPage({Key key}) : super(key: key);

  @override
  _SampleAppPageState createState() => _SampleAppPageState();
}

class _SampleAppPageState extends State<SampleAppPage> {
  List widgets = [];

  @override
  void initState() {
    super.initState();

    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sample App"),
      ),
      body: ListView.builder(
          itemCount: widgets.length,
          itemBuilder: (BuildContext context, int position) {
            return getRow(position);
          }));
  }

  Widget getRow(int i) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Text("Row ${widgets[i]["title"]}")
    );
  }

  loadData() async {
    String dataURL = "https://jsonplaceholder.typicode.com/posts";
    http.Response response = await http.get(dataURL);
    setState(() {
      widgets = json.decode(response.body);
    });
  }
}
```



ListView

- 테이블뷰, 콜렉션뷰 같은 것

  ```dart
  class _SampleAppPageState extends State<SampleAppPage> {
    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Sample App"),
        ),
        body: ListView(children: _getListData()),
      );
    }
  
    _getListData() {
      List<Widget> widgets = [];
      for (int i = 0; i < 100; i++) {
        widgets.add(GestureDetector(
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Text("Row $i"),
          ),
          onTap: () {
            print('row tapped');
          },
        ));
      }
      return widgets;
    }
  }
  ```

- ListView.Builder를 이용한 동적 셀 추가(setState를 타면 리스트뷰 자체가 업데이트 되므로 효과적이지 않다 그에대한 대처 방법으로 ListView.Builder를 이용)

  ```dart
  class _SampleAppPageState extends State<SampleAppPage> {
    List widgets = [];
  
    @override
    void initState() {
      super.initState();
      for (int i = 0; i < 100; i++) {
        widgets.add(getRow(i));
      }
    }
  
    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Sample App"),
        ),
        body: ListView.builder(
          itemCount: widgets.length,
          itemBuilder: (BuildContext context, int position) {
            return getRow(position);
          },
        ),
      );
    }
  
    Widget getRow(int i) {
      return GestureDetector(
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Text("Row $i"),
        ),
        onTap: () {
          setState(() {
            widgets.add(getRow(widgets.length + 1));
            print('row $i');
          });
        },
      );
    }
  }
  ```

  

# Web App

```sh
flutter run -d chrome	# 크롬으로 실행하기
flutter build web	# 릴리즈 빌드하기
flutter build web --web-renderer canvaskit --release
flutter run --release	# 릴리즈 실행

# iOS 시뮬로 실행하기
open -a Simulator
flutter run
```

