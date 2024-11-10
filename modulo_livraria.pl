% Declarando gêneros e interesses como fatos dinâmicos
:- dynamic genero/1, interesse/1.
%Precisa por para não gerar um erro na execução do assert

% Base de dados de livros com gêneros e interesses
livro('1984', ficcao, politica, 'Um romance distopico sobre um regime totalitario que controla todos os aspectos da vida.').
livro('Orgulho e Preconceito', romance, relacoes, 'A historia de Elizabeth Bennet lidando com questoes de casamento, moral e criancas.').
livro('Sapiens', historia, ciencia, 'Uma narrativa sobre a evolucao da especie humana, abordando temas biologicos e culturais.').
livro('O Poder do Habito', autoajuda, psicologia, 'Explora a ciencia por tras da formacao de habitos e como transforma-los.').
livro('A Breve Historia do Tempo', ciencia, fisica, 'Stephen Hawking explica conceitos de fisica como buracos negros e o big bang.').
livro('O Senhor dos Aneis', fantasia, aventura, 'Uma aventura epica para destruir um anel de poder e salvar a Terra Media.').
livro('Dom Quixote', classico, aventura, 'A historia de um homem que acredita ser um cavaleiro em uma jornada comica.').
livro('Mindset', autoajuda, psicologia, 'Analisa como a mentalidade de crescimento pode influenciar o sucesso pessoal.').
livro('Guerra e Paz', classico, historia, 'Um classico que explora a vida de varias familias durante as guerras napoleonicas.').
livro('O Codigo Da Vinci', suspense, misterio, 'Um suspense sobre simbologia e segredos escondidos em obras de arte famosas.').

livro('O Alquimista', ficcao, aventura, 'A jornada de um jovem pastor em busca de um tesouro nos desertos do Egito.').
livro('A Menina que Roubava Livros', ficcao, historia, 'A historia de uma jovem garota na Alemanha nazista que encontra consolo em roubar livros.').
livro('O Pequeno Principe', ficcao, filosofia, 'Um piloto encontra um principe de outro planeta e aprende lições sobre a vida.').
livro('Harry Potter e a Pedra Filosofal', fantasia, aventura, 'A primeira aventura de Harry Potter na escola de magia de Hogwarts.').
livro('O Hobbit', fantasia, aventura, 'A jornada de Bilbo Bolseiro para ajudar um grupo de anões a recuperar seu tesouro.').
livro('Cem Anos de Solidão', ficcao, historia, 'A saga da familia Buendia na cidade ficticia de Macondo.').
livro('A Revolução dos Bichos', ficcao, politica, 'Uma alegoria sobre a revolução russa e o regime soviético.').
livro('O Apanhador no Campo de Centeio', ficcao, psicologia, 'A historia de Holden Caulfield e sua luta contra a hipocrisia do mundo adulto.').
livro('O Nome da Rosa', suspense, misterio, 'Um monge franciscano investiga uma série de assassinatos em um mosteiro italiano.').
livro('A Divina Comedia', classico, filosofia, 'A jornada de Dante pelo Inferno, Purgatório e Paraíso.').



% Regras de recomendação de livros
comecar :-
    write('Bem-vindo ao modulo The Best livraria. Vamos tentar encontrar o melhor livro para voce.'), nl,
    write('Sistema feito por: Alison Loffi.'), nl,
    write('-----.'), nl,

    % Aqui é um pouco mais complicado por que tem muitas conbinacoes possiveis, entao temos que fazer um fallback pelo Genero.
    write('Qual genero tu mais curte? Temos:'), nl,
    write('ficcao, romance, ciencia, autoajuda, fantasia, classico, suspense.'), nl,
    read(Genero), assert(genero(Genero)),
    write('Qual seu interesse principal? Temos: '), nl,
    write('politica, relacoes, ciencia, psicologia, fisica, aventura, historia, misterio, filosofia.'), nl,
    read(Interesse), assert(interesse(Interesse)),
    
    % Recomendação de livro com base no gênero e interesse
    (livro(Titulo, Genero, Interesse, Sinopse) -> 
        format('Recomendamos o livro: ~w.~nSinopse: ~w~n', [Titulo, Sinopse])
    ; 
        (livro(TituloGenero, Genero, _, SinopseGenero) ->
            format('Puxa nao vou ter um livro que combine todas as suas preferencias, porem posso te recomendar o: ~w.~nSinopse: ~w~n', [TituloGenero, SinopseGenero])
        ;
            write('Nenhum livro encontrado com essas preferencias. Melhor voce ir procurar no SEBO')
        )
    ),
    limpar_preferencias.

% Limpar preferências para nova consulta
limpar_preferencias :-
    retractall(genero(_)),
    retractall(interesse(_)).