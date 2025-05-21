SELECT 
    DATE_FORMAT(E.data_emprestimo, '%Y-%m') AS mes_ano,
    COUNT(E.idEmprestimo) AS total_emprestimos,
    COUNT(DISTINCT E.usuario_id) AS usuarios_ativos,
    GROUP_CONCAT(DISTINCT O.tipo_obra) AS tipos_obra,
    SUM(CASE WHEN O.tipo_obra = 'Livro' THEN 1 ELSE 0 END) AS qtd_livros,
    SUM(CASE WHEN O.tipo_obra = 'Revista' THEN 1 ELSE 0 END) AS qtd_revistas,
    SUM(CASE WHEN O.tipo_obra = 'Quadrinho' THEN 1 ELSE 0 END) AS qtd_quadrinhos,
    COALESCE(SUM(D.valor_multa), 0) AS total_multas,
    SUM(CASE WHEN O.tipo_obra = 'Livro' THEN COALESCE(D.valor_multa, 0) ELSE 0 END) AS multas_livros,
    SUM(CASE WHEN O.tipo_obra = 'Revista' THEN COALESCE(D.valor_multa, 0) ELSE 0 END) AS multas_revistas,
    SUM(CASE WHEN O.tipo_obra = 'Quadrinho' THEN COALESCE(D.valor_multa, 0) ELSE 0 END) AS multas_quadrinhos
FROM 
    Emprestimo E
JOIN 
    Obra O ON E.livro_id = O.idLivro
LEFT JOIN 
    Devolucao D ON E.idEmprestimo = D.emprestimo_id
WHERE 
    E.data_emprestimo >= DATE_SUB(NOW(), INTERVAL 12 MONTH)
GROUP BY 
    DATE_FORMAT(E.data_emprestimo, '%Y-%m')
ORDER BY 
    mes_ano DESC;