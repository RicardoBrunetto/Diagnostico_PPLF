% -------------------------------------------------
% *                BASE DE DADOS                  *
% -------------------------------------------------

doenca('Chame uma ambulância imediatamente!', ['manchas rosas achatadas']).
doenca('Chame uma ambulância imediatamente!', ['sonolencia']).
doenca('Chame uma ambulância imediatamente!', ['crises']).
doenca('Chame uma ambulância imediatamente!', ['respiracao acelerada']).
doenca('Chame uma ambulância imediatamente!', ['pele sarapintada']).
doenca('Chame uma ambulância imediatamente!', ['pele azulada']).
doenca('Chame uma ambulância imediatamente!', ['febre', 'dificuldade para respirar']).
doenca('Chame uma ambulância imediatamente!', ['febre', 'menos de 1 ano', 'menos de 6 meses']).

doenca('Mais exames necessários! Procure ajuda médica!', ['febre', 'menos de 1 ano', '']).

%Febre com mais de 1 ano
doenca('Meningite.', ['mais de 1 ano', 'pescoco duro']).
doenca('Meningite.', ['mais de 1 ano', 'dor de cabeca']).
doenca('Meningite.', ['mais de 1 ano', 'sonolencia']).
doenca('Meningite.', ['mais de 1 ano', 'irritabilidade']).
doenca('Meningite.', ['mais de 1 ano', 'dor nos bracos ou pernas']).
doenca('Meningite.', ['mais de 1 ano', 'maos ou pes frios']).

%doenca('', ['mais de 1 ano']).

%Febre com menos de 1 ano
doenca('Otite Interna', ['menos de 1 ano', 'mais de 6 meses', 'febre', 'chora ao puxar orelha']).
doenca('Pneumonia', ['menos de 1 ano', 'mais de 6 meses', 'respiracao acelerada']).
doenca('Bronquite', ['menos de 1 ano', 'mais de 6 meses', 'respiracao acelerada']).
doenca('Resfriado', ['menos de 1 ano', 'mais de 6 meses', 'tosse', 'coriza']).
doenca('Gripe', ['menos de 1 ano', 'mais de 6 meses', 'tosse', 'coriza']).
doenca('Sarampo', ['menos de 1 ano', 'mais de 6 meses', 'tosse', 'coriza']).
doenca('Meningite', ['menos de 1 ano', 'mais de 6 meses',  'vomito']).
doenca('Meningite', ['menos de 1 ano', 'mais de 6 meses',  'sonolencia']).
doenca('Meningite', ['menos de 1 ano', 'mais de 6 meses',  'irritabilidade']).
doenca('Infecção do Sistema Urinário', ['menos de 1 ano', 'mais de 6 meses',  'vomito']).
doenca('Infecção do Sistema Urinário', ['menos de 1 ano', 'mais de 6 meses',  'sonolencia']).
doenca('Infecção do Sistema Urinário', ['menos de 1 ano', 'mais de 6 meses',  'irritabilidade']).
doenca('Infecção de Garganta', ['menos de 1 ano', 'mais de 6 meses', 'rejeita comida solida']).
doenca('Gastroenterite', ['menos de 1 ano', 'mais de 6 meses', 'vomito', 'diarreia']).
doenca('Superaquecimento. Retire peças de roupa e procure ajuda médica caso a temperatura não normalizar em 1 hora.', ['menos de 1 ano', 'mais de 6 meses', 'recinto quente']).
doenca('Superaquecimento. Retire peças de roupa e procure ajuda médica caso a temperatura não normalizar em 1 hora.', ['menos de 1 ano', 'mais de 6 meses', 'muita roupa']).

%Dermatite com febre
doenca('Infecção Generalizada. Chame uma ambulância!', ['mais de 6 meses', 'erupcoes na pele', 'nao desaparecem quando apertadas']).
doenca('Catapora.', ['mais de 6 meses', 'erupcoes na pele', 'macnchas criam bolhas e secam em crostas']).
doenca('Sarampo (casos raros - Sindrome de Kawasaki).', ['mais de 6 meses', 'erupcoes na pele', 'erupcao suave', 'manchas elevadas', 'desaparecem quando apertadas', 'coriza']).
doenca('Sarampo (casos raros - Sindrome de Kawasaki).', ['mais de 6 meses', 'erupcoes na pele', 'erupcao suave', 'manchas elevadas', 'desaparecem quando apertadas', 'tosse']).
doenca('Sarampo (casos raros - Sindrome de Kawasaki).', ['mais de 6 meses', 'erupcoes na pele', 'erupcao suave', 'manchas elevadas', 'desaparecem quando apertadas', 'olhos vermelhos']).
doenca('Escarlatina.', ['mais de 6 meses', 'erupcoes na pele', 'erupcao suave', 'manchas elevadas', 'desaparecem quando apertadas', 'dor de garganta']).
doenca('Escarlatina.', ['mais de 6 meses', 'erupcoes na pele', 'erupcao suave', 'manchas elevadas', 'desaparecem quando apertadas', 'vomito']).
doenca('Reação à Medicação. Procure um médico.', ['mais de 6 meses', 'erupcoes na pele', 'erupcao suave', 'manchas elevadas', 'desaparecem quando apertadas', 'tomou medicamento']).
doenca('Rubéola.', ['mais de 6 meses', 'erupcoes na pele', 'rosto ou tronco', 'febre momentanea']).
doenca('Roséola.', ['mais de 6 meses', 'erupcoes na pele', 'rosto ou tronco', 'febre ha dias']).
doenca('Eritema Infeccioso.', ['mais de 6 meses', 'erupcoes na pele', 'erupcao vermelha', 'erupcao nas bochechas']).

% -------------------------------------------------
% *                  ALGORITMOS                   *
% -------------------------------------------------

remove_duplicates([],[]).

remove_duplicates([H | T], List) :-
     member(H, T),
     remove_duplicates( T, List).

remove_duplicates([H | T], [H|T1]) :-
      \+member(H, T),
      remove_duplicates( T, T1).

ler_do_arquivo(Stream, []):-
  at_end_of_stream(Stream), !.

ler_do_arquivo(Stream, [X|L]):-
  !, read(Stream, X),
  ler_do_arquivo(Stream, L).

main:-
  exists_file('sintomas.txt'),
  open('sintomas.txt', read, X),
  ler_do_arquivo(X, Lista),
  select('end_of_file', Lista, R),
  write(R),
  close(X),
  findall(Z, diagnostico(R, Z), Lista_Final),
  remove_duplicates(Lista_Final, Lista_Final_Unica),
  write_answer(Lista_Final_Unica).

isSubset([], _).

isSubset([X|L], S):-
  member(X, S),
  select(X, S, K),
  isSubset(L, K).

equal(X, Y):-
%  isSubset(X, Y).
  isSubset(Y, X).

diagnostico(Lista, Z):-
  doenca(Z, S),
  equal(Lista, S).
  %write_answer(Z).

diagnostico(Lista, Z):-
  Z = "Diagnóstico Inconclusivo".

write_answer([]):- !.

write_answer([X|Lista]):-
    open('output.txt', append, O),
    size_file('output.txt', Size),
    ((X \= "Diagnóstico Inconclusivo") ; (X == "Diagnóstico Inconclusivo", Size == 0)),
    set_output(O),
    write(X),
    write("\n"),
    close(O),
    write_answer(Lista).

:- main.
:- halt.
