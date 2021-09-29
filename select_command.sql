-- Selecionando todos os autores
SELECT * FROM autores;

-- Selecionando os generos mais usados
SELECT 
    g.*,
    COUNT(l) AS quantidade_livros
FROM generos g, genero_livro gl, livros l
WHERE gl.genero_id = g.id AND l.id = gl.livro_id
GROUP BY g.id
ORDER BY COUNT(l) DESC;

-- Selecionando todos os autores e as editoras as quais ele já se relacionou 
SELECT 
    autor.*,
    STRING_AGG(editora.nome, ', ')
FROM autores AS autor
INNER JOIN autor_livro ON autor_livro.autor_id = autor.id
INNER JOIN livros AS livro ON livro.id = autor_livro.livro_id
INNER JOIN editoras AS editora ON livro.id = editora.id
GROUP BY autor.id;

-- Selecionando todas as editoras e a quantidade de livros publicados
SELECT 
    editora.*,
	STRING_AGG(CAST(livro.id AS VARCHAR), ', ') AS livro_ids,
    COUNT(livro) AS quantidade_livros_publicados
FROM editoras AS editora
INNER JOIN livros AS livro ON editora.id = livro.editora_id 
GROUP BY editora.id;

-- Selecionando todos os livros do mais novo ao mais velho com os dados de genero, autor e editora
SELECT 
	livro.id,
    livro.titulo, 
    livro.paginas, 
    autor.nome AS autor, 
    editora.nome AS editora,
	STRING_AGG(genero.nome, ', ') AS generos

FROM livros AS livro
INNER JOIN editoras AS editora ON livro.editora_id = editora.id

INNER JOIN autor_livro AS al ON al.livro_id = livro.id
INNER JOIN autores AS autor ON autor.id = al.autor_id

INNER JOIN genero_livro AS gl ON gl.livro_id = livro.id
INNER JOIN generos AS genero ON genero.id = gl.genero_id
WHERE autor.sexo = 'F'
GROUP BY livro.id, autor.id, editora.id
ORDER BY livro.adicionado_em;


