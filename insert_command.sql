-- inserindo dados de autores
INSERT INTO autores
	(nome, sexo)
VALUES
	('Friedrich Nietzsche', 'M'),
	('Augusto Cury', 'M'),
	('Nicholas Sparks', 'M'),
	('Clarice Lispector', 'F'),
	('George R. R. Martin', 'M'),
	('Agatha Christie', 'F'),
	('J.K. Rowling', 'F'),
	('Bernard Cornwell', 'M'),
	('John Green', 'M');

	
-- Inserindo dados de generos
INSERT INTO generos
	(nome)
VALUES
	('Suspense'),
	('Conto'),
	('Crônica'),
	('Ensaio'),
	('Poesia'),
	('Carta'),
	('Aventura'),
	('Drama'),
	('Literatura fantástica'),
	('Realismo Mágico'),
	('Romance'),
	('Terror');
	
-- Inserindo dados de editoras
INSERT INTO editoras
	(nome)
VALUES
	('Saraiva'),
	('Arqueiro'),
	('Rocco'),
	('Suma'),
	('Globo Livros'),
	('Rocco'),
	('Panini'),
	('Record'),
	('Intrínseca');

-- Inserindo Livro de Nietzsche com os generos de Romance Poesia e Terror
DO $$ 
DECLARE
	novo_livro_id livros.id%type;
BEGIN 
	INSERT INTO livros(titulo, paginas, editora_id)
	SELECT'O Anticristo', 128, id
	FROM editoras AS editora
	WHERE editora.nome = 'Saraiva'
	RETURNING id INTO novo_livro_id;
	
	INSERT INTO autor_livro (livro_id, autor_id)
	SELECT novo_livro_id, autor.id
	FROM autores AS autor WHERE autor.nome = 'Friedrich Nietzsche';
	
	INSERT INTO genero_livro(livro_id, genero_id)
	SELECT novo_livro_id, genero.id
	FROM generos AS genero 
	WHERE genero.nome in ('Romance', 'Terror', 'Suspense');
	
END $$;

-- Inserindo Livro de George R. R. Martin com os generos de Crônica, Crônica, Literatura fantástica
DO $$ 
DECLARE
	novo_livro_id livros.id%type;
BEGIN 
	INSERT INTO livros(titulo, paginas, editora_id)
	SELECT 'A Crônicas do Gelo e do Fogo', 600, id
	FROM editoras AS editora
	WHERE editora.nome = 'Globo Livros'
	RETURNING id INTO novo_livro_id;
	
	INSERT INTO autor_livro (livro_id, autor_id)
	SELECT novo_livro_id, autor.id
	FROM autores AS autor WHERE autor.nome = 'Agatha Christie';
	
	INSERT INTO genero_livro(livro_id, genero_id)
	SELECT novo_livro_id, genero.id
	FROM generos AS genero 
	WHERE genero.nome in ('Realismo Mágico', 'Crônica', 'Literatura fantástica');
END $$;