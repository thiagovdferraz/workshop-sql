CALL realizar_transacao('d', 'amarelo', 80, '696bf0bd-3b36-4814-8108-d361a4ee8ff6');

SELECT * FROM clients;
SELECT * FROM transactions;

CALL realizar_transacao('d', 'azul', 14500, 'b9db5be4-e239-4355-909e-d24dc73eb84b');
CALL realizar_transacao('c', 'verde', 454500, 'b9db5be4-e239-4355-909e-d24dc73eb84b');

CALL ver_extrato('b9db5be4-e239-4355-909e-d24dc73eb84b');