open Graph
open Tools

(* Initialisation : labels : (flot, capacité) *)
val init_graph : int graph -> (int*int) graph

(* Verifie qu'un arc existe entre node1 node2 (en prenant compte les flots et capacité) et retourne un booléen*)
val verifier_flot : (int*int) graph -> int -> int -> bool

(* Retourne un chemin = une liste d'arcs représentés par (départ, arrivé) 
ou lève l'exception Plus_de_chemin
*)
val chercher_chemin : (int*int) graph -> int -> int -> (int*int) list

(* Calcul la variation de flot sur un chemin donné *)
val calcul_variation_flot : (int*int) graph -> (int*int) list -> int

(* Ajouter la variation de flot sur tout un chemin donné et retourne le graph modifié*)
val add_flot_to_chemin : (int*int) graph -> int -> (int*int) list -> (int*int) graph

(* Ajouter la variation de flot sur un arc donné et retourne le graph modifié*)
val add_flot_to_arc : (int*int) graph -> int -> (int*int) -> (int*int) graph

(* Finalisation : (flot, capacité) graph-> flot graph*)
val final_graph : (int*int) graph -> int graph

val ffalgorithm : int graph -> int -> int -> (int*int) graph*int

val flot_graph_to_string : (int*int) graph -> string graph
