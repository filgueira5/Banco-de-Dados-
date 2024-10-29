SELECT id, nome, quant_minima, unidade_medida FROM Produto
    order by nome;

SELECT id, nome FROM Mercado 
    order by nome desc;

SELECT id, id * 1000, nome FROM Mercado;

SELECT id, mercado_id, produto_id, preco FROM Pesquisa 
    order by mercado_id, produto_id;

SELECT codigo, nome FROM Cesta 
    order by codigo;

SELECT id, cesta_codigo, produto_id, quantidade FROM Produto_Cesta
    order by id;

SELECT nome, id, unidade_medida FROM Produto
    order by id desc;

SELECT nome, unidade_medida, id FROM Produto 
    order by nome;

SELECT Cesta.codigo, Cesta.nome, Produto_Cesta.quantidade, Produto.unidade_medida, Produto.nome FROM Pesquisa 
    JOIN Produto on Pesquisa.produto_id = produto.id
    JOIN Produto_Cesta on Produto.

SELECT Produto.id, Produto.nome, Mercado.id, Mercado.nome, Pesquisa.preco FROM Pesquisa
    JOIN Produto on Pesquisa.produto_id = produto.id
    JOIN Mercado on Pesquisa.mercado_id = mercado.id
    order by produto.nome, Mercado.nome;

SELECT Produto.id, Produto.nome, Mercado.id, Mercado.nome, Pesquisa.preco FROM Pesquisa
    JOIN Produto on Pesquisa.produto_id = produto.id
    JOIN Mercado on Pesquisa.mercado_id = mercado.id
    order by Produto.nome, Pesquisa.preco; 

SELECT Mercado.id, Mercado.nome, Produto.id, Produto.nome, Pesquisa.preco FROM Pesquisa 
    JOIN Mercado on Pesquisa.mercado_id = mercado.id
    JOIN Produto on Pesquisa.produto_id = produto.id
    order by Mercado.nome, Produto.nome;

SELECT Mercado.nome, Produto.nome, Pesquisa.preco FROM Pesquisa
    JOIN Mercado on Pesquisa.mercado_id = mercado.id
    JOIN Produto on Pesquisa.produto_id = produto.id
    WHERE Mercado.nome = 'Quitanda do Zé'
    order by Produto.nome;

SELECT Cesta.codigo, Cesta.nome, Mercado.id, Mercado.nome, Produto_Cesta.quantidade, Produto.unidade_medida, Produto.nome, Pesquisa.preco, (quantidade * preco ) AS preco_total FROM Pesquisa
    JOIN Produto on Pesquisa.produto_id = produto.id
    JOIN Mercado on Pesquisa.mercado_id = mercado.id
    JOIN Produto_Cesta on Produto_Cesta.produto_id = produto.id
    JOIN Cesta on Produto_Cesta.cesta_codigo = cesta.codigo
    order by Cesta.codigo, Mercado.nome, Produto.nome;