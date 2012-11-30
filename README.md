# GSProgressView

A cute little circular progress view for iOS

<img src="http://goosoftware.github.com/GSProgressView/GSProgressView-sample.png" width="675">

# Installation

Drag GSProgressView.h and GSProgressView.m into your project.

# Serving suggestion

```objective-c
GSProgressView *pv = [[GSProgressView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
pv.color = [UIColor redColor];
pv.progress = 0.6;
[myView addSubview:pv];
```

# License

[![Creative Commons License][cc-by-30-icon]][cc-by-30]

This work is licensed under a [Creative Commons Attribution 3.0 Unported License][cc-by-30].

You're free to use this code in any project, including commercial. Please include the following text somewhere suitable, e.g. your app's About screen:

**Uses GSProgressView by Simon Whitaker**

[cc-by-30-icon]: http://i.creativecommons.org/l/by/3.0/88x31.png
[cc-by-30]: http://creativecommons.org/licenses/by/3.0/
