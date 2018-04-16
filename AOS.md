# AOS

## Manifest

- 세로 고정

```
android:screenOrientation="portrait" 
```

- 가로 고정

```
android:screenOrientation="landscape"
```

- 메타데이터 테그 사용하기

  - 선언

    ```
    <meta-data name="abc" value="abc" />
    ```

  - 사용

    ```
    각종 태그에 @abc 이렇게 사용
    ```

    ​

- Activity에서 불러오기

```
ApplicationInfo appInfo = getPackageManager().getApplicationInfo(this.getPackageName(), PackageManager.GET_META_DATA);
Bundle aBundle = appInfo.metaData;
String aValue = aBundle.getString("abc");
```



## Activity

- 액티비티 사이 값 전달 및 콜백

```
Intent intentSubActivity = new Intent(MainActivity.this, SubActivity.class);
intentSubActivity.putExtra("textToDeliver", "메인에서 전달한 값");
```

- 받을 때

```
Intent getData = getIntent();
String metroName =getData.getStringExtra("metroName");
```

- 콜백까지!  subAcitivity가 종료되면 onActivityResult 메소드가 실행!!

```
startActivityForResult(intentSubActivity, CALLBACK_CODE);
//CALLBACK_CODE는 자기가 임의로 설정한 int이고 onActivityResult의 requestCode 파라미터로 들어옴
```

- Intent 종류

```
ACTION_MAIN - 작업은 이것이 주요 진입 지점이며 어느 인텐트 데이터도 기대하지 않는다는 것
CATEGORY_LAUNCHER  - 실행을 이걸로 하겠다
ex)구글 검색
Intent intent = new Intent();
intent.setAction(Intent.ACTION_WEB_SEARCH);
intent.putExtra(SearchManager.QUERY, "searchString");
```



## Application

//manifest 추가 후 인스턴스 따와서 사용
android:name=".applicationClss_Study"
//이렇게 사용
applicationClss_Study ApplicationClassStudy = (applicationClss_Study) getApplication();



## Fragment

- 초기 선언

```
FragmentManager fragmentManager = getFragmentManager();
FragmentTransaction fragmentTransaction = null;
```

- 시작

```
fragmentTransaction = fragmentManager.beginTransaction();
Bundle args1 = new Bundle();	//fragment는 번들로 값 이동
```

- add, replace, remove

```
fragmentTransaction.replace(R.id.FragmentLayout, fragment);
fragmentTransaction.commit();
```

- 화면 생성

```
final View view = inflater.inflate(R.layout.fragment_view, container, false);
```

- veiw 접근

```
TextView textView = (TextView) view.findViewById(R.id.textView2);
```



## Service

```
//manifest.xml
<service
 android:name=".serviceClass_Study"
 android:enabled="true"
 android:exported="true">
</service>

//알아봐라
bindService(intent, mConnection, Context.BIND_AUTO_CREATE);

//바인더
public IBinder onBind(Intent intent) {
        return null;
    }
==>bindService()로 호출되었을 때 사용되는 메서드
	서비스와 컴포넌트 사이의 인터페이스(상호작용하는데 필요한 변수)
	unbindService()가 호출되면 컴포넌트와의 연결이 끊키고 서비스에 연결된 컴포넌트가 하나도 남지
	않았다면 안드로이드가 서비스를 소멸시킨다.

//IBinder는 서비스에 값을 보낼 때 사용 ex)IBinder.send(msg) 이런식
```



- veiw 동적 생성

```
Button bt = new Button(view.getContext());
bt.setText("fragment" + (i) + "로 이동");
bt.setId(i + 1);
(여기에 리스너 등록)
btLayout.addView(bt);	//레이아웃에 생성한 뷰 넣기
```



## 쓰래드

 - 안드로이드에서 제공하는 쓰레드 클래스에는 AsyncTask가 있다. 사용할 쓰레드 클래스는 이것을 extends 해서 선언하도록하며 아래의 메소드들을 override하여 사용하게 된다.
    onPreExecute() : 쓰레드가 실행되기 이전에 실행되는 메소드
    doInBackground(Params... params) : 쓰레드로 실행할 부분
    onProgressUpdate(Progress... values) : publishProgress(Progress... values) 메소드에 의해 invoke된다. 아무때나 콜 가능
    onPostExecute(Result result) : 쓰레드가 완료되면 실행되는 메소드.
      AsyncTask는 generic이기 때문에 extends 시 3개의 generic type을 붙여주게 되는데, 첫번째가 doInBackground() 에서 사용할 Params, 두번째가 onProgressUpdate()에서 사용할 Progress, 세번째가 onPostExecute()에서 사용할 Result의 type이다. 

