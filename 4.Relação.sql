SELECT 
    e.idEmprestimo,
    u.nome AS nome_usuario,
    f.nome AS nome_gestor,
    o.nome_obra,
    e.data_emprestimo,
    e.data_devolucao,
    DATEDIFF(CURDATE(), e.data_devolucao) AS dias_atraso,
    CASE
        WHEN e.data_devolucao < CURDATE() THEN 'ATRASADO'
        ELSE 'EM DIA'
    END AS status_emprestimo
FROM Emprestimo e
JOIN Usuario u ON e.usuario_id = u.id
JOIN Funcionario f ON e.gestor_id = f.idFuncionario
JOIN Obra o ON e.livro_id = o.idLivro
LEFT JOIN Devolucao d ON e.idEmprestimo = d.emprestimo_id
WHERE d.emprestimo_id IS NULL -- Não devolvidos
ORDER BY e.data_devolucao ASC;
