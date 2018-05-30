# Angular

### 생명주기

```typescript
ngOnInit() {  }
ngOnChanges()
ngOnDestroy
```



### HostListener

```typescript
@HostListener('mouseenter') onMouseEnter() {
  this.highlight('yellow');
}

@HostListener('mouseleave') onMouseLeave() {
  this.highlight(null);
}
```



### interpolation

```typescript
<p>The sum of 1 + 1 is not {{1 + 1 + getVal()}}</p>
<input type="submit" class="btn" value="{{ btnText }}">
```

- #### Pipe

```typescript
<p>The hero's birthday is {{ birthday | date:"MM/dd/yy" }} </p>
<p>{{ text | slice:0:3 | uppercase }}</p>
// input) text = 'abcdefghijk'
// output) 'ABC'
```


### Ng 문법

```html
<li *ngFor="let hero of heroes">
  {{ hero }}
</li>

<p *ngIf="heroes.length > 3">There are many heroes!</p>

<div [ngSwitch]="currentHero.emotion">
  <happy-hero    *ngSwitchCase="'happy'"    [hero]="currentHero"></happy-hero>
  <sad-hero      *ngSwitchCase="'sad'"      [hero]="currentHero"></sad-hero>
  <confused-hero *ngSwitchCase="'confused'" [hero]="currentHero"></confused-hero>
  <unknown-hero  *ngSwitchDefault           [hero]="currentHero"></unknown-hero>
</div>
```



### reference variable

```html
<input #phone placeholder="phone number">
<button (click)="callPhone(phone.value)">Call</button>
```



### Binding

```Html
[] = Property
() = Event
[()] = Two-way

한줄로 이해
<input [value]="currentHero.name"
       (input)="currentHero.name=$event.target.value" >

//양방향 바인딩
<input [(ngModel)]="currentHero.name">

//사용 예
<button [style.color]="isSpecial ? 'red' : 'green'">
```



### EventEmitter

```typescript
   deleteRequest = new EventEmitter<Hero>();
   
   1. <button (click)="delete()">Delete</button>
   2. delete() {
      this.deleteRequest.emit(this.hero);
      }
   3. <hero-detail (deleteRequest)="deleteHero($event)" [hero]="currentHero"></hero-detail>


@Input()  hero: Hero;	//이건 그냥 컴포넌트 생성될 때 값 대입해주는거고
@Output() deleteRequest = new EventEmitter<Hero>();//이건 부모 컴포넌트에 이벤트 보낼 때 쓴느거
<hero-detail [hero]=“대입할 값” (deleteRequest)=“부모컴포넌트 이벤트($event)”>
```

   