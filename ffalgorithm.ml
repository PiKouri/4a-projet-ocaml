open Graph
open Tools

type etat = Blanc | Gris | Noir

exception Plus_de_chemin
exception Arc_inexistant

(* Initialisation : flot initial nul *)
let init_graph graph = gmap graph (fun lbl -> (0, lbl))

let verifier_flot graph id1 id2 = 
	match (find_arc graph id1 id2) with
		| Some (flot, capacite) -> (flot < capacite)
		| None -> match (find_arc graph id2 id1) with
			| Some (flot, capacite) -> (flot>0)
			| None -> false

let chercher_chemin gr id1 id2 = 
	(*let rec loop gr id1 id2 acu =
		if id1 == id2 then acu
		else let filtered_nodes = List.filter 
(fun id -> not(List.mem id acu) && (verifier_flot gr id1 id)) 
(adjacent_nodes gr id1) in
		List.iter (fun id -> loop gr id id2 [(id1,id) | acu]) filtered_nodes
	in loop gr id1 id2 []*)
	let tab_etat = Array.make (graph_length gr) Blanc in
	Array.set tab_etat id1 Gris;
	let pile = Stack.create () in
	Stack.push id1 pile;

	let rec dfs gr id_arrivee tab_etat pile chemin = 
		let id_actuel = Stack.top pile in
		Printf.printf("Noeud analysé : %d\n%!") id_actuel; (*Debug*)
(*Adjacent nodes ou verifier flot : fleche à l'envers non pris en compte*)
		if (id_actuel == id_arrivee) then (tab_etat, pile, chemin)
		else let noeuds_voisins = List.filter 
(fun id_voisin -> (verifier_flot gr id_actuel id_voisin) && ((Array.get tab_etat id_voisin) == Blanc)) (adjacent_nodes gr id_actuel) in
			begin match noeuds_voisins with
				| [] -> Array.set tab_etat id_actuel Noir ; 
						ignore(Stack.pop pile);
						let new_chemin = begin match chemin with 
							| [] -> []
							| hd::tl -> tl ; 
						end; in
						dfs gr id_arrivee tab_etat pile new_chemin;
				| id_voisin::_ ->
						Printf.printf("Noeud voisin : %d\n%!") id_voisin;(*Debug*)
						Array.set tab_etat id_voisin Gris; 
						let chemin = (id_actuel, id_voisin)::chemin in
						Stack.push id_voisin pile; 
						dfs gr id_arrivee tab_etat pile chemin
			end;
	
	in 
let (_, _, chemin) = try (dfs gr id2 tab_etat pile [])
	with Stack.Empty -> raise Plus_de_chemin
in chemin
	
let calcul_variation_flot gr chemin = 
	let get_variation (id1,id2) = 
		begin match (find_arc gr id1 id2) with
			| Some (flot, capacite) -> capacite - flot
			| None -> match (find_arc gr id2 id1) with
				| Some (flot, capacite) -> flot
				| None -> raise Arc_inexistant
		end; in
	let variation_premier_element = get_variation (List.hd chemin) in
	let ma_fonction variation (id1, id2) = 
		let variation2 = get_variation (id1,id2) in
		begin if (variation<variation2) then variation
		else variation2 end; in
	List.fold_left ma_fonction variation_premier_element chemin

let add_flot_to_arc gr variation_flot (id1,id2)= 
	match (find_arc gr id1 id2) with
		| Some (flot, capacite) -> new_arc gr id1 id2 (flot+variation_flot,capacite)
		| None -> match (find_arc gr id2 id1) with
			| Some (flot, capacite) -> new_arc gr id2 id1 (flot-variation_flot,capacite)
			| None -> raise Arc_inexistant

let add_flot_to_chemin gr variation chemin = 		
	List.fold_left (fun gr (id1,id2) -> add_flot_to_arc gr variation (id1,id2)) gr chemin

let ffalgorithm graph source sink = 
	let new_graph = init_graph graph in
	let rec loop gr acu	= begin
		try 
			let chemin = chercher_chemin gr source sink in
			let variation = calcul_variation_flot gr chemin in
			let next_gr = add_flot_to_chemin gr variation chemin in
			loop next_gr (acu+variation)
		with Plus_de_chemin -> (gr, acu) 
	end; in
	loop new_graph 0

let flot_graph_to_string graph = gmap graph (fun (flot, capacite) -> Printf.sprintf "(%d,%d)%!" flot capacite)

