#ocamlc -c graph.mli graph.ml gfile.mli gfile.ml
#ocamlc -o ftest graph.cmo gfile.cmo ftest.ml
rm -f *.cmi *.cmo ftest testcovoit
ocamlbuild ftest.byte
ocamlbuild testcovoit.byte
