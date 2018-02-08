# Introduction
I started using `gitinfo` a while ago, from version 1.x to version 2.x. I used the Git hooks mechanisms that were suggested in the documentation. Hence this methods works well in many situations, this approach is IMHO tedious and not straightforward to maintain.

Since I'm a user of `latexmk`, I decided to build a small tool that integrates smoothly with it and `gitinfo2`.
# Setup
## Download `gitinfo2.pm`

Simply download [gitinfo2.pm](https://raw.githubusercontent.com/rbarazzutti/gitinfo2-latexmk/0.0.1/gitinfo2.pm) and place at the root folder of your project.

## Hook in latexmk
Add the following line at the end of the file `.latexmkrc` that lays at the root folder of your project (create it if it doesn't exist).

```
do './gitinfo2.pm';
``` 

## Simply `\usepackage` 
In your LaTeX document, please add the following line

```
/usepackage{gitinfo2}
```
# Known-bugs
- The LaTeX files requires that the LaTeX source to be onThe root of your project needs to be the root of your git repository (due to `gitinfo2`'s design)

# PDF documentation
Simply download the [PDF manual](https://raw.githubusercontent.com/rbarazzutti/gitinfo2-latexmk/bin0.0.1/readme.pdf) of `gitinfo2-latexmk` . This PDF document contains more-or-less the content of this README.