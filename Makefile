# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: gleger <gleger@student.42.fr>              +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2015/01/18 17:03:33 by gleger            #+#    #+#              #
#    Updated: 2015/06/26 10:01:33 by gleger           ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

NAME =	expert

SRC =	parser.ml\
		lexer.ml\
		main.ml

OTHER = $(SRC:.ml=.o)
OBJ =	$(SRC:.ml=.cmo)
OPTOBJ = $(SRC:.ml=.cmx)
CMI = $(SRC:.ml=.cmi)
 
NATIF =	ocamlopt.opt
BYTECODE = ocamlc.opt
CAMLDEP = ocamldep

CLASS = people.cmo

%.cmo:			%.ml
	@echo "\033[1;36;m[Compiling $<]\t\033[0m: " | tr -d '\n'
	$(BYTECODE) -c $<

%.cmx:			%.ml
	@echo "\033[1;36;m[Compiling $<]\t\033[0m: " | tr -d '\n'
	$(NATIF) -c $<

all:			depend opti byte $(NAME)
opti: 			$(NAME).opt
byte:			$(NAME).byt

depend:			.depend
	@echo "\033[1;34;m[Initializing] \t\t\033[0m"
	@$(CAMLDEP) $(SRC) > .depend

.depend:
	@touch .depend

$(NAME).byt:	$(OBJ)
	@echo "\033[1;35;m[Linking] \t\t\033[0m: " | tr -d '\n'
	$(BYTECODE) -o $@ $(OBJ)
	@echo "\033[1;32;m[Success]\033[0m"

$(NAME).opt:	$(OPTOBJ)
	@echo "\033[1;35;m[Linking] \t\t\033[0m: " | tr -d '\n'
	$(NATIF) -o $@ $(OPTOBJ)
	@echo "\033[1;32;m[Success]\033[0m"

$(NAME):		
	@echo "\033[1;33;m[Processing] \t\t\033[0m"
	@ln -s $(NAME).byt $(NAME)
	@echo "\033[1;32;m[Success]\033[0m"

clean:
	@echo "\033[0;33;m[Cleaning] \t\t\033[0m: " | tr -d '\n'
	rm -f $(OBJ) $(OPTOBJ) $(CMI)
	@echo "\033[0;33;m[Cleaning] \t\t\033[0m: " | tr -d '\n'
	rm -f $(OTHER)

fclean:			clean
	@echo "\033[0;31;m[Deleting $(NAME)] \t\033[0m: " | tr -d '\n'
	rm -f $(NAME) $(NAME).opt $(NAME).byt
	@echo "\033[0;31;m[Deleting $(NAME)] \t\033[0m: .depend"
	@rm -f .depend

re:				fclean all

.PHONY:			all clean fclean re opti byte depend

include .depend