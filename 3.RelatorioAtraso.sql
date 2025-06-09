USE biblio;

SELECT 
    u.nome AS nome_usuario,
    o.tipo_obra,
    DATEDIFF(CURDATE(), e.data_devolucao) AS dias_atraso,
    -- Calculando multa de R$ 1,00 por dia de atraso (ajuste o valor conforme necessário)
    CASE 
        WHEN DATEDIFF(CURDATE(), e.data_devolucao) > 0 THEN DATEDIFF(CURDATE(), e.data_devolucao) * 1.00
        ELSE 0
    END AS valor_multa_atualizada,
    u.Telefone AS telefone_celular
FROM Emprestimo e
JOIN Usuario u ON e.usuario_id = u.id
JOIN Exemplar ex ON e.livro_id = ex.idExemplar
JOIN Obra o ON ex.obra_id = o.idLivro
LEFT JOIN Devolucao d ON d.emprestimo_id = e.idEmprestimo
WHERE e.data_devolucao < CURDATE()
  AND (d.emprestimo_id IS NULL OR d.data_entregue IS NULL)
ORDER BY dias_atraso DESC;
