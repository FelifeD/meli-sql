# meli-sql

## Resumo do conteúdo
Construção de um diagrama de entidade relacionamento para as tabelas fictícias: Customer, Order, Item e Category.
Queries que respondam os pontos levantados pelo desafio:
- Liste usuários com aniversário de hoje cujo número de vendas realizadas em janeiro de 2020 seja superior a 1.500.
- Para cada mês de 2020, são solicitados os 5 principais usuários que mais venderam ($) na categoria Celulares. São obrigatórios o mês e ano da análise, nome e sobrenome do vendedor, quantidade de vendas realizadas, quantidade de produtos vendidos e valor total transacionado.
- É solicitada uma nova tabela a ser preenchida com o preço e status dos Itens no final do dia. Lembre-se de que deve ser reprocessável. Vale ressaltar que na tabela Item teremos apenas o último status informado pelo PK definido. (Pode ser resolvido através de StoredProcedure)


## arquivos
- **"create_tables.sql":** contém o script DDL para gerar as tabelas
- **"respuestas_negocio.sql":** contém o script SQL com as queries necessárias para resolver as questões


## Diagrama de Entidade Relacionamento
LINK para acessar dreto no dbdiagram: https://dbdiagram.io/d/meli_der_negocio_fd-60aed44db29a09603d16b361

![meli_der](https://github.com/user-attachments/assets/5c828a07-b8d4-4d6f-b745-875ddab9f7aa)
