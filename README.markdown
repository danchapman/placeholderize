# Placeholderize
#### A compass extension that generates placeholders that will work with all of your breakpoints.

A current limitation of using placeholders in SASS is the inability to extend across directives. Placeholderize works with the [breakpoint compass extension](http://http://www.breakpoint-sass.com/) to generate a suite of placeholders that are namespaced based on your breakpoints. There is also an option to incorporate a [hidpi mixin](https://github.com/kaelig/hidpi) as well. 

For example this...
```
$sm-screen = 40rem
$md-screen = 64rem

$breakpoints: (sm: $sm-screen, md: $md-screen);

@include placeholderize(font-size-10pt) { font-size: 0.813rem }
@include placeholderize(font-size-14pt) { font-size: 1.125rem }
@include placeholderize(font-size-18pt) { font-size: 1.500rem }

.object-1 {
  @extend %font-size-10pt;
}

.object-2 {
  @extend %font-size-10pt;
  
  @include breakpoint($sm-screen) {
    @extend %font-size-14pt-sm;
  }
}

.object-3 {
  @extend %font-size-10pt;
  
  @include breakpoint($sm-screen) {
    @extend %font-size-14pt-sm;
  }
  
  @include breakpoint($md-screen) {
    @extend %font-size-18pt-md;
  }
}
```

Will compile grouped selectors like this...
```
.object-1, .object-2, .object-3 {
  font-size: 0.813rem;
}

@media (min-width: 40em) {
  .object-2, .object-3 {
    font-size: 1.125rem;
  }
}

@media (min-width: 64em) {
  .object-3 {
    font-size: 1.500rem;
  }
}
```
