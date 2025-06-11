USE biblio;

-- 1. Média de empréstimos por mês por obra (detalhado por mês)
SELECT 
    o.nome_obra,
    YEAR(e.data_emprestimo) AS ano,
    MONTH(e.data_emprestimo) AS mes,
    COUNT(*) AS total_emprestimos_no_mes
FROM Emprestimo e
JOIN Exemplar ex ON e.livro_id = ex.idExemplar
JOIN Obra o ON ex.obra_id = o.idLivro
GROUP BY o.idLivro, ano, mes
ORDER BY o.nome_obra, ano, mes;

-- 2. Média mensal geral por obra (total de empréstimos dividido pelos meses distintos com empréstimos)
SELECT
    o.nome_obra,
    COUNT(*) / COUNT(DISTINCT CONCAT(YEAR(e.data_emprestimo), '-', MONTH(e.data_emprestimo))) AS media_emprestimos_por_mes
FROM Emprestimo e
JOIN Exemplar ex ON e.livro_id = ex.idExemplar
JOIN Obra o ON ex.obra_id = o.idLivro
GROUP BY o.idLivro
ORDER BY media_emprestimos_por_mes DESC;

-- 3. Média de empréstimos por semestre por obra (detalhado por semestre)
SELECT
    o.nome_obra,
    YEAR(e.data_emprestimo) AS ano,
    FLOOR((MONTH(e.data_emprestimo) - 1) / 6) + 1 AS semestre,
    COUNT(*) AS total_emprestimos_no_semestre
FROM Emprestimo e
JOIN Exemplar ex ON e.livro_id = ex.idExemplar
JOIN Obra o ON ex.obra_id = o.idLivro
GROUP BY o.idLivro, ano, semestre
ORDER BY o.nome_obra, ano, semestre;

-- 4. Média semestral geral por obra
SELECT
    o.nome_obra,
    COUNT(*) / COUNT(DISTINCT CONCAT(YEAR(e.data_emprestimo), '-', FLOOR((MONTH(e.data_emprestimo) - 1)/6) + 1)) AS media_emprestimos_por_semestre
FROM Emprestimo e
JOIN Exemplar ex ON e.livro_id = ex.idExemplar
JOIN Obra o ON ex.obra_id = o.idLivro
GROUP BY o.idLivro
ORDER BY media_emprestimos_por_semestre DESC;

-- 5. Popularidade das obras (ranking pelas mais emprestadas)
SELECT 
    o.nome_obra,
    COUNT(*) AS total_emprestimos
FROM Emprestimo e
JOIN Exemplar ex ON e.livro_id = ex.idExemplar
JOIN Obra o ON ex.obra_id = o.idLivro
GROUP BY o.idLivro
ORDER BY total_emprestimos DESC;

-- 6. Histórico de multas por obra (com valores e datas)
SELECT
    o.nome_obra,
    d.valor_multa,
    d.valor_multa_pago,
    d.data_entregue,
    d.data_devolucao,
    e.data_emprestimo,
    u.nome AS nome_usuario
FROM Devolucao d
JOIN Emprestimo e ON d.emprestimo_id = e.idEmprestimo
JOIN Exemplar ex ON e.livro_id = ex.idExemplar
JOIN Obra o ON ex.obra_id = o.idLivro
JOIN Usuario u ON e.usuario_id = u.id
WHERE d.valor_multa > 0
ORDER BY o.nome_obra, d.data_entregue;

-- 7. Relatório resumido geral com médias e totais por obra
SELECT 
    o.nome_obra,
    COUNT(e.idEmprestimo) AS total_emprestimos,
    COUNT(e.idEmprestimo) / COUNT(DISTINCT CONCAT(YEAR(e.data_emprestimo), '-', MONTH(e.data_emprestimo))) AS media_emprestimos_por_mes,
    COUNT(e.idEmprestimo) / COUNT(DISTINCT CONCAT(YEAR(e.data_emprestimo), '-', FLOOR((MONTH(e.data_emprestimo)-1)/6)+1)) AS media_emprestimos_por_semestre,
    IFNULL(SUM(d.valor_multa), 0) AS total_multas,
    IFNULL(SUM(d.valor_multa_pago), 0) AS total_multas_pagas
FROM Obra o
LEFT JOIN Exemplar ex ON ex.obra_id = o.idLivro
LEFT JOIN Emprestimo e ON e.livro_id = ex.idExemplar
LEFT JOIN Devolucao d ON d.emprestimo_id = e.idEmprestimo
GROUP BY o.idLivro
ORDER BY total_emprestimos DESC;


