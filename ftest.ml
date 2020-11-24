open Gfile
open Tools
open Ffalgorithm
    
let () =

  (* Check the number of command-line arguments *)
  if Array.length Sys.argv <> 5 then
    begin
      Printf.printf "\nUsage: %s infile source sink outfile\n\n%!" Sys.argv.(0) ;
      exit 0
    end ;


  (* Arguments are : infile(1) source-id(2) sink-id(3) outfile(4) *)
  
  let infile = Sys.argv.(1)
  and outfile = Sys.argv.(4)
  
  (* These command-line arguments are not used for the moment. *)
  and _source = int_of_string Sys.argv.(2)
  and _sink = int_of_string Sys.argv.(3)
  in

  (* Open file *)
  (*let graph = from_file infile in
  let int_graph = gmap graph (int_of_string) in
  let new_graph = add_arc int_graph 4 5 5 in
  let new_graph2 = add_arc new_graph 3 5 150 in
  (* Rewrite the graph that has been read. *)
  let () = write_file outfile (gmap new_graph2 (string_of_int)) in*)

	let () = export infile outfile in

	(*let graph = from_file infile in
	let int_graph = gmap graph (int_of_string) in
	(*let new_graph = init_graph int_graph in


(* TEST adjacent_nodes *)
	
	Printf.printf("TEST adjacent_nodes\n%!");
	let adj = adjacent_nodes int_graph 3 in
	List.iter (Printf.printf("%d\n%!")) adj;

(* TEST chercher_chemin *)

	Printf.printf("TEST chercher_chemin\n%!");
	let chemin = chercher_chemin new_graph 0 5 in
	List.iter (fun (id1, id2) -> Printf.printf("(%d,%d)\n%!") id1 id2) 	chemin;

(* TEST calcul_variation_flot *)

	Printf.printf("TEST calcul_variation_flot\n%!");
	let variation_chemin = calcul_variation_flot new_graph chemin in
	Printf.printf "Variation du chemin : %d\n%!" variation_chemin;

(* TEST add_flot_to_chemin *)

	Printf.printf("TEST add_flot_to_chemin\n%!");
	let modified_graph = add_flot_to_chemin new_graph variation_chemin chemin in
	(*Ajoute 8 au chemin (0,2) (2,4) (4,5)*)
	let chemin_inverse = [(5,4);(4,2);(2,0)] in
	let modified_graph = add_flot_to_chemin modified_graph 3 chemin_inverse in
	(*Enlève 3 au chemin*)

	(* en deux fois *)
	let string_graph = flot_graph_to_string modified_graph in
	let () = write_file outfile string_graph in*)

(* TEST ffalgorithm *)

	Printf.printf("TEST ffalgorithm\n%!");
	
	let (new_graph, debit) = ffalgorithm int_graph _source _sink in
	Printf.printf "Debit trouvé : %d\n%!" debit;
	let () = write_file outfile (flot_graph_to_string new_graph) in*)

  ()

