open Covoit
open Ffalgorithm
open Gfile
    
let () =

	(* Check the number of command-line arguments *)
	if Array.length Sys.argv <> 3 then
	begin
	  Printf.printf "\nUsage: %s infile outfile\n\n%!" Sys.argv.(0) ;
	  exit 0
	end ;


	(* Arguments are : infile(1) source-id(2) sink-id(3) outfile(4) *)

	let infile = Sys.argv.(1)
	and outfile = Sys.argv.(2) in

	let (final_graph, debit) = covoit infile in
	
	Printf.printf "Debit trouvé : %d\n%!" debit;
	
	let () = write_file outfile (flot_graph_to_string final_graph) in
	
	let () = export outfile "graphdot.txt" in

	()

