% Declarando sintomas como fatos dinamicos
:- dynamic motor_nao_liga/0, luzes_fracas/0, barulho_ao_frear/0, pedal_freio_macio/0, 
           vazamento_de_oleo/0, cheiro_de_combustivel/0, aquecimento/0, trepidacao/0.
%Precisa por para não gerar um erro na execução do assert

% Base de sintomas e problemas
sintoma(motor_nao_liga).
sintoma(luzes_fracas).
sintoma(barulho_ao_frear).
sintoma(pedal_freio_macio).
sintoma(vazamento_de_oleo).
sintoma(cheiro_de_combustivel).
sintoma(aquecimento).
sintoma(trepidacao).

% Regras de diagnóstico de problemas e sugestões de solução
solucao(bateria_fraca, 'verificar a bateria do veiculo e considere recarrega-la ou substitui-la.').
solucao(freio_desgastado, 'verificar o sistema de freios e considere substituir as pastilhas de freio.').
solucao(vazamento_oleo, 'verificar o nivel de oleo e inspecione o motor para encontrar o vazamento.').
solucao(fuga_combustivel, 'verificar as conexoes de combustivel e possiveis vazamentos no tanque.').
solucao(superaquecimento, 'verificar o sistema de arrefecimento, incluindo o nivel de agua e o radiador.').
solucao(suspensao_danificada, 'verificar a suspensao do veiculo e considere fazer um alinhamento.').

problema(bateria_fraca) :- motor_nao_liga, luzes_fracas.
problema(freio_desgastado) :- barulho_ao_frear, pedal_freio_macio.
problema(vazamento_oleo) :- vazamento_de_oleo.
problema(fuga_combustivel) :- cheiro_de_combustivel.
problema(superaquecimento) :- aquecimento.
problema(suspensao_danificada) :- trepidacao, barulho_ao_frear.

% Perguntar sintomas ao usuario
comecar :-
  write('Bem-vindo ao modulo mecanico smart. Vamos tentar identificar o que o seu carro tem.'), nl,
  write('Sistema feito por: Alison Loffi.'), nl,
  write('-----.'), nl,

  write('O motor nao liga (s/n)? '), read(Resp1), (Resp1 = s -> assert(motor_nao_liga); true),
  write('As luzes estao fracas (s/n)? '), read(Resp2), (Resp2 = s -> assert(luzes_fracas); true),
  write('Ha barulho ao frear (s/n)? '), read(Resp3), (Resp3 = s -> assert(barulho_ao_frear); true),
  write('O pedal do freio esta macio (s/n)? '), read(Resp4), (Resp4 = s -> assert(pedal_freio_macio); true),
  write('Voce percebe vazamento de oleo (s/n)? '), read(Resp5), (Resp5 = s -> assert(vazamento_de_oleo); true),
  write('Sente cheiro de combustivel (s/n)? '), read(Resp6), (Resp6 = s -> assert(cheiro_de_combustivel); true),
  write('O veiculo esta aquecendo (s/n)? '), read(Resp7), (Resp7 = s -> assert(aquecimento); true),
  write('Percebe trepidacao no veiculo (s/n)? '), read(Resp8), (Resp8 = s -> assert(trepidacao); true),
  
  % Tentativa de diagnóstico e sugestão de solução


  %Assim como no sistema de medico, aqui a busca é simples, com um fallback para sugerir um mecanico.
  (problema(Problema) -> 
      format('O problema que encontramos foi: ~w.~n', [Problema]),
      solucao(Problema, Solucao),
      format('Olha, minha sugestao e ~w~n', [Solucao])
  ; 
      write('Problema nao identificado. Recomendamos consultar um mecanico.') 
  ),
  limpar_sintomas.

% Limpar sintomas para nova consulta
limpar_sintomas :-
  retractall(motor_nao_liga),
  retractall(luzes_fracas),
  retractall(barulho_ao_frear),
  retractall(pedal_freio_macio),
  retractall(vazamento_de_oleo),
  retractall(cheiro_de_combustivel),
  retractall(aquecimento),
  retractall(trepidacao).
