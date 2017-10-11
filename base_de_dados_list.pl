% -------------------------------------------------
% *                BASE DE DADOS                  *
% -------------------------------------------------

doenca('Gripe', ['tosse', 'coriza']).
doenca('Meningite', ['vomito sem diarreia', 'sonolencia', 'irritabilidade']).
doenca('Infeccao de Garganta', ['rejeita comida solida']).

% -------------------------------------------------
% *                  ALGORITMOS                   *
% -------------------------------------------------

ler_do_arquivo(Stream, []):-
  at_end_of_stream(Stream), !.

ler_do_arquivo(Stream, [X|L]):-
  !, read(Stream, X),
  ler_do_arquivo(Stream, L).

main:-
  open('sintomas.txt', read, X),
  ler_do_arquivo(X, Lista),
  select('end_of_file', Lista, R), !, 
  write(R),
  close(X),
  diagnostico(R).

isSubset([], _).

isSubset([X|L], S):-
  member(X, S),
  select(X, S, K),
  isSubset(L, K).

equal(X, Y):-
  isSubset(X, Y),
  isSubset(Y, X).

diagnostico(Lista):-
  doenca(Z, S),
  equal(Lista, S),
  write_answer(Z), !.

diagnostico(Lista):-
  write_answer("Failed").

write_answer(A):-
  open('output.txt', write, O),
  set_output(O),
  write(A),
  close(O).
