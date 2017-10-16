:- use_module(library(plunit)).
% -------------------------------------------------
% *                BASE DE DADOS                  *
% -------------------------------------------------

%Casos Gerais de Urgência
doenca('Chame uma ambulância imediatamente!', ['febre', 'manchas rosas achatadas']).
doenca('Chame uma ambulância imediatamente!', ['febre', 'sonolencia']).
doenca('Chame uma ambulância imediatamente!', ['diarreia', 'sonolencia']).
doenca('Chame uma ambulância imediatamente!', ['febre', 'crises']).
doenca('Chame uma ambulância imediatamente!', ['febre', 'respiracao acelerada']).
doenca('Chame uma ambulância imediatamente!', ['febre', 'pele sarapintada']).
doenca('Chame uma ambulância imediatamente!', ['febre', 'pele azulada']).
doenca('Chame uma ambulância imediatamente!', ['febre', 'dificuldade para respirar']).
doenca('Chame uma ambulância imediatamente!', ['febre', 'menos de 1 ano', 'menos de 6 meses']).
doenca('Chame uma ambulância imediatamente!', ['vomito', 'mais de 1 ano', 'vomito verde']).
doenca('Chame uma ambulância imediatamente!', ['vomito', 'mais de 1 ano', 'dores abdominais']).
doenca('Chame uma ambulância imediatamente!', ['vomito', 'mais de 1 ano', 'manchas rosas achatadas', 'nao desaparecem quando apertadas']).
%Casos Gerais de Emergência
doenca('Mais exames necessários! Procure ajuda médica!', ['febre', 'menos de 1 ano', '']).
doenca('Mais exames necessários! Procure ajuda médica!', ['diarreia', 'menos de 1 ano', 'rejeita liquidos']).
doenca('Mais exames necessários! Procure ajuda médica!', ['diarreia', 'menos de 1 ano', 'olhos afundados']).
doenca('Mais exames necessários! Procure ajuda médica!', ['diarreia', 'menos de 1 ano', 'pouca urina']).
doenca('Mais exames necessários! Procure ajuda médica!', ['vomito', 'olhos afundados']).
doenca('Mais exames necessários! Procure ajuda médica!', ['vomito', 'pele descascada']).
doenca('Mais exames necessários! Procure ajuda médica!', ['vomito', 'mais de 1 ano', 'lingua seca']).

%Vomito
doenca('Obstrução Intestinal. Chame uma ambulância', ['vomito', 'vomito verde']).

%Vomito com menos de 1 ano
doenca('Gases', ['menos de 1 ano', 'vomito', 'aceita ser alimentado', 'leite com dificuldade']).
doenca('Refluxo', ['menos de 1 ano', 'vomito', 'aceita ser alimentado', 'leite com dificuldade']).
doenca('Roséola', ['menos de 1 ano', 'vomito', 'febre', 'sonolencia']).
doenca('Roséola', ['menos de 1 ano', 'vomito', 'febre', 'rejeita ser alimentado']).
doenca('Meningite', ['menos de 1 ano', 'vomito', 'febre', 'sonolencia']).
doenca('Meningite', ['menos de 1 ano', 'vomito', 'febre', 'rejeita ser alimentado']).
doenca('Infeccao do Sistema Urinario', ['menos de 1 ano', 'vomito', 'febre', 'sonolencia']).
doenca('Infeccao do Sistema Urinario', ['menos de 1 ano', 'vomito', 'febre', 'rejeita ser alimentado']).
doenca('Infeccao do Sistema Urinario', ['menos de 1 ano', 'vomito', 'febre', 'dor ao urinar']).
doenca('Infeccao do Sistema Urinario', ['menos de 1 ano', 'vomito', 'febre', 'dores abdominais']).
doenca('Bronqueolite', ['menos de 1 ano', 'vomito', 'febre', 'tosse']).
doenca('Coqueluche', ['menos de 1 ano', 'vomito', 'febre', 'tosse']).

%Vomito com mais de 1 ano
doenca('Apendicite. Chame uma ambulância', ['mais de 1 ano', 'vomito', 'dor por 6 horas']).
doenca('Ferimento de cabeça. Chame uma ambulância', ['mais de 1 ano', 'vomito', 'sonolencia', 'sofreu pancada']).
doenca('Meningite', ['mais de 1 ano', 'vomito', 'sonolencia',  'manchas rosas achatadas', 'nao desaparecem quando apertadas']).
doenca('Hepatite', ['mais de 1 ano', 'vomito', 'fezes palidas', 'urina escura']).
doenca('Infeccao do Sistema Urinario', ['mais de 1 ano', 'vomito', 'dor ao urinar']).
doenca('Infeccao do Sistema Urinario', ['mais de 1 ano', 'vomito', 'dores abdominais']).
doenca('Coqueluche', ['mais de 1 ano', 'vomito', 'crise de tosse']).
doenca('Isso é comum. Procure orientação médica se o vômito persistir', ['mais de 1 ano', 'vomito', 'agitado']).
doenca('Enjoo de Viagem', ['mais de 1 ano', 'vomito', 'apos viagem']).

