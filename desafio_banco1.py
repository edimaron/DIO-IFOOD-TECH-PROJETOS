menu = """

[d] Depositar
[s] Sacar
[e] Extrato
[q] Sair

=> """

saldo = 0
limite = 500
extrato = ""
numero_saques = 0
LIMITES_SAQUES = 3

while True:

    opcao = input(menu)

    if opcao.lower() == "d":
        print("Depósito R$ ")
        deposito = float(input("Digite a quantia a ser depositada: R$ "))
        
        if deposito > 0:
            extrato += f"Depósito R$ {deposito:.2f} \n"
            saldo += deposito
            print(f"Depósito de R$ {deposito:.2f} realizado com sucesso.")
            print(f"Seu saldo agora é de R$ {saldo:.2f}.")
        else:
            print(f"Deposito de R$ {deposito:.2f} inviavél, o valor tem que ser positivo ")
            print(f"Seu saldo continua sendo de R$ {saldo:.2f}.")

    elif opcao.lower() == "s":
        
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

    elif opcao.lower() == "e":
        print("\n=================EXTRATO=================\n")
        if extrato == "":
             print("Não foram realizadas movimentações no dia.\n")
             print(f"Seu saldo é de R$ {saldo:.2f}.")
        else:
            print(f"O seu extrato:\n{extrato}saldo:   R$ {saldo:.2f}")
        print("\n=========================================\n")
    elif opcao.lower() == "q":
        break

    else:
        print("Operação inválida, por favor selecione novamente a operação desejada.")
