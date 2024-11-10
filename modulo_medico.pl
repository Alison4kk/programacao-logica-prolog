% Declarando sintomas como fatos dinamicos
:- dynamic febre/0, dor_de_cabeca/0, tosse/0, cansaco/0, dor_de_garganta/0, dor_muscular/0, espirro/0, congestao_nasal/0.

%Precisa por para não gerar um erro na execução do assert

% Base de fatos e sintomas
sintoma(febre).
sintoma(dor_de_cabeca).
sintoma(tosse).
sintoma(cansaco).
sintoma(dor_de_garganta).
sintoma(dor_muscular).
sintoma(espirro).
sintoma(congestao_nasal).

% Regras de diagnostico
doenca(gripe) :- febre, tosse, cansaco.
doenca(infeccao_viral) :- febre, dor_de_garganta, dor_muscular.
doenca(enxaqueca) :- dor_de_cabeca, cansaco.
doenca(resfriado) :- tosse, espirro, congestao_nasal, dor_de_garganta.

% Perguntar sintomas ao usuario
comecar :-
    write('Bem-vindo ao modulo medico. Vamos tentar identificar o que voce tem.'), nl,
    write('Sistema feito por: Alison Loffi.'), nl,
    write('-----.'), nl,

    write('Voce esta com febre (s/n)? '), read(Resp1), (Resp1 = s -> assert(febre); true),
    write('Voce esta com dor de cabeca (s/n)? '), read(Resp2), (Resp2 = s -> assert(dor_de_cabeca); true),
    write('Voce esta com tosse (s/n)? '), read(Resp3), (Resp3 = s -> assert(tosse); true),
    write('Voce esta com cansaco (s/n)? '), read(Resp4), (Resp4 = s -> assert(cansaco); true),
    write('Voce esta com dor de garganta (s/n)? '), read(Resp5), (Resp5 = s -> assert(dor_de_garganta); true),
    write('Voce esta com dor muscular (s/n)? '), read(Resp6), (Resp6 = s -> assert(dor_muscular); true),
    write('Voce esta com espirros (s/n)? '), read(Resp7), (Resp7 = s -> assert(espirro); true),
    write('Voce esta com congestao nasal (s/n)? '), read(Resp8), (Resp8 = s -> assert(congestao_nasal); true),
    
    % Tentativa de diagnostico
    (doenca(Doenca) -> 
        format('O diagnostico sugerido e: ~w.~n', [Doenca])
    ; 
        write('Sintomas nao identificados. Melhor voce procurar um medico.') 
    ),
    limpar_sintomas.

% Limpar sintomas para nova consulta
limpar_sintomas :-
    retractall(febre),
    retractall(dor_de_cabeca),
    retractall(tosse),
    retractall(cansaco),
    retractall(dor_de_garganta),
    retractall(dor_muscular),
    retractall(espirro),
    retractall(congestao_nasal).
