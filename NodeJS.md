# NodeJs

## Socket

- 이벤트 주고 받기

  ```
  //이벤트 보내기 
  socket.emit('이벤트명',{메세지});

  //이벤트 받기 
  socket.on('이벤트명',function(data){ });

  //나를 제외한 다른 클라이언트들에게 이벤트 보내기 
  socket.broadcast.emit('이벤트명',{메세지});

  //내 소켓이 아닌 다른 특정 소켓에게 이벤트를 보내는 방법
  ?io.sockets(socket_id).emit('이벤트명',function(data){ });
  ```

  ​

- 소켓에 데이터 바인딩

  ```
  socket.set(‘key’, ‘value’,function() {});
  socket.get(‘key’, function(err,value) {});
  socket.del(‘key’, function(err,value) {});
  ```

  ​

- 룸 처리

  ```
  socket.join(‘roon name’)
  socket.leave(‘roon name’)

  //특정 방에 글 싸지르기
  io.sockets.in(‘roon name’).emit(‘event’,message)
  ```

  ​

- 소켓 메니저

```
//현재 생성된 룸 목록 리턴
io.sockets.manager.rooms

//특정 룸 안의 클라이언트 리턴
io.sockets.clients(‘roon name’)
```




간단 소개
http://bcho.tistory.com/899

http://infodbbase.tistory.com/89

http://blog.puding.kr/156

http://blog.naver.com/PostView.nhn?blogId=azure0777&logNo=220619415390

http://mudchobo.tistory.com/540



## Promise

http://programmingsummaries.tistory.com/325

- Promise 선언

```
var _promise = function (param) {
	return new Promise(function (resolve, reject) {
	
	// 비동기를 표현하기 위해 setTimeout 함수를 사용 
	window.setTimeout(function () {

		// 파라메터가 참이면, 
		if (param) {

			// 해결됨 
			resolve("해결 완료");
		}

		// 파라메터가 거짓이면, 
		else {

			// 실패 
			reject(Error("실패!!"));
		}
	}, 3000);
});

};

//Promise 실행
_promise(true)
.then(function (text) {
	// 성공시
	console.log(text);
}, function (error) {
	// 실패시 
	console.error(error);
});


```



- 중간에 에러가 발생했다면 catch

```
_promise(true)
	.then(JSON.parse)
	.catch(function () { 
		window.alert('체이닝 중간에 에러가!!');
	})
	.then(function (text) {
		console.log(text);
	});
```

- PromiseAl

```
Promise.all([promise1, promise2]).then(function (values) {
	console.log("모두 완료됨", values);
});
```



- 이런것이다요

```
pending
아직 약속을 수행 중인 상태(fulfilled 혹은 reject가 되기 전)이다.

fulfilled
약속이 지켜진 상태이다.

rejected
약속이 어떤 이유에서 못 지켜진 상태이다.

settled
약속이 지켜졌든 안지켜졌든 일단 결론이 난 상태이다.
```

