open Graph
open Gfile
open Tools
open Ffalgorithm

type path = string

(* Lit une ligne avec une voiture *)
let read_voiture voiture_liste line =
  try Scanf.sscanf line "v %d : %d" (fun _ nb_places -> (List.append voiture_liste [nb_places]) )
  with e ->
    Printf.printf "Cannot read voiture in line - %s:\n%s\n%!" (Printexc.to_string e) line ;
    failwith "from_file"

(* Lit une ligne avec une personne *)
let read_personne personne_liste line =
  try Scanf.sscanf line "p %d : %s"
        (fun _ voitures -> (List.append personne_liste [voitures]))
  with e ->
    Printf.printf "Cannot read personne in line - %s:\n%s\n%!" (Printexc.to_string e) line ;
    failwith "from_file"

(* Lit un fichier covoit et renvoie le graphe des capacités *)
let from_file_to_covoit path =

	let infile = open_in path in

	(* Read all lines until end of file. 
	* n is the current node counter. *)
	let rec loop voiture_liste personne_liste =
	try
	  let line = input_line infile in

	  (* Remove leading and trailing spaces. *)
	  let line = String.trim line in

	  let (voiture_liste2, personne_liste2) =
		(* Ignore empty lines *)
		if line = "" then (voiture_liste, personne_liste)

		(* The first character of a line determines its content : n or e. *)
		else match line.[0] with
		  | 'v' -> ( (read_voiture voiture_liste line) , personne_liste)
		  | 'p' -> ( voiture_liste, (read_personne personne_liste line))

		  (* It should be a comment, otherwise we complain. *)
		  | _ -> (voiture_liste, personne_liste)
	  in      
	  loop voiture_liste2 personne_liste2

	with End_of_file -> (voiture_liste, personne_liste) (* Done *)
	in

	let (voiture_liste, personne_liste) = loop [] [] in
	(* Liste de liste de string (nombre) *)
	let personne_liste = List.map (String.split_on_char ',') personne_liste 	in 
	(* Liste de liste d'entiers *)
	let personne_liste = List.map (List.map (int_of_string)) personne_liste in
	(* noeud 0 = source qui est relié à toutes les personnes (capacité = 1)*)
	let graph = new_node empty_graph 0 in

	let create_personne gr n = new_arc (new_node gr n) 0 n 1  in

	let sink_node = 1 + (List.length voiture_liste) + (List.length personne_liste) in

	let graph = new_node graph sink_node in

	let create_voiture gr n capa = new_arc (new_node gr n) n sink_node capa  in

	let (graph, n) = List.fold_left (fun (graph, n) _ -> (create_personne graph n), n+1) (graph,1) personne_liste in
	let (graph, n) = List.fold_left (fun (graph, n) capa -> (create_voiture graph n capa), n+1) (graph,n) voiture_liste in

	(* Graphe avec les arcs entre source-personnes et voitures-puits *)

	let derniere_personne = (List.length personne_liste) in

	let create_arc_personne_voiture (gr, personne) l = 
(List.fold_left (fun gr voiture-> new_arc gr personne (derniere_personne+voiture) 1) gr l, personne+1) in

	let (graph, n) = List.fold_left (create_arc_personne_voiture) (graph, 1) personne_liste in

	close_in infile ;
	graph

let covoit path = 
	let gr = from_file_to_covoit path in 
	ffalgorithm gr 0 ((graph_length gr)-1)
