# Typescript



#### 기본 타입

```typescript
// number
const integer: number = 1;

// string
const myName: string = 'Lee Jin';

// boolean
const isTypeScriptAwesome: boolean = true;

// array
const myArray: Array<number> = [1, 2 ,3, 4, 5, 6];
const myArray2: number[] = [1, 2, 3, 4, 5, 6];

// 튜플 - 튜플 타입 변수는 정확히 명시된 개수 만큼의 원소만을 가질 수 있다.
const myArray3: [string, number] = ['홍길동', 145];
```



#### 사용자 정의 타입

```typescript
type UUID = string;
type Human = {
    name: string;
    age: number;
    address?: string; // ?는 해당 속성이 존재하지 않을 수도 있다는 것을 명시
};

function getHuman(uuid: UUID): Human {
    /* 함수 본문 */
}
```



#### 인터페이스

```typescript
interface Life {
  name: string;
  readonly sex: string; // 읽기 전용 속성
  weight?: number; // 선택 속성 
}

const cat: Life = { name: '길냥이', sex: 'male' }; // ok

// error TS2540: Cannot assign to 'sex' because it is a constant or a read-only property.
cat.sex = 'female';

interface GetLife {
    (uuid: UUID): Life;
}

const getLife: GetLife = function (u) {
    const dog: Life = { name: '홍길동', sex: 'female', weight: 30 };
    return dog;
}
```



#### 클래스

```typescript
class Base {
    static num: number = 0; // 스태틱 변수
    
    // 스태틱 메소드
    static incrementNum() {
        Base.num += 1;
    }

    baseProps: number; // 클래스 변수
    
    // 생성자
    constructor() {
        this.baseProps = 123;
    }
}

class MyCustom extends Base {
    private extendsProps: number = 0;
    constructor() {
        super();
        this.extendsProps = 456;
    }
}

const myCustom: MyCustom = new MyCustom();
console.log(Base.num); // 0

console.log(myCustom.baseProps); // 123
console.log(myCustom.extendsProps) // 456
```



#### 반복문

```typescript
let arr = [10, 20, 30, 40];

for (var val of arr) {
  console.log(val); // prints values: 10, 20, 30, 40
}

for (var index in arr) {
  console.log(index); // prints indexes: 0, 1, 2, 3

  console.log(arr[index]); // prints elements: 10, 20, 30, 40
}

// of랑 in의 차이는 인덱스 유무
```

