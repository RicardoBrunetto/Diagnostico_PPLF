% % doenca(asteropitite, [febre, odio]).
% % doenca(olhar, [coceira, odio]).
% possui_sintoma(febre).
% possui_sintoma(odio).
%
%
% doenca(X):-
%   read(Sintoma),
%   possui_sintoma(Sintoma).
%
% possui_doenca(asteropitite):-
%   possui_sintoma(febre),
%   possui_sintoma(odio).
%
% chovendo.

arvore(no, noTrue, noFalse).
arvore(noTrue, noTrue1, noFalse1).
arvore(noFalse, noTrue2, noFalse2).


% Algoritmo para percorrer árvore binária

%Caso base: nó folha
perc_Arv(No):-
  not(arvore(No, _, _)),
  write(No), !.

%
perc_Arv(No):-
  test_validate(No), !,
  arvore(No, X, _), !,
  perc_Arv(X).

perc_Arv(No):-
  arvore(No, _, X), !,
  perc_Arv(X).

% Algoritmo que verifica se um nó é considerado verdadeiro
test_validate(No):-
  write("Possui o sintoma: "), write(No), write("? (s/n): "),
  read(R),
  R=='s'.
