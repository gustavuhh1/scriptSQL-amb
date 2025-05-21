-- Primeiro, vamos criar uma tabela temporária para mapear as obras por área do conhecimento
WITH ObrasPorArea AS (
    SELECT 
        O.idLivro,
        O.nome_obra AS titulo_obra,
        O.autor,
        O.tipo_obra,
        O.genero,
        CASE
            WHEN O.tags LIKE '%banco de dados%' OR O.nome_obra LIKE '%SQL%' OR O.nome_obra LIKE '%database%' THEN 'Banco de Dados'
            WHEN O.tags LIKE '%programação%' OR O.genero LIKE '%Informática%' THEN 'Programação'
            WHEN O.tags LIKE '%saúde%' OR O.genero LIKE '%Medicina%' THEN 'Saúde'
            WHEN O.tags LIKE '%psicologia%' OR O.genero LIKE '%Psicologia%' THEN 'Psicologia'
            WHEN O.tags LIKE '%matemática%' OR O.genero LIKE '%Matemática%' THEN 'Matemática'
            WHEN O.tags LIKE '%administração%' OR O.genero LIKE '%Negócios%' THEN 'Administração'
            WHEN O.tags LIKE '%direito%' OR O.genero LIKE '%Jurídico%' THEN 'Direito'
            WHEN O.tags LIKE '%engenharia%' OR O.genero LIKE '%Técnico%' THEN 'Engenharia'
            ELSE 'Outros'
        END AS area_conhecimento
    FROM 
        Obra O
)

SELECT 
    oa.area_conhecimento AS 'Área do Conhecimento',
    COUNT(DISTINCT oa.idLivro) AS 'Quantidade de Obras no Acervo',
    
    -- Quantidade de volumes emprestados
    SUM(CASE WHEN E.idEmprestimo IS NOT NULL THEN 1 ELSE 0 END) AS 'Volumes Emprestados',
    
    -- Quantidade de volumes em atraso
    SUM(CASE WHEN E.idEmprestimo IS NOT NULL AND D.emprestimo_id IS NULL 
              AND E.data_devolucao < CURRENT_DATE() THEN 1 ELSE 0 END) AS 'Volumes em Atraso',
    
    -- Valores pagos em multas
    COALESCE(SUM(D.valor_multa), 0) AS 'Total em Multas (R$)',
    
    -- Detalhamento por status
    COUNT(DISTINCT CASE WHEN E.idEmprestimo IS NOT NULL AND D.emprestimo_id IS NOT NULL 
                        THEN oa.idLivro END) AS 'Obras Já Devolvidas',
    
    COUNT(DISTINCT CASE WHEN E.idEmprestimo IS NOT NULL AND D.emprestimo_id IS NULL 
                        AND E.data_devolucao >= CURRENT_DATE() 
                        THEN oa.idLivro END) AS 'Obras Emprestadas (no prazo)',
    
    COUNT(DISTINCT CASE WHEN E.idEmprestimo IS NOT NULL AND D.emprestimo_id IS NULL 
                        AND E.data_devolucao < CURRENT_DATE() 
                        THEN oa.idLivro END) AS 'Obras Emprestadas (em atraso)',
    
    -- Taxa de atraso por área
    ROUND(100 * SUM(CASE WHEN E.idEmprestimo IS NOT NULL AND D.emprestimo_id IS NULL 
                         AND E.data_devolucao < CURRENT_DATE() THEN 1 ELSE 0 END) /
          NULLIF(SUM(CASE WHEN E.idEmprestimo IS NOT NULL THEN 1 ELSE 0 END), 1), 2) AS 'Taxa de Atraso (%)'
FROM 
    ObrasPorArea oa
LEFT JOIN 
    Emprestimo E ON oa.idLivro = E.livro_id
LEFT JOIN 
    Devolucao D ON E.idEmprestimo = D.emprestimo_id
GROUP BY 
    oa.area_conhecimento
ORDER BY 
    COUNT(DISTINCT oa.idLivro) DESC;