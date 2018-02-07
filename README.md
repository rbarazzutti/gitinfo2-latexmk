# Introduction
blabla
# Setup
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