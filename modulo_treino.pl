% Fatos dinamicos
:- dynamic objetivo/1, experiencia/1, disponibilidade/1.
%Precisa por para não gerar um erro na execução do assert

% Base de fatos para objetivos, experiencias e disponibilidade
objetivo(ganhar_massa).
objetivo(emagrecer).
objetivo(melhorar_condicionamento).
objetivo(manter_saude).

experiencia(iniciante).
experiencia(intermediario).
experiencia(avancado).

disponibilidade(tempo_limitado).
disponibilidade(tempo_aberto).

% Regras para recomendacao de treino
treino(hipertrofia) :- objetivo(ganhar_massa), experiencia(intermediario).
treino(hipertrofia) :- objetivo(ganhar_massa), experiencia(avancado).
treino(tonificacao) :- objetivo(ganhar_massa), experiencia(iniciante).
treino(perda_de_peso) :- objetivo(emagrecer), disponibilidade(tempo_limitado).
treino(perda_de_peso) :- objetivo(emagrecer), experiencia(iniciante).
treino(condicionamento) :- objetivo(melhorar_condicionamento), experiencia(iniciante), disponibilidade(tempo_aberto).
treino(condicionamento) :- objetivo(melhorar_condicionamento), experiencia(intermediario), disponibilidade(tempo_aberto).
treino(manter_saude) :- objetivo(manter_saude), experiencia(iniciante), disponibilidade(tempo_limitado).
treino(manter_saude) :- objetivo(manter_saude), experiencia(iniciante), disponibilidade(tempo_aberto).
treino(manter_saude) :- objetivo(manter_saude), experiencia(intermediario), disponibilidade(tempo_limitado).

%Ate tentei fazer algo mais inteligente mas a quantidade de combinações possiveis é muito grande, então fiz um fallback para um treino básico.

% Regras para detalhamento do treino
detalhes_treino(hipertrofia) :-
    write('Treino para Hipertrofia: '), nl,
    write('Exercicio 1: Supino reto - 4 series de 8-12 repeticoes'), nl,
    write('Exercicio 2: Agachamento - 4 series de 8-12 repeticoes'), nl,
    write('Exercicio 3: Puxada na frente - 3 series de 10-12 repeticoes'), nl.

detalhes_treino(tonificacao) :-
    write('Treino para Tonificacao Muscular: '), nl,
    write('Exercicio 1: Flexoes - 3 series de 12-15 repeticoes'), nl,
    write('Exercicio 2: Afundos - 3 series de 12 repeticoes por perna'), nl,
    write('Exercicio 3: Abdominais - 4 series de 20 repeticoes'), nl.

detalhes_treino(perda_de_peso) :-
    write('Treino para Perda de Peso: '), nl,
    write('Exercicio 1: Corrida na esteira - 30 minutos'), nl,
    write('Exercicio 2: Agachamento com salto - 4 series de 15 repeticoes'), nl,
    write('Exercicio 3: Burpees - 3 series de 12 repeticoes'), nl.

detalhes_treino(condicionamento) :-
    write('Treino para Condicionamento Fisico: '), nl,
    write('Exercicio 1: Flexoes - 4 series de 15 repeticoes'), nl,
    write('Exercicio 2: Corrida intervalada - 20 minutos'), nl,
    write('Exercicio 3: Abdominais - 4 series de 20 repeticoes'), nl.

detalhes_treino(manter_saude) :-
    write('Treino para Mantençao e Saude: '), nl,
    write('Exercicio 1: Caminhada leve - 30 minutos'), nl,
    write('Exercicio 2: Alongamento - 10 minutos'), nl,
    write('Exercicio 3: Abdominais - 3 series de 15 repeticoes'), nl.

% Perguntar ao usuario sobre seu objetivo, experiencia e disponibilidade
comecar :-
    write('Bem-vindo ao sistema de recomendacao de treinos! Vamos tentar encontrar o melhor treino para voce?'), nl,
    write('Sistema feito por: Alison Loffi.'), nl,
    write('-----.'), nl,

    write('Qual seu objetivo? (ganhar_massa, emagrecer, melhorar_condicionamento, manter_saude): '), read(Objetivo),
    assert(objetivo(Objetivo)),
    
    write('Qual seu nivel de experiencia? (iniciante, intermediario, avancado): '), read(Experiencia),
    assert(experiencia(Experiencia)),

    write('Qual sua disponibilidade de tempo? (tempo_limitado, tempo_aberto): '), read(Disponibilidade),
    assert(disponibilidade(Disponibilidade)),

    % Recomendacao de treino baseada nas respostas
    (treino(Treino) -> 
        format('Treino recomendado: ~w.~n', [Treino]),
        detalhes_treino(Treino)
    ; 
        write('Nao temos uma recomendacao especifica para seu perfil, sugerimos uma combinacao basica de treino: caminhada, alongamento e flexoes.') 
    ),
    limpar_parametros.

% Limpar parametros para nova consulta
limpar_parametros :-
    retractall(objetivo(_)),
    retractall(experiencia(_)),
    retractall(disponibilidade(_)).
