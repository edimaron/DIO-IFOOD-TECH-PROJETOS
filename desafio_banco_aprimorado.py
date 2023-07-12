usuarios = []
contas = []
numero_conta = 1
agencia = "0001"
deposito = 0
saldo = 0
limite = 500
extrato = ""
numero_saques = 0
LIMITES_SAQUES = 3

def func_adicionar_novo_usuario(usuarios):
    print("Adicionar novo usuário selecionado\n")
    cpf = input("Digite o CPF do novo usuário (somente números): ")
    for usuario in usuarios:
        if usuario["cpf"] == cpf:
            print("Este CPF já estar cadastrado, informe um novo número de CPF")
            return usuarios
        
    nome = input("Digite o nome do novo usuário: ")
    data_nascimento = input("Digite a data de nascimento do novo usuário (dd/mm/aaaa):  ")
    endereco = input("Digite o endereço do novo usuário (logradouro, número - bairro - Cidade/UF): ")
    usuario = {"cpf":cpf, "nome": nome, "data_nascimento": data_nascimento, "endereco": endereco}
    usuarios.append(usuario)
    print("Usuário cadastrado com sucesso")
    return usuarios

def func_criar_conta(agencia, usuarios):
    global numero_conta
    print("Criar nova conta selecionada\n")
    cpf = input("Digite o CPF (somente números) do usuário para criar a conta ")
    usuario = None
    for n in usuarios:
        if n["cpf"] == cpf:
            usuario = n
            break
    
    if usuario is None:
        print("Este CPF não foi encontrado, cadastre um novo usuário")
        return contas
        
    conta = {"agencia": agencia, "numero_conta": numero_conta, "usuario": usuario}
    contas.append(conta)
    numero_conta += 1
    print("Conta cadastrada com sucesso!")
    return contas
      
def func_listar_contas(contas):
    print("\nLista de contas correntes selecionada: ")
    for conta in contas:
        print(f"Agência: {conta['agencia']} | Número da conta: {conta['numero_conta']} | Titular: {conta['usuario']['nome']}")
    print()

def func_deposito(deposito, extrato, saldo, /):
    print("Depósito selecionado")
    deposito = float(input("Digite a quantia a ser depositada: R$ "))
    
    if deposito > 0:
        extrato += f"Depósito R$ {deposito:.2f} \n"
        saldo += deposito
        print(f"Depósito de R$ {deposito:.2f} realizado com sucesso.")
        print(f"Seu saldo agora é de R$ {saldo:.2f}.")
    else:
        print(f"Deposito de R$ {deposito:.2f} inviavél, o valor tem que ser positivo ")
        print(f"Seu saldo continua sendo de R$ {saldo:.2f}.")
    return extrato, saldo

def func_saque(*, numero_saques, extrato, saldo):
    if numero_saques < LIMITES_SAQUES:
            print("Saque R$ ")
            saque = float(input("Digite a quantia a ser sacada: R$ "))
            if saque > 0:
                if saque <= saldo:
                    if saque <= 500:
                        extrato += f"Saque    R$ {saque:.2f} \n"
                        saldo -= saque
                        numero_saques += 1
                        print(f"Saque de R$ {saque:.2f} realizado com sucesso.")
                        print(f"Seu saldo agora é de R$ {saldo:.2f}.")
                    else:
                        print("Saque ultrapassou o valor máximo permitido de R$ 500.00.")
                        print(f"Seu saldo continua sendo de R$ {saldo:.2f}.")
                else:
                    print(f"Seu saldo de R$ {saldo:.2f} é insulficiente para sacar {saque:.2f}.")
            else:
                print("Saque um valor válido positivo. ")
                print(f"Seu saldo continua sendo de R$ {saldo:.2f}.") 
    else:
        print("Você só pode sacar três vezes por dia.")
        print(f"Seu saldo continua sendo de R$ {saldo:.2f}.")
    return numero_saques, extrato, saldo

def func_extrato(saldo, /, *, extrato):
    print("\n=================EXTRATO=================\n")
    if extrato == "":
        print("Não foram realizadas movimentações no dia.\n")
        print(f"Seu saldo é de R$ {saldo:.2f}.")
    else:
        print(f"O seu extrato:\n{extrato}\nsaldo:   R$ {saldo:.2f}")
    print("\n=========================================\n")
    return extrato, saldo

menu = """

[a] Adicionar Novo Usuário
[c] Criar conta
[l] Listar contas
[d] Depositar
[s] Sacar
[e] Extrato
[q] Sair

=> """

while True:

    opcao = input(menu)

    if opcao.lower() == "a":
        usuarios = func_adicionar_novo_usuario(usuarios)

    elif opcao.lower() == "c":
        contas = func_criar_conta(agencia, usuarios)

    elif opcao.lower() == "l":
        func_listar_contas(contas)

    elif opcao.lower() == "d":
        extrato, saldo = func_deposito(deposito, extrato, saldo)

    elif opcao.lower() == "s":
        numero_saques, extrato, saldo = func_saque(numero_saques = numero_saques, extrato= extrato, saldo = saldo)
        
    elif opcao.lower() == "e":
        extrato, saldo = func_extrato(saldo ,extrato = extrato)
        
    elif opcao.lower() == "q":
        break

    else:
        print("Operação inválida, por favor selecione novamente a operação desejada.")
