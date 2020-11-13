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

  ()

