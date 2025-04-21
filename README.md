# sql-para-analise-de-dados-udaciy-pt2
Exercícios de curso de SQL para Analise de dados da plataforma Udacity, pt 2 JOINS

## 📚 Conteúdo do Capítulo

Nesta parte do curso, foram abordados os seguintes tópicos:

### 1. **JOINs: Conceito e Aplicações**
- Por que JOINs são necessários em bancos relacionais
- Diferença entre tabelas normalizadas e desnormalizadas

### 2. **Tipos de JOINs**
- **INNER JOIN** – retorna registros com correspondência em ambas as tabelas
- **LEFT JOIN** – retorna todos os registros da tabela à esquerda e os correspondentes da direita (se houver)
- **RIGHT JOIN** – mesmo conceito, mas priorizando a tabela da direita
- **FULL JOIN** – retorna todos os registros, com ou sem correspondência

### 3. **Usando ALIAS**
- Uso de `AS` para renomear colunas e tabelas
- Evita ambiguidade em consultas com colunas de mesmo nome

### 4. **Ordenação e Filtragem após JOINs**
- Uso de `ORDER BY`, `WHERE`, `LIMIT` com JOINs
- Filtragem baseada em colunas específicas de tabelas distintas

### 5. **Consultas Compostas**
- JOINs com múltiplas tabelas
- Combinação de várias tabelas intermediárias para formar uma única consulta analítica

---

## 🗄️ Banco de Dados Utilizado

Durante os exercícios, foi utilizado um **banco de dados fictício** simulado pela Udacity, que representa um cenário de uma empresa de vendas B2B. Este banco inclui as seguintes tabelas principais:

| Tabela         | Descrição                                                |
|----------------|----------------------------------------------------------|
| `region`       | Lista de regiões onde os representantes de vendas atuam |
| `sales_reps`   | Representantes de vendas e a região associada            |
| `accounts`     | Contas/clientes e o representante associado               |
| `orders`       | Pedidos feitos pelas contas, incluindo tipos e quantias  |

Os JOINs realizados nos exercícios têm como objetivo responder perguntas analíticas como:
- Qual região cada conta pertence?
- Qual o preço unitário médio pago em cada pedido?
- Quais representantes têm contas em determinada região?
