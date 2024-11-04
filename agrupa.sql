SELECT id, forma, cor, tamanho FROM Objeto 
    ORDER BY id; 

SELECT id, forma, cor, tamanho FROM Objeto 
    WHERE cor = 'amarelo';

SELECT id, forma, cor, tamanho FROM Objeto 
    WHERE forma = 'círculo' AND cor = 'amarelo'
    ORDER BY tamanho DESC;

SELECT DISTINCT tamanho FROM Objeto
    ORDER BY tamanho;

SELECT DISTINCT forma FROM Objeto
    ORDER BY forma;

SELECT DISTINCT forma, tamanho FROM Objeto
    ORDER BY forma, tamanho;

SELECT forma, tamanho, COUNT(forma) FROM Objeto
    GROUP BY forma, tamanho
    ORDER BY forma, tamanho;

SELECT DISTINCT forma, COUNT(forma) FROM Objeto
    GROUP BY forma
    ORDER BY forma DESC;

SELECT DISTINCT tamanho, COUNT(tamanho) FROM Objeto
    GROUP BY tamanho;

SELECT DISTINCT tamanho, COUNT(tamanho) FROM Objeto
    GROUP BY tamanho
    ORDER BY COUNT(tamanho) DESC;

SELECT DISTINCT forma, MAX(tamanho) FROM Objeto
    GROUP BY forma;

SELECT DISTINCT cor, MIN(tamanho) FROM Objeto
    GROUP BY cor;

SELECT DISTINCT forma, COUNT(forma), MAX(id) AS "id_maximo", MIN(tamanho) AS "tamanho_min", MAX(tamanho) AS "tamanho_max" FROM Objeto
    GROUP BY forma
    ORDER BY forma DESC;

SELECT id,forma FROM Objeto
    WHERE forma = 'triângulo'
    GROUP BY id, forma
    ORDER BY id;

SELECT cor, AVG(tamanho), AVG(tamanho)::numeric(8,2) FROM Objeto
    GROUP BY cor;

SELECT DISTINCT AVG(tamanho),forma FROM Objeto
    GROUP BY forma
    ORDER BY forma DESC;

    SELECT cor, MAX(forma) FROM Objeto 
        GROUP BY cor;

SELECT DISTINCT forma FROM Objeto
    ORDER BY forma;

SELECT cor FROM Objeto 
    ORDER BY cor;

SELECT DISTINCT cor, LENGTH(cor) FROM Objeto 
    ORDER BY cor;

SELECT MIN(cor), MAX(cor), MIN(tamanho), MAX(tamanho), MIN(forma), MAX(forma), MIN(LENGTH(cor)), MAX(LENGTH(cor)) FROM Objeto;