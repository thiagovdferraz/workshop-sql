-- Criação de um TRIGGER
CREATE OR REPLACE FUNCTION func_verifica_estoque() RETURNS TRIGGER AS $$
DECLARE
    qtde_atual INTEGER;
BEGIN
    SELECT qtde_disponivel INTO qtde_atual
    FROM Produto WHERE cod_prod = NEW.cod_prod;
    IF qtde_atual < NEW.qtde_vendida THEN
        RAISE EXCEPTION 'Quantidade indisponivel em estoque';
    ELSE
        UPDATE Produto SET qtde_disponivel = qtde_disponivel - NEW.qtde_vendida
        WHERE cod_prod = NEW.cod_prod;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_verifica_estoque 
BEFORE INSERT ON RegistroVendas
FOR EACH ROW 
EXECUTE FUNCTION func_verifica_estoque();