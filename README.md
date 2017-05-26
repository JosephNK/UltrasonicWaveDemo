UltrasonicWaveDemo
==================

This Demo is using [[QuietModemKit]](https://github.com/quiet/QuietModemKit) framework.

<img src="https://github.com/JosephNK/UltrasonicWaveDemo/blob/master/Screenshot/screenshot_02.png" width="300" alt="Screenshot">

Setup & Install
--------------

#### 1. Carthage install

```
$ brew update
$ brew install carthage
```

#### 2. Liquid DSP install [liquid-dsp](https://github.com/quiet/liquid-dsp/tree/devel)

```
$ brew install cmake
$ brew install automake 
$ git clone https://github.com/quiet/liquid-dsp.git -b devel --single-branch
$ ./bootstrap.sh     
$ ./configure
$ make
$ sudo make install
```

> ./bootstrap.sh: line 30: aclocal: command not found  
> $ brew install automake


#### 3. libfec install [libfec](https://github.com/quiet/libfec)

``` 
$ git clone https://github.com/quiet/libfec.git
$ ./configure --build=x86_64-apple-darwin15.0.0
$ make
$ sudo make install
```

> error: unknown target CPU 'i386'  
> $ ./configure --build=x86_64-apple-darwin15.0.0


#### 4. Jansson install [jansson](https://github.com/akheron/jansson)

``` 
$ brew install libtool
$ git clone https://github.com/akheron/jansson.git
$ autoreconf -i
$ ./configure
$ make
$ make install
```

> configure.ac:12: error: possibly undefined macro: AC_PROG_LIBTOOL  
> $ brew install libtool


#### 5. quiet(iOS framework) install [quiet](https://github.com/quiet/quiet)

```
$ ./bootstrap
$ cd build && make install
```

> Dependencies  
> - Liquid DSP   
> - libfec  
> - Jansson 

#### 6. Dependencies Install File Check

```
$ cd /usr/local/lib
$ ls -al

-rw-r--r--   1 user  admin   174456  5 25 19:49 libfec.a
-rw-r--r--   1 user  admin    48620  5 25 19:49 libfec.dylib
-rwxr-xr-x   1 user  admin    69364  5 25 21:53 libjansson.4.dylib
-rw-r--r--   1 user  admin   228912  5 25 21:53 libjansson.a
lrwxr-xr-x   1 user  admin       18  5 25 21:53 libjansson.dylib -> libjansson.4.dylib
-rwxr-xr-x   1 user  admin      929  5 25 21:53 libjansson.la
rw-r--r--    1 root  admin  2937976  5 25 21:39 libliquid.a
-rw-r--r--   1 root  admin  1014540  5 25 21:39 libliquid.dylib
-rw-r--r--   1 user  admin   154304  5 25 21:55 libquiet.a
-rwxr-xr-x   1 user  admin    55860  5 25 21:55 libquiet.dylib

$ cd /usr/local/include
$ ls -al

-rw-r--r--   1 user  admin    10272  5 25 21:53 jansson.h
-rw-r--r--   1 user  admin     1340  5 25 21:53 jansson_config.h
drwxr-xr-x   3 root  admin      102  5 25 21:39 liquid
-rw-r--r--   1 user  admin    38273  5 25 21:55 quiet.h
 
```

#### 7. QuietModemKit.framework install [QuietModemKit](https://github.com/quiet/QuietModemKit)

1) Xcode Create Project  
2) Project Close
3) Install (by carthage)

```
$ brew install cmake
$ vi Cartfile

github "Quiet/QuietModemKit" == 0.1.3

$ carthage update --platform iOS --verbose

*** Fetching QuietModemKit
*** Checking out QuietModemKit at "v0.1.3"

... ... ... 
... ...

** BUILD SUCCEEDED **
```

Build failed Caution

```
*** Fetching QuietModemKit
*** Checking out QuietModemKit at "v0.1.3"

... ... ... 
... ...

cp: /Users/<UserName>/Library/Caches/org.carthage.CarthageKit/DerivedData/QuietModemKit/v0.1.3/Build/Products/Release-iphoneos/sysroot/usr/lib/libliquid.a: No such file or directory
cp: /Users/<UserName>/Library/Caches/org.carthage.CarthageKit/DerivedData/QuietModemKit/v0.1.3/Build/Products/Release-iphoneos/sysroot/usr/lib/libquiet.a: No such file or directory
cp: /Users/<UserName>/Library/Caches/org.carthage.CarthageKit/DerivedData/QuietModemKit/v0.1.3/Build/Products/Release-iphoneos/sysroot/usr/include/liquid: No such file or directory
cp: /Users/<UserName>/Library/Caches/org.carthage.CarthageKit/DerivedData/QuietModemKit/v0.1.3/Build/Products/Release-iphoneos/sysroot/usr/include/quiet.h: No such file or directory

** BUILD FAILED **
```

 Do not copy files directly.
