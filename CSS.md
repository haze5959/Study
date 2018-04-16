# CSS

### block 요소

```
div
h1~h6
ul li
ol li
dl dt dd	//알아보기
fieldset legend	//알아보기
table
```

### inline 요소

```
span
strong
em
i
img
input
label
button
a
select
textarea
```

### HTML5 요소

```
article
section
header
footer
aside
nav
hgroup
figure
svg
```

### 테이블

```
<table>
	<colgroup>	//스타일 지정?
		<col>
		<col/>
	<colgroup/>
	<thead>
	<tr>
		<th>
		<th/>
	<tr/>
	<tfoot>
	<tfoot/>
	<tbody>
	<tbody>
<table/>
```

### 자주 쓰이는 거

```
padding - border - margin

display : none, block, inline, inline-block(width height padding 값을 넣고 싶을 때)

position : 
relative 기본적인 흐름 가운데에 위치한 후 탑 레프트 속성에 의해 배치 
absolute 문서의 기본 흐름을 완전히 벗어나 배치 / 부모중 릴레이티브 된 것에서 좌표 설정
fixed 앱솔루트와 유사하나 브라우저 창을 중심으로 고정

float : left right 컨텐츠를 왼쪽 오른쪽에 배치

clear : left right both 플로트를 해제

background : repeat, image color

border : border-style.solid dotted dashed
	border-width -color -radius

font : font-family -weight.bold -size.px.em

text-align vertical-align
text-indent
box-sizing
box text-shadow

//텍스트 상자에서 글자가 넘칠 때 어떻게 할지
overflow: scroll;	//hidden	//visible
```

### 선택자

```
A > B {} 직계 자손
A + B {} 형제
A ~ N {} 모든 형제 다

A:first-child last-child
	nth-child(n)
```

### css 기능 셀럭터

```
/* unvisited link */
a:link {
    color: green;
}

/* visited link */
a:visited {
    color: green;
}

/* mouse over link */
a:hover {
    color: red;
}

/* selected link */
a:active {
    color: yellow;
}

//스판을 호버하면 디브가 display: block; 됨
span:hover + div {
    display: block;
}
```



### 폰트 만들기

```
/* 숫자 아이콘 */
.fa-number-1:before {
    border: 1px solid transparent;
    border-radius: 3px;
    border-color: #000;
    padding:0px 3px 0px 3px;
    content: "1";
}

.fa-number-2:before {
    border: 1px solid transparent;
    border-radius: 3px;
    border-color: #000;
    padding:0px 3px 0px 3px;
    content: "2";
}
```

![](https://github.com/haze5959/Study/blob/master/files/vmax.png)

![](https://github.com/haze5959/Study/blob/master/files/vmin.png)
