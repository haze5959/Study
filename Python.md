# Python

참고문서: https://wikidocs.net/4307 (점프 투 파이썬)



###  if / for

```python
# for if 문 예제
languages = ['python', 'perl', 'c', 'java']
for lang in languages:
    if lang in ['python', 'perl']:
        print("%6s need interpreter" % lang)
    elif lang in ['c', 'java']:
        print("%6s need compiler" % lang)
    else:
        print("should not reach here")
        
# 단순 빈복문
for i in range(2,10):
```



### **,  // 연산자

```python
3 ** 4	# 제곱 연산자
>> 81

7 / 4 # 1.75
7 // 4 # 1
```



### 문자열 연산

```python
# 문자열 더하기
head = "Python"
tail = " is fun!"
head + tail # 'Python is fun!'

# 문자열 곱하기
a = "python"
a * 2 # 'pythonpython'

# 문자열 길이 구하기
a = "Life is too short"
len(a) # 17

# 문자열 인덱싱
a = "Life is too short, You need Python"
a[0] # 'L'
a[-1] # 'n' 뒤에서부터 가져옴
a[0:4] # 'Life' == a[:4]

# 문자열 포매팅
"I eat %d apples." % 3 # 'I eat 3 apples.'
# 그냥 %s로 해도 다 된다!

# 향상된 포매팅
"I eat {0} apples".format(3) # 'I eat 3 apples'
"I ate {0} apples. so I was sick for {1} days.".format(number, day)
"I ate {number} apples. so I was sick for {day} days.".format(number=10, day=3)
# 'I ate 10 apples. so I was sick for three days.'

# 문자 개수 세기
a = "hobby"
a.count('b') # 2

# 위치 알려주기
a = "Python is the best choice"
a.find('b') # 14
a.find('k') # -1 존재하지 않을 경우

# 문자열 삽입
",".join('abcd') # 'a,b,c,d'	== ",".join(['a', 'b', 'c', 'd'])

# 공백 지우기
a.strip()

# 문자열 바꾸기
a = "Life is too short"
a.replace("Life", "Your leg") # 'Your leg is too short'

# 문자열 나누기
a = "Life is too short"
a.split() # ['Life', 'is', 'too', 'short']
b = "a:b:c:d"
b.split(':') # ['a', 'b', 'c', 'd']
```



### 배열

```python
a = [1, 2, 3]
b = [4, 5, 6]
a + b # [1, 2, 3, 4, 5, 6]
a * 3 # [1, 2, 3, 1, 2, 3, 1, 2, 3]

# 길이 구하기
len(a) # 3

# 요소 삭제
del a[1] # [1, 3]
del a[1:] # [1]
a = [1, 2, 3, 1, 2, 3]
a.remove(3)	# [1, 2, 1, 2, 3] 3번째 삭제

# 요소 추가
a.append(4) # [1, 2, 3, 4]

# 요소 삽입
a.insert(0, 4) # [4, 1, 2, 3]

# 요소 pop
a = [1,2,3]
a.pop() # 3
a # [1, 2]
a.pop(1) # 1
a # [2]

# 정렬
.sort() # 숫자 문자 정렬 가능
.reverse() # 순서 뒤집기

# 값 위치 찾기
a = [1,2,3]
a.index(3) # 2

# 확장하기
a = [1,2,3]
a.extend([4,5]) # [1, 2, 3, 4, 5]
```



### 타입 케스팅

```python
str(123) # "123"
```



### 딕셔너리

```python
a = {'name': 'pey', 'phone': '0119993323', 'birth': '1118'}
list(a.keys()) # ['name', 'phone', 'birth']
for k in a.keys(): 
  print(k)
 
a.values()	# 값 리스트

# 키 밸류 쌍 얻기
a.items() # [('name', 'pey'), ('phone', '0119993323'), ('birth', '1118')]

# 전부 지우기
a.clear()
```



### 함수

```python
def add(a, b): 
    return a + b
  
# 입력값이 여러개일 경우
def add_many(*args): 
     result = 0 
     for i in args: 
         result = result + i 
     return result 
  
# 초기값 미리 설정하기 가능
def say_myself(name, old, man=True): 
 
# 함수 내에서 전역변수 사용하기
result = 0
def add(num):
    global result
    result += num
    return result

print(add(3))	# 3
print(add(4))	# 7
```



### 클래스

```python
class FourCal:
  def setdata(self, first, second):
    self.first = first
    self.second = second
    
  def add(self):
    result = self.first + self.second
    return result
  
a = FourCal()
a.setdata(4, 2)
print(a.add()) # 6

# 여기서 객체를 생성한 다음에 바로 setdata없이 add를 호출하게 되면 에러가 발생한다
# 생성자를 추가하면 해결된다
def __init__(self, first, second):
  self.first = first
  self.second = second
  
# 클래스 상속
class MoreFourCal(FourCal):
```



### 모듈화

```python
# mod1.py ################################
def add(a, b):
    return a + b

def sub(a, b): 
    return a-b
  
##########################################

from mod1 import add, sub	# 이렇게하면 모듈 이름없이 바로 접근할 수 있다.
from mod1 import *
add(3, 4) # 7

# if __name__ == "__main__" 을 사용하면 해당 모듈을 직접 실행할때만 타게된다
```