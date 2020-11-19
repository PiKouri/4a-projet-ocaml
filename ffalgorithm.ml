open Graph
open Tools

type etat = Blanc | Gris | Noir

(* Initialisation : flot initial nul *)
let init_graph graph = gmap graph (fun (dest, lbl) -> (dest, 0, lbl))

let verifier_flot graph id1 id2 = 
	match (find_arc graph id1 id2) with
		| Some (_,flot, capacite) -> (flot < capacite)
		| None -> match (find_arc graph id2 id1) with
			| Some (_,flot, capacite) -> (flot>0)
			| None -> false

let chercher_chemin gr id1 id2 = 
	(*let rec loop gr id1 id2 acu =
		if id1 == id2 then acu
		else let filtered_nodes = List.filter 
(fun id -> not(List.mem id acu) && (verifier_flot gr id1 id)) 
(adjacent_nodes gr id1) in
		List.iter (fun id -> loop gr id id2 [(id1,id) | acu]) filtered_nodes
	in loop gr id1 id2 []*)
	let tab_etat = Array.make id2 Blanc in
	Array.set tab_etat id1 Gris;
	let pile = Stack.create () in
	Stack.push id1 pile;

	let rec dfs gr id_arrivee tab_etat pile chemin = 
		let id_actuel = Stack.top pile in
		if (id_actuel == id_arrivee) then (tab_etat, pile, chemin)
		else let noeuds_voisins = List.filter 
(fun id_voisin -> (verifier_flot gr id_actuel id_voisin) && ((Array.get tab_etat id_voisin) == Blanc)) (adjacent_nodes gr id_actuel) in
			match noeuds_voisins with 
				| [] -> Array.set tab_etat id_actuel Noir ; 
						Stack.pop pile ;
				| id_voisin::_-> 
							Array.set tab_etat id_voisin Gris; 
							let chemin = [(id_actuel, id_voisin)::chemin] in
							Stack.push id_voisin pile;
			dfs gr id_arrivee tab_etat pile chemin
	
	in 
let (_, _, chemin) = dfs gr id2 tab_etat pile []
in chemin
	
	
