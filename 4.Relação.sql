USE biblio;

SELECT 
    a.nome AS area_conhecimento,
    o.nome_obra,
    
    COUNT(ex.idExemplar) AS total_volumes_no_acervo,
    
    SUM(CASE 
        WHEN e.idEmprestimo IS NOT NULL AND (d.emprestimo_id IS NULL OR d.data_entregue IS NULL) THEN 1
        ELSE 0
    END) AS volumes_emprestados,

    SUM(CASE 
        WHEN e.idEmprestimo IS NOT NULL 
             AND (d.emprestimo_id IS NULL OR d.data_entregue IS NULL)
             AND e.data_devolucao < CURDATE()
        THEN 1
        ELSE 0
    END) AS volumes_em_atraso,

    COALESCE(SUM(d.valor_multa_pago), 0) AS total_multas_pagas

FROM Obra o
JOIN AreaConhecimento a ON o.area_id = a.id
LEFT JOIN Exemplar ex ON ex.obra_id = o.idLivro
LEFT JOIN Emprestimo e ON e.livro_id = ex.idExemplar
LEFT JOIN Devolucao d ON d.emprestimo_id = e.idEmprestimo

GROUP BY a.nome, o.nome_obra
ORDER BY a.nome, o.nome_obra;
