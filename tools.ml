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