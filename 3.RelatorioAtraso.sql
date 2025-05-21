SELECT 
    U.id AS id_usuario,
    U.nome AS nome_usuario,
    U.tipo_usuario,
    O.idLivro AS id_obra,
    O.nome_obra AS titulo_obra,
    O.tipo_obra,
    O.genero,
    -- Cálculo de dias em atraso
    DATEDIFF(CURRENT_DATE(), E.data_devolucao) AS dias_em_atraso,
    -- Cálculo da multa (considerando R$2 por dia de atraso)
    DATEDIFF(CURRENT_DATE(), E.data_devolucao) * 2.00 AS multa_calculada,
    -- Extrai o telefone celular do cadastro
    REGEXP_SUBSTR(U.Telefone, '\\(\\d{2}\\)\\s\\d{4,5}-\\d{4}') AS telefone_celular,
    -- Data original de devolução
    E.data_devolucao AS data_prevista_devolucao
FROM 
    Usuario U
JOIN 
    Emprestimo E ON U.id = E.usuario_id
JOIN 
    Obra O ON E.livro_id = O.idLivro
LEFT JOIN 
    Devolucao D ON E.idEmprestimo = D.emprestimo_id
WHERE 
    -- Obras não devolvidas
    D.emprestimo_id IS NULL 
    -- E com data de devolução já vencida
    AND E.data_devolucao < CURRENT_DATE()
ORDER BY 
    dias_em_atraso DESC, U.nome;