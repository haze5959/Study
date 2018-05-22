# Promise

#### 프로미스란 이런식으로 채택(resolve)하거나 거절(reject)로 콜백지옥을 없애기 쉽게 한 것

```typescript
function readFileAsync(filename: string): Promise<any> {
    return new Promise((resolve,reject) => {
        fs.readFile(filename,(err,result) => {
            if (err) reject(err);
            else resolve(result);
        });
    });
}

readFileAsync('good.json')
    .then(function (val) { console.log(val); })
    .catch(function (err) {
        console.log('good.json error', err.message); // never called
    });
```



#### 이거면 이해 갈거다

```typescript
// an async function to simulate loading an item from some server
function loadItem(id: number): Promise<{ id: number }> {
    return new Promise((resolve) => {
        console.log('loading item', id);
        setTimeout(() => { // simulate a server delay
            resolve({ id: id });
        }, 1000);
    });
}

// Chaining
let item1, item2;
loadItem(1)
    .then((res) => {
        item1 = res;
        return loadItem(2);
    })
    .then((res) => {
        item2 = res;
        console.log('done');
    }); // overall time will be around 2s

// Parallel
Promise.all([loadItem(1), loadItem(2)])
    .then((res) => {
        [item1, item2] = res;
        console.log('done');
    }); // overall time will be around 1s
```



#### 빠른 사람이 승리~

```typescript
var task1 = new Promise(function(resolve, reject) {
    setTimeout(resolve, 1000, 'one');
});
var task2 = new Promise(function(resolve, reject) {
    setTimeout(resolve, 2000, 'two');
});

Promise.race([task1, task2]).then(function(value) {
  console.log(value); // "one"
  // Both resolve, but task1 resolves faster
});
```


앵귤러에서 쓴 통신 프로미스

```typescript
new Promise((resolve, reject) => {
        this.httpService.postComment(paramJson).subscribe(
          data => {
            console.log(JSON.stringify(data));
            if(data.result){  //성공
              resolve();
            } else {  //실패
              reject(data.message);
            }
          },
          error => {
            console.log(error);
            reject("서버가 불안정합니다.");
          }
        );
      }).then(() => { //댓글 새로 가져오기
        this.httpService.getComments(this.post['postsID']).subscribe(
          data => {
            console.log(JSON.stringify(data));
            if(data.length > 0){  //성공
              this.comments = data[0];
              resolve();
            } else {  //실패
              throw("서버가 불안정합니다.");
            }
          },
          error => {
            console.log(error);
            this.comments = [this.httpService.errorComment];
          }
        );
      }).catch(err => {
        alert(err);
      });
```

