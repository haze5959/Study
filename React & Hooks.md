# Basic Hooks

## useState()

```js
// age가 1씩 증가하는 버튼 예제
import React, { useState } from "react";

function Sample() {
  const [age, setAge] = useState(0);

  return (
    <div>
      <p>You clicked {age} times</p>
      <button onClick={() => setAge(age + 1)}>
        Click me
      </button>
      // 이것도 가능
      <button onClick={() => setAge((prevAge) => prevAge + 1)}>
        Click me
      </button>
    </div>
  );
}

// 함수로 state 초기화하기
const StateFromFn = () => {
  const [token] = useState(() => {
    let token = window.localStorage.getItem("my-token");
    return token || "default#-token#";
  });

  return <div>Token is {token}</div>;
};
```

## useEffect()

```js
// document.title 을 매번 업데이트 시키는 예제
import React, { useEffect, useState } from "react";
function Sample() {
  const [rate, setRate] = useState(0);
  useEffect(() => {
    document.title = `You clicked ${rate} times`;
  });
  return (
    <div>
      <p>Hey!! you have clicked {rate} times</p>
      <button onClick={() => setRate(rate + 1)}>
        Click
      </button>
    </div>
  );
}

// 이벤트 리스너 메모리 정리하기
const EffectCleanup = () => {
  useEffect(() => {
    const clicked = () => console.log("window clicked");
    window.addEventListener("click", clicked);

    // return a clean-up function
    return () => {
      window.removeEventListener("click", clicked);
    };
  }, []);

  return (
    <div>
      When you click the window you'll find a message logged to the console
    </div>
  );
};
```

## useContext()

여러 컴포넌트에 데이터를 공유하기위한 목적!

```js
const ThemeContext = React.createContext("light");

const Display = () => {
  const theme = useContext(ThemeContext);
  return (
    <div
      style={{
        background: theme === "dark" ? "black" : "papayawhip",
        color: theme === "dark" ? "white" : "palevioletred",
        width: "100%",
        minHeight: "200px",
      }}
    >
      {"The theme here is " + theme}
    </div>
  );
};
```

# Additional Hooks

## useReducer()

useState로 처리하기 좀 복잡할 때 이용
```js
const initialState = { width: 15 };

const reducer = (state, action) => {
  switch (action) {
    case "plus":
      return { width: state.width + 15 };
    case "minus":
      return { width: Math.max(state.width - 15, 2) };
    default:
      throw new Error("what's going on?");
  }
};

const Bar = () => {
  const [state, dispatch] = useReducer(reducer, initialState);
  return (
    <>
      <div style={{ background: "teal", height: "30px", width: state.width }}>
      </div>
      <div style={{ marginTop: "3rem" }}>
        <button onClick={() => dispatch("plus")}>Increase bar size</button>
        <button onClick={() => dispatch("minus")}>Decrease bar size</button>
      </div>
    </>
  );
};
```

## useCallback() & useMemo() & memo

리랜더링을 회피하기 위한 방법

```js
const App = () => {
  const [age, setAge] = useState(99);
  const handleClick = () => setAge(age + 1);
  const someValue = "someValue";
  const doSomething = useCallback(() => {
    return someValue;
  }, [someValue]);

  return (
    <div>
      <Age age={age} handleClick={handleClick} />
      <Instructions doSomething={doSomething} />
    </div>
  );
};

const Age = ({ age, handleClick }) => {
  return (
    <div>
      <div style={{ border: "2px", background: "papayawhip", padding: "1rem" }}>
        Today I am {age} Years of Age
      </div>
      <pre>- click the button below 👇</pre>
      <button onClick={handleClick}>Get older!</button>
    </div>
  );
};

const Instructions = React.memo((props) => {
  return (
    <div style={{ background: "black", color: "yellow", padding: "1rem" }}>
      <p>Follow the instructions above as closely as possible</p>
    </div>
  );
});
```

## useRef()

Element나 값을 참조해서 뭔가 처리할때 사용됨

```js
// 텍스트필드를 참조해서 값을 보내는 예제
const AccessDOM = () => {
  const textAreaEl = useRef(null);
  const handleBtnClick = () => {
    textAreaEl.current.value =
      "The is the story of your life. You are an human being, and you're on a website about React Hooks";
    textAreaEl.current.focus();
  };
  return (
    <section style={{ textAlign: "center" }}>
      <div>
        <button onClick={handleBtnClick}>Focus and Populate Text Field</button>
      </div>
      <label
        htmlFor="story"
        style={{
          display: "block",
          background: "olive",
          margin: "1em",
          padding: "1em",
        }}
      >
        The input box below will be focused and populated with some text
        (imperatively) upon clicking the button above.
      </label>
      <textarea ref={textAreaEl} id="story" rows="5" cols="33" />
    </section>
  );
};
```

## useLayoutEffect()

useEffect랑 호출 시점빼고 다 똑같다. useLayoutEffect는 DOM 업데이트 되기 전 호출

***

# 실사용 예제

```js
const fetchData = () => {
  const stringifyData = (data) => JSON.stringify(data, null, 2);
  const initialData = stringifyData({ data: null });
  const loadingData = stringifyData({ data: "loading..." });
  const [data, setData] = useState(initialData);

  const [gender, setGender] = useState("female");
  const [loading, setLoading] = useState(false);

  useEffect(
    () => {
      const fetchData = () => {
        setLoading(true);
        const uri = "https://randomuser.me/api/?gender=" + gender;
        fetch(uri)
          .then((res) => res.json())
          .then(({ results }) => {
            setLoading(false);
            const { name, gender, dob } = results[0];
            const dataVal = stringifyData({
              ...name,
              gender,
              age: dob.age,
            });
            setData(dataVal);
          });
      };

      fetchData();
    },
    [gender],
  );

  return (
    <>
      <button
        onClick={() => setGender("male")}
        style={{ outline: gender === "male" ? "1px solid" : 0 }}
      >
        Fetch Male User
      </button>
      <button
        onClick={() => setGender("female")}
        style={{ outline: gender === "female" ? "1px solid" : 0 }}
      >
        Fetch Female User
      </button>

      <section>
        {loading ? <pre>{loadingData}</pre> : <pre>{data}</pre>}
      </section>
    </>
  );
};
```
