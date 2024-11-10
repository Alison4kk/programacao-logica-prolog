% Fatos dinamicos
:- dynamic impressao_digital/1, motivo/1, testemunha/1, relacao/1, alibi/1.
%Precisa por para não gerar um erro na execução do assert

% Base de fatos para evidencias e testemunhos
impressao_digital(lugar_crime).
motivo(financeiro).
motivo(passional).
testemunha(visto_discutindo).
testemunha(visto_no_lugar_crime).
relacao(intima).
relacao(amigo_proximo).

% Suspeitos e teorias baseados em evidencias
suspeito(jose) :- impressao_digital(lugar_crime), motivo(financeiro).
suspeito(maria) :- testemunha(visto_discutindo), relacao(intima).
suspeito(ana) :- impressao_digital(lugar_crime), motivo(passional).
suspeito(pedro) :- testemunha(visto_no_lugar_crime), motivo(financeiro).

% Teorias do crime
teoria(crime_passional) :- testemunha(visto_discutindo), relacao(intima).
teoria(crime_financeiro) :- motivo(financeiro), (suspeito(jose); suspeito(pedro)).
teoria(crime_espontaneo) :- testemunha(visto_no_lugar_crime), relacao(amigo_proximo).

% Regras para recomendações de investigação
recomendar_investigar(Alibi) :- alibi(Alibi), write('Verificar alibi: '), write(Alibi), nl.

% Perguntar ao usuario sobre o caso
comecar :-
    write('Bem-vindo ao sistema de analise de investigacao criminal! Vamos iniciar a investigacao?'), nl,
    write('Sistema feito por: Alison Loffi.'), nl,
    write('-----.'), nl,

    write('Houve impressao digital no lugar do crime (s/n)? '), read(Resp1), 
    (Resp1 = s -> assert(impressao_digital(lugar_crime)); true),

    write('Qual o motivo possivel para o crime? (financeiro, passional): '), read(Motivo),
    assert(motivo(Motivo)),

    write('Houve alguma testemunha ocular? (visto_discutindo, visto_no_lugar_crime): '), read(Testemunha),
    assert(testemunha(Testemunha)),

    write('Qual a relacao entre a testemunha e o suspeito? (intima, amigo_proximo): '), read(Relacao),
    assert(relacao(Relacao)),

    write('O suspeito tem alibi? (s/n): '), read(Alibi),
    (Alibi = s -> assert(alibi(tem_alibi)); true),

    % Suspeitos e teorias
    (suspeito(Suspeito) -> 
        format('Suspeito possivel: ~w.~n', [Suspeito])
    ; 
        write('Nenhum suspeito encontrado com base nas evidencias fornecidas.') 
    ),

    % Teorias do crime
    (teoria(Teoria) -> 
        format('Teoria do crime: ~w.~n', [Teoria])
    ; 
        write('Nao foi possivel identificar uma teoria conclusiva sobre o crime.') 
    ),

    % Recomendar investigacao
    recomendar_investigar(Alibi),

    limpar_parametros.

% Limpar parametros para nova consulta
limpar_parametros :-
    retractall(impressao_digital(_)),
    retractall(motivo(_)),
    retractall(testemunha(_)),
    retractall(relacao(_)),
    retractall(alibi(_)).
