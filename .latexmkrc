$pdflatex = "pdflatex --shell-escape -synctex=-1 ";
$pdf_mode = 1;

%GI2TM_OPTIONS=(RELEASE_MATCHER=>"v[0-9]*.*");
do './gitinfo2.pm';