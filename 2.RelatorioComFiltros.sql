-- Relatório de Estatísticas de Uso por Obra (Versão Corrigida)
SELECT 
    O.idLivro,
    O.nome_obra AS titulo_obra,
    O.autor,
    O.tipo_obra,
    O.genero,
    
    -- Estatísticas básicas
    COUNT(E.idEmprestimo) AS total_emprestimos,
    
    -- Médias temporais
    ROUND(COUNT(E.idEmprestimo) / 
          GREATEST(TIMESTAMPDIFF(MONTH, MIN(E.data_emprestimo), NOW()), 1), 2) AS media_mensal,
    
    ROUND(COUNT(E.idEmprestimo) / 
          GREATEST(TIMESTAMPDIFF(MONTH, MIN(E.data_emprestimo), NOW()) / 6, 1), 2) AS media_semestral,
    
    -- Popularidade (ranking)
    RANK() OVER (ORDER BY COUNT(E.idEmprestimo) DESC) AS ranking_popularidade,
    
    -- Histórico de multas
    COALESCE(SUM(D.valor_multa), 0) AS total_multas_geradas,
    COUNT(CASE WHEN D.valor_multa > 0 THEN 1 END) AS qtd_atrasos,
    ROUND(COALESCE(SUM(D.valor_multa), 0) / 
          GREATEST(COUNT(CASE WHEN D.valor_multa > 0 THEN 1 END), 1), 2) AS media_multa_por_atraso,
    
    -- Detalhamento temporal
    SUM(CASE WHEN E.data_emprestimo >= DATE_SUB(NOW(), INTERVAL 6 MONTH) THEN 1 ELSE 0 END) AS emprestimos_ultimo_semestre,
    SUM(CASE WHEN E.data_emprestimo >= DATE_SUB(NOW(), INTERVAL 1 MONTH) THEN 1 ELSE 0 END) AS emprestimos_ultimo_mes,
    
    -- Data do último empréstimo
    MAX(E.data_emprestimo) AS ultimo_emprestimo
    
FROM 
    Obra O
LEFT JOIN 
    Emprestimo E ON O.idLivro = E.livro_id
LEFT JOIN 
    Devolucao D ON E.idEmprestimo = D.emprestimo_id
GROUP BY 
    O.idLivro, O.nome_obra, O.autor, O.tipo_obra, O.genero
ORDER BY 
    total_emprestimos DESC;