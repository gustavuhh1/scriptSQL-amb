SELECT 
    DATE_FORMAT(e.data_emprestimo, '%Y-%m') AS mes_ano,
    o.tipo_obra,
    COUNT(DISTINCT e.idEmprestimo) AS total_emprestimos,
    COUNT(DISTINCT o.idLivro) AS total_obras_emprestadas, 
    COALESCE(SUM(d.valor_multa_pago), 0) AS total_multas_pagas
FROM Emprestimo e
JOIN Exemplar ex ON e.livro_id = ex.idExemplar
JOIN Obra o ON ex.obra_id = o.idLivro
LEFT JOIN Devolucao d ON d.emprestimo_id = e.idEmprestimo
WHERE e.data_emprestimo >= DATE_SUB(CURDATE(), INTERVAL 12 MONTH)
GROUP BY mes_ano, o.tipo_obra
ORDER BY mes_ano DESC, o.tipo_obra;
