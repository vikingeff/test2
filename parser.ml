(* ************************************************************************** *)
(*                                                                            *)
(*                                                        :::      ::::::::   *)
(*   parser.ml                                          :+:      :+:    :+:   *)
(*                                                    +:+ +:+         +:+     *)
(*   By: gleger <marvin@42.fr>                      +#+  +:+       +#+        *)
(*                                                +#+#+#+#+#+   +#+           *)
(*   Created: 2015/06/22 16:11:02 by gleger            #+#    #+#             *)
(*   Updated: 2015/06/22 16:11:04 by gleger           ###   ########.fr       *)
(*                                                                            *)
(* ************************************************************************** *)

type operand = AND | OR | XOR | NOT | IFONLY | IMPLY | EQUAL
let get_left (left,_) = left
let get_right (_,right) = right

let rev_list lst = 
	let rec backward lst acc = match lst with
		| [] -> []
		| last::[] -> last::acc
		| first::suite -> backward suite (first::acc)
		in backward lst [] 

let lst_from_file file =
	let input = open_in file in 
	let lst = ref [] in
	try
		while true do
			let buff = input_line input in
			if buff = "" then
				lst:=!lst
			else
				lst:=(String.trim(buff))::!lst
		done;
		lst
	with
		| End_of_file -> close_in input; lst
		| _ -> print_endline "There was an error, just don't know which one."; lst

let parsit arrayz =
	print_string "rule: ";
	let test = arrayz.(0) in
	print_endline (get_left test)
	