%Diarreia
doenca('Reação à Medicação. Procure um médico', ['diarreia', 'tomou medicamento']).

%Diarreia com menos de 1 ano
doenca('Intolerância Alimentar', ['menos de 1 ano', 'diarreia', 'mais de 2 semanas']).
doenca('Alergia Alimentar', ['menos de 1 ano', 'diarreia', 'mais de 2 semanas']).
doenca('Doença Celíaca', ['menos de 1 ano', 'diarreia', 'mais de 2 semanas']).
doenca('Fibrose Cística', ['menos de 1 ano', 'diarreia', 'mais de 2 semanas']).
doenca('Excesso de Açúcar', ['menos de 1 ano', 'diarreia', 'sucos ou polpas excesso']).
doenca('Isso é comum. Novos alimentos podem causar diarréia, mas por pouco tempo', ['menos de 1 ano', 'diarreia', 'alimento novo']).

%Diarreia com mais de 1 ano
doenca('Gastroenterite', ['mais de 1 ano', 'diarreia', 'ultimos 3 dias']).
doenca('Gastroenterite', ['mais de 1 ano', 'diarreia', 'ultimos 3 dias', 'dores abdominais']).
doenca('Gastroenterite', ['mais de 1 ano', 'diarreia', 'ultimos 3 dias', 'vomito']).
doenca('Gastroenterite', ['mais de 1 ano', 'diarreia', 'ultimos 3 dias', 'febre']).
doenca('Tensão ou Estresse Emocional', ['mais de 1 ano', 'diarreia', 'ultimos 3 dias', 'evento estressante']).
doenca('Constipação Crônica', ['mais de 1 ano', 'diarreia', 'constipado']).
doenca('Intolerância Alimentar', ['mais de 1 ano', 'diarreia', 'pedacinhos reconheciveis']).
doenca('Alergia Alimentar', ['mais de 1 ano', 'diarreia', 'pedacinhos reconheciveis']).
doenca('Doença Celíaca', ['mais de 1 ano', 'diarreia', 'pedacinhos reconheciveis']).
doenca('Fibrose Cística', ['mais de 1 ano', 'diarreia', 'pedacinhos reconheciveis']).

%Febre
doenca('Gastroenterite', ['vomito', 'diarreia']).
doenca('Gastroenterite', ['febre', 'diarreia']).
doenca('Gastroenterite', ['diarreia', 'pouco apetite']).
doenca('Infecção de Garganta', ['febre', 'rejeita comida solida']).
doenca('Infecção de Garganta', ['febre', 'garganta inflamada']).
doenca('Otite Interna', ['febre', 'chora ao puxar orelha']).
doenca('Superaquecimento. Retire peças de roupa e procure ajuda médica caso a temperatura não normalizar em 1 hora', ['febre', 'recinto quente']).
doenca('Superaquecimento. Retire peças de roupa e procure ajuda médica caso a temperatura não normalizar em 1 hora', ['febre', 'muita roupa']).
doenca('Superaquecimento. Retire peças de roupa e procure ajuda médica caso a temperatura não normalizar em 1 hora', ['febre', 'muito tempo no sol']).

%Febre com mais de 1 ano
doenca('Meningite', ['mais de 1 ano', 'febre', 'pescoco duro']).
doenca('Meningite', ['mais de 1 ano', 'febre', 'dor de cabeca']).
doenca('Meningite', ['mais de 1 ano', 'febre', 'sonolencia']).
doenca('Meningite', ['mais de 1 ano', 'febre', 'irritabilidade']).
doenca('Meningite', ['mais de 1 ano', 'febre', 'dor nos bracos ou pernas']).
doenca('Meningite', ['mais de 1 ano', 'febre', 'maos ou pes frios']).
doenca('Crupe Viral', ['mais de 1 ano', 'febre', 'tosse', 'coriza']).
doenca('Caxumba', ['mais de 1 ano', 'febre', 'face inchada']).
doenca('Abcesso Dentário', ['mais de 1 ano', 'febre', 'face inchada']).
doenca('Pneumonia', ['mais de 1 ano', 'febre', 'tosse', 'coriza', 'respiracao ruidosa']).
doenca('Gripe', ['mais de 1 ano', 'febre', 'tosse', 'coriza']).
doenca('Resfriado', ['mais de 1 ano', 'febre', 'tosse', 'coriza']).

