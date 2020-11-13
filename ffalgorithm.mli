open Graph
open Tools

(* Initialisation : labels : (flot, capacité) *)
val init_graph : int graph -> (int, int) graph

(* Verifie qu'un arc existe entre node1 node2 (en prenant compte les flots et capacité) et retourne un booléen*)
val verifier_flot : (int, int) graph -> int -> int -> bool

(* retourne une liste d'arcs représentés par (départ, arrivé) *)
val chercher_chemin : (int, int) graph -> int -> int -> (int, int) list
