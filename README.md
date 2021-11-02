# Introduction
I started using `gitinfo` a while ago, from version 1.x to version 2.x. I used the Git hooks mechanisms that were suggested in the documentation. Hence this method works well in many situations; it is, IMHO, tedious and not straightforward to maintain.

Since I'm a user of `latexmk`, I decided to build a small tool that integrates smoothly with it and `gitinfo2`.
# Setup
- Download `gitinfo2.pm`

    Simply download [gitinfo2.pm](https://raw.githubusercontent.com/rbarazzutti/gitinfo2-latexmk/v0.2.1/gitinfo2.pm) and place at the root folder of your project.

- Hook in latexmk
    Add the following line at the end of the file `.latexmkrc` that lays at the root folder of your project (create it if it doesn't exist).

    ``` sh
    do './gitinfo2.pm';
    ``` 

- Simply use `gitinfo`
    
    In your LaTeX document, please add the following line (feel free to add extra parameters as described in
    `gitinfo2` can be used now. You might want to have look to its [documentation](http://mirror.switch.ch/ftp/mirror/tex/macros/latex/contrib/gitinfo2/gitinfo2.pdf))

    i.e.
    ``` latex
    \usepackage[mark]{gitinfo2}
    ```

    Build your document with `latexmk`

## Tailoring release tags
By default, this module will look for release tags that match the following that starts with a digit (that fit the following regex `"[0-9]*.*"`).


You can use a custom release tags matcher, i.e. in case where version number are prefixed with the letter `"v"`, the hook code should be adapted by setting it through the a variable named `GIT2TM_OPTIONS`:

``` sh
%GI2TM_OPTIONS=(RELEASE_MATCHER=>"v[0-9]*.*");
do './gitinfo2.pm';
```


# Known-bugs
- Currently none. Please report!

# PDF documentation
Simply download the [PDF manual](https://github.com/rbarazzutti/gitinfo2-latexmk/blob/doc/readme-v0.2.1.pdf) of `gitinfo2-latexmk` . This PDF document contains more-or-less the content of this README.

# Change log
- v0.1.0 first release (tested with TeXlive2017 on Debian Linux and on OSX)
- v0.2.0 support for Windows
- v0.2.1 works in sub-directories too

# License

_gitinfo2-latexmk_ may be distributed and/or modified under the conditions of the LaTeX Project Public License: either version 1.3 of this license, or (at your option) any later version.
