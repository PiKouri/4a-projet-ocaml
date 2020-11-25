(* Yes, we have to repeat open Graph. *)
open Graph

(* assert false is of type ∀α.α, so the type-checker is happy. *)

(*returns a new graph having the same nodes than gr, but no arc.*)
let clone_nodes (gr:'a graph) = n_fold gr new_node empty_graph

(*maps all arcs of gr by function f.*)
let gmap gr f = let new_graph = clone_nodes gr 
				in let map graph id1 id2 arc = new_arc graph id1 id2 (f arc)
				in e_fold gr map new_graph

(*adds n to the value of the arc between id1 and id2. If the arc does not exist, it is created.*)
let add_arc gr id1 id2 n = match (find_arc gr id1 id2) with
	| None -> new_arc gr id1 id2 n
	| Some x -> new_arc gr id1 id2 (x+n)

let adjacent_nodes gr id1 = 
	let get_id = fun (id, lbl) -> id in
	let adj_nodes = ( List.map (get_id) (out_arcs gr id1) ) in
	let rec loop gr id1 id2 = 
		try if (List.mem id1 (List.map (get_id) (out_arcs gr id2) )) 
then id2 :: loop gr id1 (id2+1)
			else (loop gr id1 (id2+1))
		with Graph_error s -> []
	in List.append (loop gr id1 0) adj_nodes

let graph_length gr = n_fold gr (fun length _ -> length+1) 0
