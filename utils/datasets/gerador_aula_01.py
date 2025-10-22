import csv
import random
from faker import Faker
from datetime import date
import calendar

# -------------------------------
# CONFIGURAÇÕES GERAIS
# -------------------------------
SEED = 42
random.seed(SEED)
faker = Faker('pt_BR')
Faker.seed(SEED)

NUM_FILES = 4
ROWS_PER_FILE = 800_000  # ~800k por arquivo -> ~3,2M no total
OUT_SALES_PATTERN = "vendas_{i}.csv"
OUT_CUSTOMERS = "clientes.csv"

# Catálogo (nome, categoria, preço_mín, preço_máx)
CATALOGO = [
    ("Camiseta Básica", "Roupas", 39.90, 89.90),
    ("Calça Jeans", "Roupas", 99.90, 249.90),
    ("Tênis Esportivo", "Calçados", 179.90, 699.90),
    ("Boné", "Acessórios", 29.90, 99.90),
    ("Relógio Digital", "Acessórios", 149.90, 799.90),
    ("Mochila", "Acessórios", 79.90, 399.90),
    ("Jaqueta Jeans", "Roupas", 149.90, 349.90),
    ("Meias (par)", "Roupas", 9.90, 29.90),
    ("Sandália", "Calçados", 49.90, 199.90),
    ("Camisa Social", "Roupas", 119.90, 299.90),
]

METODOS_PGTO = ["Pix", "Cartão de Crédito", "Cartão de Débito", "Boleto"]
METODOS_PESOS = [0.35, 0.45, 0.15, 0.05]  # distribuição aproximada

# -------------------------------
# JANELA DE DATAS + SAZONALIDADE
# -------------------------------
# Período: 2020-01-01 até 2025-10-31 (2025 só até outubro)
ANOS = [2020, 2021, 2022, 2023, 2024, 2025]

# Sazonalidade mensal (base = 1.0)
# - Dez (Natal) 2.2, Jan (pós-festas) 1.6, Jun/Jul 1.25, Nov (Black Friday) 1.35
# - Meses restantes ~1.0, com pequenos ajustes realistas
SAZONALIDADE_MES = {
    1: 1.60,  # Jan (pós-festas)
    2: 0.95,
    3: 1.00,
    4: 1.05,
    5: 1.00,
    6: 1.25,  # Jun
    7: 1.25,  # Jul
    8: 0.95,
    9: 1.00,
    10: 1.05,
    11: 1.35, # Black Friday
    12: 2.20  # Natal
}

# Crescimento anual (market/brand growth)
CRESC_ANO = {
    2020: 0.80,
    2021: 0.95,
    2022: 1.10,
    2023: 1.20,
    2024: 1.30,
    2025: 1.35,  # só até outubro (ajustaremos os meses válidos)
}

# Monta lista de (ano, mes, dias_no_mes, peso) para amostragem ponderada
meses_validos = []
pesos_meses = []
for ano in ANOS:
    for mes in range(1, 13):
        # Pular Nov-Dez de 2025? Não: 2025 deve ir até outubro
        if ano == 2025 and mes > 10:
            continue
        # dias no mês
        _, ndias = calendar.monthrange(ano, mes)
        peso = SAZONALIDADE_MES[mes] * CRESC_ANO[ano]
        meses_validos.append((ano, mes, ndias))
        pesos_meses.append(peso)

# -------------------------------
# CLIENTES (20 no total, 4 whales)
# -------------------------------
def gerar_clientes(n_total=20, n_whales=4):
    clientes = []
    for i in range(n_total):
        cid = f"CUST{i+1:04d}"
        nome = faker.name()
        email = faker.email()
        cidade = faker.city()
        estado = faker.estado_sigla()
        clientes.append({
            "cliente_id": cid,
            "nome": nome,
            "email": email,
            "cidade": cidade,
            "estado": estado,
            "segmento": "VIP" if i < n_whales else "Regular"
        })
    return clientes