%Febre com menos de 1 ano
doenca('Pneumonia', ['menos de 1 ano', 'mais de 6 meses', 'febre', 'respiracao acelerada']).
doenca('Bronquite', ['menos de 1 ano', 'mais de 6 meses', 'febre', 'respiracao acelerada']).
doenca('Resfriado', ['menos de 1 ano', 'mais de 6 meses', 'febre', 'tosse', 'coriza']).
doenca('Gripe', ['menos de 1 ano', 'mais de 6 meses', 'febre', 'tosse', 'coriza']).
doenca('Sarampo', ['menos de 1 ano', 'mais de 6 meses', 'febre', 'tosse', 'coriza']).
doenca('Meningite', ['menos de 1 ano', 'mais de 6 meses', 'febre',  'vomito']).
doenca('Meningite', ['menos de 1 ano', 'mais de 6 meses', 'febre',  'sonolencia']).
doenca('Meningite', ['menos de 1 ano', 'mais de 6 meses', 'febre',  'irritabilidade']).
doenca('Infeccao do Sistema Urinario', ['menos de 1 ano', 'mais de 6 meses', 'febre',  'vomito']).
doenca('Infeccao do Sistema Urinario', ['menos de 1 ano', 'mais de 6 meses', 'febre',  'sonolencia']).
doenca('Infeccao do Sistema Urinario', ['menos de 1 ano', 'mais de 6 meses', 'febre',  'irritabilidade']).
doenca('Gastroenterite', ['menos de 1 ano', 'mais de 6 meses', 'febre', 'vomito', 'diarreia']).

%Dermatite com febre
doenca('Infecção Generalizada. Chame uma ambulância!', ['mais de 6 meses', 'febre', 'erupcoes na pele', 'nao desaparecem quando apertadas']).
doenca('Catapora', ['mais de 6 meses', 'febre', 'erupcoes na pele', 'macnchas criam bolhas e secam em crostas']).
doenca('Sarampo (casos raros - Sindrome de Kawasaki)', ['mais de 6 meses', 'febre', 'erupcoes na pele', 'erupcao suave', 'manchas elevadas', 'desaparecem quando apertadas', 'coriza']).
doenca('Sarampo (casos raros - Sindrome de Kawasaki)', ['mais de 6 meses', 'febre', 'erupcoes na pele', 'erupcao suave', 'manchas elevadas', 'desaparecem quando apertadas', 'tosse']).
doenca('Sarampo (casos raros - Sindrome de Kawasaki)', ['mais de 6 meses', 'febre', 'erupcoes na pele', 'erupcao suave', 'manchas elevadas', 'desaparecem quando apertadas', 'olhos vermelhos']).
doenca('Escarlatina', ['mais de 6 meses', 'febre', 'erupcoes na pele', 'erupcao suave', 'manchas elevadas', 'desaparecem quando apertadas', 'dor de garganta']).
doenca('Escarlatina', ['mais de 6 meses', 'febre', 'erupcoes na pele', 'erupcao suave', 'manchas elevadas', 'desaparecem quando apertadas', 'vomito']).
doenca('Reação à Medicação. Procure um médico', ['mais de 6 meses', 'febre', 'erupcoes na pele', 'erupcao suave', 'manchas elevadas', 'desaparecem quando apertadas', 'tomou medicamento']).
doenca('Rubéola', ['mais de 6 meses', 'febre', 'erupcoes na pele', 'rosto ou tronco', 'febre momentanea']).
doenca('Roséola', ['mais de 6 meses', 'febre', 'erupcoes na pele', 'rosto ou tronco', 'febre ha dias']).
doenca('Eritema Infeccioso', ['mais de 6 meses', 'febre', 'erupcoes na pele', 'erupcao vermelha', 'erupcao nas bochechas']).

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
  write(Lista_Final_Unica),
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

diagnostico(Lista, Z):-
  Z = 'Diagnostico Inconclusivo'.

write_answer([]):- !.

write_answer([X|Lista]):-
    open('output.txt', append, O),
    current_output(Output),
    size_file('output.txt', Size),
    ((X \= 'Diagnostico Inconclusivo') ; (X == 'Diagnostico Inconclusivo', Size == 0)),
    set_output(O),
    write(X), write("\n"),
    close(O),
    set_output(Output),
    write_answer(Lista).

:- main.
:- halt.

same([], []).

same([H1|R1], [H2|R2]):-
    H1 = H2,
    same(R1, R2).

:- begin_tests(dermatites).
 %Testes "Determinísticos"
 test(catapora, Z == 'Catapora') :- diagnostico(['mais de 6 meses', 'febre', 'erupcoes na pele', 'macnchas criam bolhas e secam em crostas'], Z).
 test(meningite, Z == 'Meningite') :- diagnostico(['vomito', 'menos de 1 ano', 'mais de 6 meses', 'febre'], Z).
 %Testes Não-Determinísticos
 test(febre, Xs == ['Meningite', 'Infeccao do Sistema Urinario', 'Diagnostico Inconclusivo']) :-
        findall(X, diagnostico(['menos de 1 ano', 'mais de 6 meses', 'febre',  'vomito'], X), Xs).

:- end_tests(dermatites).
