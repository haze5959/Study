# RxJS

### Pipeable operators

```javascript
const interval$ = interval(1000)            // 0--1--2--3--4--5--6...
const new$ = interval$
    .pipe(
        skip(1),                            // ---1--2--3--4--5--6...
        take(5),                            // ---1--2--3--4--5|
        filter(v => v % 2 === 0),           // ------2-----4-----6
        map(v => v + 1)                     // ------3-----5-----7
    )
```



### Avoiding memory leaks

```javascript
subscriptions = [];
const interval$ = interval(1000);
const subscription = interval$.subscribe(r => console.log(r));

// manually keep track of the subscriptions in a subscription array
this.subscriptions.push(subscription);

// when the component get's destroyed, unsubscribe all the subscriptions
this.subscriptions.forEach(sub => sub.unsubscribe());
```

혹은

```javascript
destroy$ = new Subject();

// interval$: 0--1--2--3--4--5--6--...
// destroy$:  -------------true|
// result:    0--1--2--3--4|
const interval$ = interval(1000);
interval$
    // let the interval$ stream live 
    // until the destroy$ Subject gets a value
    .pipe(takeUntil(this.destroy$))
    .subscribe(r => console.log(r));

// when the component get's destroyed, pass something to the
// destroy$ Subject
this.destroy$.next(true);
```



### Avoiding nested subscribes

나쁜 예)

```Javascript
this.route.params
            .pipe(map(v => v.id))
            .subscribe(id => 
                this.userService.fetchById(id)
                    .subscribe(user => this.user = user))
```

좋은 예)

```Javascript
this.route.params
            .pipe(
                map(v => v.id),
                switchMap(id => this.userService.fetchById(id))
            )
            .subscribe(user => this.user = user)
```