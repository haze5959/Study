# Redis

싱글스레드라서 막 쓰면 안된다.



설치 유무 판별

redis-cli ping

### Data type



- Strings

- ```
  set "test_strings" 1	>> OK
  get "test_strings"		>> "1"
  incr "test_strings"		>> (integer) 2
  get "test_strings"		>> "2"
  ```



- Lists

- ```
  lpush "test_lists" 1
  lpush test_lists 2
  lrange test_lists 0 -1	//값을 조회 이때 -1은 모두 가져오라는 뜻
  >>  "2" "1"
  rpush test_lists 3		//left right
  lrange test_lists 0 -1
  >>  "2" "1" "3"
  rpop test_lists			//POP
  lrange test_lists 0 -1
  >>  "2" "1"
  ```



- Sets

- ```
  List와 다른점은 중복이 없는 것 뿐
  ```



- Hashes

- ```
  key/value 목록을 값으로 가진다.
  hset htest username hi		>> 1
  hset htest userpwd asdf		>> 1
  hget htest username			>> "hi"
  hgetall htest				>> "username" "hi" "userpwd" "asdf"
  
  //hget htest temp	일 때 값이 없다면 nil 반환
  ```



그 밖에 Sorted sets이나 bitmaps 형이 있다...



Node 사용법 https://github.com/NodeRedis/node_redis