![](https://github.com/haze5959/Study/blob/master/files/AOS/1. 쓰레드의 스케줄링과 관련된 메서드.jpg)

![](https://github.com/haze5959/Study/blob/master/files/AOS/2. 쓰레드의 상태.jpg)



## Activity Flag

- 사용 방법
  intent.addFlag(Intent.FLAG_ACTIVITY_REORDER_TO_FRONT);


- FLAG_ACTIVITY_CLEAR_WHEN_TASK_RESET

  플래그가 사용된 엑티비티부터 최상단의 엑티비티까지 모두를 삭제합니다. 

  리셋은 FLAG_ACTIVITY_RESET_TASK_IF_NEEDED 플래그에 의해 실행

- FLAG_ACTIVITY_RESET_TASK_IF_NEEDED

  적절한 경우라면 태스크를 리셋 

- FLAG_ACTIVITY_CLEAR_TOP

  만약에 엑티비티스택에 호출하려는 엑티비티의 인스턴스가 이미 존재하고 있을 경우에 
  새로운 인스턴스를 생성하는 것 대신에 존재하고 있는 엑티비티를 포그라운드로 가져옵니다. 
  그리고 엑티비티스택의 최상단 엑티비티부터 포그라운드로 가져올 엑티비티까지의 모든 엑티비티를 삭제합니다.

- FLAG_ACTIVITY_EXCLUDE_FROM_RECENTS

  엑티비티가 새로운 태스크안에서 실행될때에 일반적으로 타겟 엑티비티는 ‘최근 실행된 엑티비티’ 목록에 표시가 됩니다. 
  (이 목록은 홈버튼을 꾹 누르고 있으면 뜹니다) 이 플래그를 사용하여 실행된 엑티비티는 최근실행된엑티비티 목록에서 나타나지 않습니다.

- FLAG_ACTIVITY_FORWARD_RESULT

  엑티비티가 A,B,C 순서로 생성되었을 때, C -> A로 콜백 받을 때 사용

- FLAG_ACTIVITY_NEW_TASK

  새로운 태스크를 생성하여 그 태스크안에 엑티비티를 추가
  단, 기존에 존재하는 태스크들중에 생성하려는 엑티비티와 동일한 affinity를 가지고 있는 태스크가 있다면 그곳으로 새 엑티비티가 들어가게됩니다.

- FLAG_ACTIVITY_MULTIPLE_TASK

  FLAG_ACTIVITY_NEW_TASK와 함께 사용하지 않으면 아무런 효과가 없는 플래그

- FLAG_ACTIVITY_NO_ANIMATION

  엑티비티가 스크린에 등장할시에 사용될 수 있는 다양한 애니메이션 효과를 사용하지 않습니다.

- FLAG_ACTIVITY_NO_HISTORY
  새로 생성되는 엑티비티는 어떤 태스크에도 보존되지 않게 됩니다. 
  예를 들면 로딩화면과 같이 다시 돌아오는것이 의미가 없는 화면이라면 
  이 플래그를 사용하여 태스크에 남기지 않고 자동적으로 화면이 넘어감과 동시에 제거

- FLAG_ACTIVITY_NO_USER_ACTION
  자동적으로 엑티비티가 호출될 경우에 자동 호출되는 onUserLeaveHint()가 실행되는것을 차단합니다. onUserLeaveHint() 콜백 메서드는 어플리케이션 사용중에 전화가 온다거나 하는등의 사용자의 액션없이 
  엑티비티가 실행/전환되는 경우에 호출되는 메서드

- FLAG_ACTIVITY_REORDER_TO_FRONT
  호출하려던 엑티비티가 이미 엑티비티 스택에 존재하고 있다면 이 플래그를 사용하여 스택에 
  존재하는 엑티비티를 최상위로 끌어올려줍니다. 결과적으로 엑티비티 스택의 순서가 재정렬되는 효과

- FLAG_ACTIVITY_SINGLE_TOP
  엑티비티를 호출할 경우 호출된 엑티비티가 현재 태스크의 최상단에 존재하고 있었다면 
  새로운 인스턴스를 생성하지 않습니다. 

- 자동 설정 flag

  - FLAG_ACTIVITY_BROUGHT_TO_FRONT
    엑티비티의 실행모드가 singleTask이고 이미 엑티비티스택에 존재하고 있는 상태라고 가정을 할 때 
    다시 그 엑티비티가 호출되고 재활용 되었을 경우 자동으로 설정
  - FLAG_ACTIVITY_LAUNCHED_FROM_HISTORY
    홈스크린화면에서 홈버튼을 롱클릭함으로써 뜨게 되는 “최근실행목록”을 통해 실행되었을 경우 
    자동으로 설정



## Drawable

##### Bitmap Drawable

```
<bitmap
    xmlns:android="http://schemas.android.com/apk/res/android"
    android:src="@[package:]drawable/drawable_resource"
    android:antialias=["true" | "false"]
    android:dither=["true" | "false"]
    android:filter=["true" | "false"]
    android:gravity=["top" | "bottom" | "left" | "right" | "center_vertical" |
                      "fill_vertical" | "center_horizontal" | "fill_horizontal" |
                      "center" | "fill" | "clip_vertical" | "clip_horizontal"]
    android:tileMode=["disabled" | "clamp" | "repeat" | "mirror"] />

//사용할 때 반복 요소로 사용 가능
android:tileMode="repeat"
```



##### layer-list

```
<layer-list xmlns:android="http://schemas.android.com/apk/res/android">
    <item>
      <bitmap android:src="@drawable/android_red"
        android:gravity="center" />
    </item>
    <item android:top="10dp" android:left="10dp">
      <bitmap android:src="@drawable/android_green"
        android:gravity="center" />
    </item>
    <item android:top="20dp" android:left="20dp">
      <bitmap android:src="@drawable/android_blue"
        android:gravity="center" />
    </item>
</layer-list>
```



##### selector

```
// * object 의 state 에 따른 drawable mapping 을 관리하는 list.

<selector xmlns:android="http://schemas.android.com/apk/res/android">
    <item android:state_pressed="true"
          android:drawable="@drawable/button_pressed" /> <!-- pressed -->
    <item android:state_focused="true"
          android:drawable="@drawable/button_focused" /> <!-- focused -->
    <item android:state_hovered="true"
          android:drawable="@drawable/button_focused" /> <!-- hovered -->
    <item android:drawable="@drawable/button_normal" /> <!-- default -->
</selector>
```



##### Transition Drawable

```
//* 2개의 drawable 을 설정하고 fade 효과를 줄 수 있는 drawable 이다. startTransition() 과 
//reverseTransition() 을 통해 transition 효과를 준다.

<transition xmlns:android="http://schemas.android.com/apk/res/android">
    <item android:drawable="@drawable/on" />
    <item android:drawable="@drawable/off" />
</transition>
```



##### Scale Drawable

```
<scale
    xmlns:android="http://schemas.android.com/apk/res/android"
    android:drawable="@drawable/drawable_resource"
    android:scaleGravity=["top" | "bottom" | "left" | "right" | "center_vertical" |
                          "fill_vertical" | "center_horizontal" | "fill_horizontal" |
                          "center" | "fill" | "clip_vertical" | "clip_horizontal"]
    android:scaleHeight="percentage"
    android:scaleWidth="percentage" />
```



##### Shape Drawable

```
<shape
    xmlns:android="http://schemas.android.com/apk/res/android"
    android:shape=["rectangle" | "oval" | "line" | "ring"] >
    <corners
        android:radius="integer"
        android:topLeftRadius="integer"
        android:topRightRadius="integer"
        android:bottomLeftRadius="integer"
        android:bottomRightRadius="integer" />
    <gradient
        android:angle="integer"
        android:centerX="integer"
        android:centerY="integer"
        android:centerColor="integer"
        android:endColor="color"
        android:gradientRadius="integer"
        android:startColor="color"
        android:type=["linear" | "radial" | "sweep"]
        android:useLevel=["true" | "false"] />
    <padding
        android:left="integer"
        android:top="integer"
        android:right="integer"
        android:bottom="integer" />
    <size
        android:width="integer"
        android:height="integer" />
    <solid
        android:color="color" />
    <stroke
        android:width="integer"
        android:color="color"
        android:dashWidth="integer"
        android:dashGap="integer" />
</shape>
```

