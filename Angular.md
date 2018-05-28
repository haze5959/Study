# Angular

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