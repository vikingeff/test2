(* ************************************************************************** *)
(*                                                                            *)
(*                                                        :::      ::::::::   *)
(*   lexer.ml                                           :+:      :+:    :+:   *)
(*                                                    +:+ +:+         +:+     *)
(*   By: gleger <marvin@42.fr>                      +#+  +:+       +#+        *)
(*                                                +#+#+#+#+#+   +#+           *)
(*   Created: 2015/06/22 16:11:02 by gleger            #+#    #+#             *)
(*   Updated: 2015/06/22 16:11:04 by gleger           ###   ########.fr       *)
(*                                                                            *)
(* ************************************************************************** *)

type trool = FALSE | TRUE | NA | IMP

let print_trool = function
	| FALSE -> "false"
	| TRUE -> "true"
	| NA -> "n/a"
	| IMP -> "impossible"

let lexit rulez =
	let results = Array.make 26 NA in
	let arrul = Array.make ((List.length rulez)-1) ("", false) in
	let loop = ref 0 in 
	for i = 0 to ((List.length rulez)-1) do
		if (List.nth rulez i).[0] = '=' then
		begin
			let j = ref 1 in
			while (List.nth rulez i).[!j] != ' ' && (List.nth rulez i).[!j] != '\t' do
			(*for j=1 to (String.length (List.nth rulez i)-1) do*)
				let letter = (List.nth rulez i).[!j] in
				let index = int_of_char letter in
				if index <= 90 && index >= 65 then
					results.(index-65)<-TRUE;
					incr j
			done;
		end
		else if (List.nth rulez i).[0] != '#' then
			begin
				arrul.(!loop) <- ((List.nth rulez i), false);
				incr loop
			end
	done;
	for i = 0 to ((Array.length results)-1) do
		print_char (char_of_int (i+65));
		print_string " : ";
		print_string (print_trool (results.(i)));
		print_char '\n'
	done;
	arrul