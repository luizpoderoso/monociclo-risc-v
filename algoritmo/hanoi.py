origem = [3, 2, 1]
auxiliar = []
destino = []

def mover_disco(origem, destino):
    destino.append(origem.pop())

def hanoi(n, origem, destino, aux):
    if n == 1:
        mover_disco(origem, destino)
        return

    hanoi(n - 1, origem, aux, destino)

    mover_disco(origem, destino)

    hanoi(n - 1, aux, destino, origem)

hanoi(len(origem), origem, destino, auxiliar)