clientes = gerar_clientes()

# Probabilidade de compra por cliente (VIPs compram MUITO mais)
pesos_clientes = []
for c in clientes:
    if c["segmento"] == "VIP":
        pesos_clientes.append(18.0)   # ajuste aqui se quiser VIPs ainda mais fortes
    else:
        pesos_clientes.append(1.0)

# -------------------------------
# AMOSTRAGEM DE DATA COM PESO
# -------------------------------
def sample_data_ponderada():
    # escolhe (ano, mes) com pesos; depois sorteia dia válido
    (ano, mes, ndias) = random.choices(meses_validos, weights=pesos_meses, k=1)[0]
    dia = random.randint(1, ndias)
    return date(ano, mes, dia)

# -------------------------------
# GERAR UMA LINHA DE VENDA
# -------------------------------
def gerar_venda(order_idx: int):
    # cliente
    cliente = random.choices(clientes, weights=pesos_clientes, k=1)[0]

    # produto e preço
    prod, cat, pmin, pmax = random.choice(CATALOGO)
    preco = round(random.uniform(pmin, pmax), 2)

    # whales tendem a comprar mais itens por pedido
    if cliente["segmento"] == "VIP":
        quantidade = random.randint(2, 8)
    else:
        quantidade = random.randint(1, 5)

    valor_total = round(preco * quantidade, 2)

    # método de pagamento
    metodo_pagto = random.choices(METODOS_PGTO, weights=METODOS_PESOS, k=1)[0]

    # data ponderada por sazonalidade/ano
    d = sample_data_ponderada()

    # ID de venda
    order_id = f"ORD{order_idx:012d}"

    return {
        "id_venda": order_id,
        "data_venda": d.isoformat(),
        "produto": prod,
        "categoria": cat,
        "preco_unitario": f"{preco:.2f}",
        "quantidade": quantidade,
        "valor_total": f"{valor_total:.2f}",
        "metodo_pagamento": metodo_pagto,
        "cliente_id": cliente["cliente_id"],
        "nome_cliente": cliente["nome"],
        "email_cliente": cliente["email"],
        "cidade": cliente["cidade"],
        "estado": cliente["estado"],
        "segmento_cliente": cliente["segmento"]
    }

# -------------------------------
# GRAVAR CLIENTES
# -------------------------------
with open(OUT_CUSTOMERS, "w", newline="", encoding="utf-8") as f:
    writer = csv.DictWriter(f, fieldnames=[
        "cliente_id","nome","email","cidade","estado","segmento"
    ])
    writer.writeheader()
    writer.writerows(clientes)

print(f"✅ Arquivo de clientes gerado: {OUT_CUSTOMERS}")

# -------------------------------
# GERAR VENDAS (4 x ~800k)
# -------------------------------
header = [
    "id_venda","data_venda","produto","categoria","preco_unitario",
    "quantidade","valor_total","metodo_pagamento","cliente_id",
    "nome_cliente","email_cliente","cidade","estado","segmento_cliente"
]

global_order_idx = 1

for i in range(1, NUM_FILES + 1):
    file_name = OUT_SALES_PATTERN.format(i=i)
    total = ROWS_PER_FILE
    print(f"▶️  Gerando {file_name} com {total:,} linhas...")
    with open(file_name, "w", newline="", encoding="utf-8") as f:
        writer = csv.DictWriter(f, fieldnames=header)
        writer.writeheader()
        # escrever em blocos melhora um pouco a performance
        buffer = []
        buf_size = 50_000
        for _ in range(total):
            buffer.append(gerar_venda(global_order_idx))
            global_order_idx += 1
            if len(buffer) >= buf_size:
                writer.writerows(buffer)
                buffer.clear()
        if buffer:
            writer.writerows(buffer)
            buffer.clear()
    print(f"✅ {file_name} pronto.")
