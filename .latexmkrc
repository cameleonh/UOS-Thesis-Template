$pdf_mode = 5;          # use xelatex
$xelatex = 'xelatex -interaction=nonstopmode -synctex=1 %O %S';
$biber = 'biber %O %S';
$clean_ext = 'bbl run.xml synctex.gz';
