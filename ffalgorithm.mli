open Graph
open Tools

(* Initialisation : labels : (flot, capacité) *)
val init_graph : int graph -> (int*int) graph

(* Verifie qu'un arc existe entre node1 node2 (en prenant compte les flots et capacité) et retourne un booléen*)
val verifier_flot : (int*int) graph -> id -> id -> bool

(* Retourne un chemin = une liste d'arcs représentés par (départ, arrivé) 
ou lève l'exception Plus_de_chemin
*)
val chercher_chemin : (int*int) graph -> id -> id -> (id*id) list

(* Calcul la variation de flot sur un chemin donné *)
val calcul_variation_flot : (int*int) graph -> (id*id) list -> int

(* Ajouter la variation de flot sur tout un chemin donné et retourne le graph modifié*)
val add_flot_to_chemin : (int*int) graph -> int -> (id*id) list -> (int*int) graph

(* Ajouter la variation de flot sur un arc donné et retourne le graph modifié*)
val add_flot_to_arc : (int*int) graph -> int -> (id*id) -> (int*int) graph

(* Fonction principale : prend un graphe avec les capacités, le noeud source, le noeud puits et retourne le graphe avec les (flot, capacité) max et le débit final *)
val ffalgorithm : int graph -> id -> id -> (int*int) graph*int

(* (flot, capacité) graph -> string graph *)
val flot_graph_to_string : (int*int) graph -> string graph
