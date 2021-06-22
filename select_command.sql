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

GROUP BY livro.id, autor.id, editora.id