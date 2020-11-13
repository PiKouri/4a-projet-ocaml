open Graph
open Tools

(* Initialisation : flot initial nul *)
let init_graph graph = gmap graph (fun arc -> (0, arc))

let verifier_flot graph id1 id2 = 
	match (find_arc graph id1 id2) with
		| Some (flot, capacite) -> (flot < capacite)
		| None -> match (find_arc graph id2 id1) with
			| Some (flot, capacite) -> (flot>0)
			| None -> false

let chercher_chemin gr id1 id2 = 
	let rec loop gr id1 id2 acu =
		if id1 == id2 then acu
		else let filtered_nodes = List.filter 
(fun id -> not(List.mem id acu) && (verifier_flot gr id1 id)) 
(adjacent_nodes gr id1) in
		List.iter (fun id -> loop gr id id2 [(id1,id) | acu]) filtered_nodes
	in loop gr id1 id2 []
