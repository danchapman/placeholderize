# Placeholderize
#### A compass extension that generates placeholders that will work with all of your breakpoints.

A current limitation of using placeholders in SASS is the inability to extend across directives. Placeholderize works with the [breakpoint compass extension](http://http://www.breakpoint-sass.com/) to generate a suite of placeholders that are namespaced based on your breakpoints. There is also an option to incorporate a [hidpi mixin](https://github.com/kaelig/hidpi) as well.

For example this...
```scss
$sm-screen = 40rem;
$md-screen = 64rem;

$breakpoints: (sm: $sm-screen, md: $md-screen);

@include placeholderize(bg-red) { background-color: red; }
@include placeholderize(bg-green) { background-color: green; }
@include placeholderize(bg-blue) { background-color: blue; }

.object-1 {
  @extend %bg-red;
}

.object-2 {
  @extend %bg-red;

  @include breakpoint($sm-screen) {
    @extend %bg-green-sm;
  }
}

.object-3 {
  @extend %bg-red;

  @include breakpoint($sm-screen) {
    @extend %bg-green-sm;
  }

  @include breakpoint($md-screen) {
    @extend %bg-blue-md;
  }
}
```

Will compile grouped selectors like this...

```scss
.object-1, .object-2, .object-3 {
  background-color: red;
}

@media (min-width: 40em) {
  .object-2, .object-3 {
    background-color: green;
  }
}

@media (min-width: 64em) {
  .object-3 {
    background-color: blue;
  }
}
```

### Step 1: Map your breakpoints
Placeholderize looks for a map called `breakpoints`. The naming of the keys is important, as they are added as a suffix to the placeholders that are created for each specific breakpoint. The map values are used to define the generated placeholders in the proper directives using the [breakpoint compass extension](http://http://www.breakpoint-sass.com/).

```scss
$breakpoints: (sm: $sm-screen, md: $md-screen);
```

### Step 2: Placeholderize some sass
Suppose I want to create grouped selectors for classes are assigned various float properties. To placeholderize them, I pass the desired name of the placeholder, and then pass the appropriate values in throught the content block like so:

```scss
@include placeholderize(float-left) { float: left; }
@include placeholderize(float-right) { float: right; }
@include placeholderize(float-right) { float: none; }
```

### Step 3: Extend the generated placeholders
Now I have the following placeholders available to me. And because they are placeholders, no css will be outputted unless these are put to use.

```scss
@extend %float-left;
@extend %float-right;
@extend %float-none;

@include breakpoint($sm-screen) {
  @extend %float-left-sm;
  @extend %float-right-sm;
  @extend %float-none;
}

@include breakpoint($md-screen) {
  @extend %float-left-md;
  @extend %float-right-md;
  @extend %float-none;
}

```
I am now apply some of these newly generated placeholders to a very very generic layout of boxes. Keep in mind, if you were actually writing this you would probably not use the float nones, or the second `%float-left-md` on the left box, but I am trying to show something in a small amount of space.

```scss
.left-box {
  @extend %float-none;
  @include breakpoint($sm-screen) { @extend %float-left-sm; }
  @include breakpoint($md-screen) { @extend %float-left-md; }
}

.right-box {
  @extend %float-none;
  @include breakpoint($sm-screen) { @extend %float-right-sm; }
  @include breakpoint($md-screen) { @extend %float-left-md; }
}

.middle-box {
  @extend %float-none;
  @include breakpoint($md-screen) { @extend %float-left-md; }
}
```

And here is what is output!

```scss
@media (min-width: 40em) {
  .left-box {
    float: left;
  }
}
@media (min-width: 64em) {
  .left-box, .right-box, .middle-box {
    float: left;
  }
}
@media (min-width: 40em) {
  .right-box {
    float: right;
  }
}
.left-box, .right-box, .middle-box {
  float: none;
}
```
There are a few takeaways from this:
  * Placeholderize is great for outputting grouped selectors with chunks of sass that you plan to use many times across numerous breakpoints and objects.
  * This gives you the modularity of a mixin, while being more performant due to not having to insert the same code into numerous selectors.
  * As you can see, it's not perfect because placeholder block of properties is still nested within its own media query. However, these grouped selectors are still [faster than nested selectors.](http://screwlewse.com/2010/08/different-css-techniques-and-their-performance/)
