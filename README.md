# lua-utils
A collection of useful functions I find myself reusing every project

*WIP*

## TODO

Rewrite the majority of this in C

## Table utils

### `keys(t)`
### `splice(t, start, deleteCount, ...)`
### `slice(t, i1, i2)`
### `join(t1, t2)`
### `merge(t1, t2)`
### `rmerge(t1, t2)`
### `indexOf(t, element)`
### `removeOccurence(t, element)`
### `filter(t, filterFn)`
### `ifilter(t, filterFn)`
### `map(t, mapFn)`
### `reduce(t, initial, reduceFn)`
### `sum(t)`
### `forEach(t, fn)`
### `isArray(t)`
### `tlength(t)`
### `isSubset(t1, t2, ignore)`
### `shuffle(t, rand)`

## String utils

### `startsWith(piece)`
### `endsWith(piece)`
### `countOccurences(pattern)`
### `split(delim)`
### `dimensions()`

## Math utils

### `rotateO(x, y, angle)`
### `rotate(x, y, ox, oy, angle)`
### `atan2(y, x)`
### `distance(x, y, x2, y2)`

## Debug.utils

### `dump(e)`
