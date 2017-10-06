% -------------------------------------------------
% *                BASE DE DADOS                  *
% -------------------------------------------------

% QUESTOES: (Id, Pergunta, IdSim, IdNao).

% Febre
question(0, "Seu bebe tem menos de 6 meses", r01, 1).
question(1, "Seu bebe tem erupcao na pele", 2, 3).
question(3, "Seu bebe chora e puxa orelha ou acorda gritando", r02, 4).
question(4, "O ritmo respiratorio esta mais rapido que o normal", r03, 5).
question(5, "Seu bebe tem tosse ou coriza", r04, 6).
question(6, "Seu bebe esta com vomito sem diarreia, sonolencia anormal e irritabilidade incomum", r05, 7).
question(7, "Seu bebe rejeita comida solida", r06, 8).
question(8, "Seu bebe sofre de vomito com diarreia", r07, 9).
question(9, "Seu bebe esta com muita roupa ou em um lugar muito quente", r08, r09).


% Dermatite
question(2).



% RESPOSTAS: (Id, Codigo, Resposta)
%% Código:
%%% 0 - POSSÍVEL CAUSA
%%% 1 - DIAGNOSTICO INCONCLUSIVO
%%% 2 - EXAMES NECESSÁRIOS

answer(r01, 0, "Febre em bebes abaixo de 6 meses e incomum e pode indicar doenca seria!\nPROCURE ORIENTACAO MEDICA IMEDIATAMENTE!").
answer(r02, 0, "Otite Interna!").
answer(r03, 0, "Pneumonia ou Bronquite!\nPROCURE ORIENTACAO MEDICA IMEDIATAMENTE!").
answer(r04, 0, "Resfriado, Gripe (influenza) ou, em casos raros, Sarampo!").
answer(r05, 0, "Meningite ou Infeccao Urinaria!\nPROCURE ORIENTACAO MEDICA IMEDIATAMENTE!").
answer(r06, 0, "Infeccao de Garganta!").
answer(r07, 0, "Gastroenterite!").
answer(r08, 0, "Superaquecido!\nRetire o excesso de roupa e abaixe a temperatura do ambiente.\nSe não normalizar em uma hora, procure um medico.").
answer(r09, 1, "Procure orientacao medica!").


% -------------------------------------------------
% *                  ALGORITMOS                   *
% -------------------------------------------------

% Starter
diagnostico:-
  perc_Arv(0).

% Algortimo que percorre a árvore binária
%% Caso base: nó folha
perc_Arv(ID):-
  not(question(ID, _, _, _)),
  print_answer(ID), !.
%% Caso onde o nó é verdadeiro
perc_Arv(ID):-
  test_validate(ID), !,
  question(ID, _, X, _), !,
  perc_Arv(X).
%% Caso  onde o nó é falso
perc_Arv(ID):-
  question(ID, _, _, X), !,
  perc_Arv(X).

% Algoritmo que verifica se um nó é considerado verdadeiro
test_validate(No):-
  question(No, Q, _, _), !,
  write(Q), write("? (s/n): "),
  read(R),
  R=='s'.

% Algoritmo que imprime nós folhas
%% Codigo 0
print_answer(ID):-
  answer(ID, Cod, Resp),
  Cod =:= 0,
  write("\n---------------------------------\n\tPOSSIVEL CAUSA\n---------------------------------\n"),
  write(Resp).
%% Codigo 1
print_answer(ID):-
  answer(ID, Cod, Resp),
  Cod =:= 1,
  write("\n---------------------------------\n\tDIAGNOSTICO INCONCLUSIVO\n---------------------------------\n"),
  write(Resp).
%% Codigo 2
print_answer(ID):-
  answer(ID, Cod, Resp), !,
  write("\n---------------------------------\n\tEXAMES NECESSÁRIOS\n---------------------------------\n"),
  write(Resp).
