% -------------------------------------------------
% *                BASE DE DADOS                  *
% -------------------------------------------------

% QUESTOES: (Id, Pergunta, IdSim, IdNao).

question(0, "Seu bebe tem 1 ano ou mais", 14, 11).
%$ Sinais de Perigo
question(11, "Seu bebe tem dificuldade para respirar", r10, 12).
question(12, "Seu bebe tem sonolencia anormal", r10, 13).
question(13, "Seu bebe tem pele sarapintada ou azulada, inclusive labios", r10, 1).
% Febre (<= 1 ano)
question(1, "Seu bebe tem menos de 6 meses", r01, 2).
question(2, "Seu bebe tem erupcao na pele", DERMATITE, 4).
question(4, "Seu bebe chora e puxa orelha ou acorda gritando", r02, 5).
question(5, "O ritmo respiratorio esta mais rapido que o normal", r03, 6).
question(6, "Seu bebe tem tosse ou coriza", r04, 7).
question(7, "Seu bebe esta com vomito sem diarreia, sonolencia anormal e irritabilidade incomum", r05, 8).
question(8, "Seu bebe rejeita comida solida", r06, 9).
question(9, "Seu bebe sofre de vomito com diarreia", r07, 10).
question(10, "Seu bebe esta com muita roupa ou em um lugar muito quente", r08, r09).
% Sinais de Perigo
question(14, "Seu bebe tem sonolencia ou irritabilidade anormais", r10, 15).
question(15, "Seu bebe esta rejeitando liquidos", r09, 16).
question(16, "Seu bebe esta com vomito persistente", r09, 17).
question(17, "Seu bebe esta com olhos afundados", r09, 18).
question(18, "Seu bebe esta urinando pouco ou nada", r09, 19).
% Febre (> 1 ano)
question(19, "Seu bebe tem febre (temperatura acima de 38 graus)", DERMATITE, 20).
question(20, "Seu filho parece nao estar bem e tambem tem algum dos sintomas: pescoco duro, dor de cabeca, sonolencia anormal, irritabilidade incomum, dor nos bracos ou nas pernas, maos ou pes frios", r11, 21).
question(21, "Seu filho rejeita comida solida ou a garganta esta inflamada", r06, 22).
question(22, "Seu filho tem tosse ou coriza", PAG_DESC, 23).
question(23, "Seu filho tem um inchaco em um lado da face", r12, 24).
question(24, "Seu filho esta com respiracao incomumente ruidosa", r13, 25).
question(25, "A respiracao de seu filho esta incomumente rapida", r14, r15).
% Dermatite
question(DERMATITE).



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
answer(r10, 1, "Chame uma ambulância imediatamente!").
answer(r11, 0, "Meningite!\nCHAME UMA AMBILANCIA IMEDIATAMENTE!").
answer(r12, 0, "Caxumba ou Abscesso Dentario!").
answer(r13, 0, "Crupe Viral (laringotraqueobronquite) ou Bronquite!\nPROCURE ORIENTACAO MEDICA IMEDIATAMENTE!").
answer(r14, 0, "Pneumonia\nPROCURE ORIENTACAO MEDICA IMEDIATAMENTE!").
answer(r15, 0, "Resfriado ou Gripe (influenza)!").


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
