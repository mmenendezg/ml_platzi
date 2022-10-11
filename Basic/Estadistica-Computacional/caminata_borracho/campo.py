class Campo:

    def __init__(self):
        self.coordenadas = {}
    
    def agregar_borracho(self, borracho, coordenada):
        self.coordenadas[borracho] = coordenada
    
    def mover_borracho(self, borracho):
        delta_x, delta_y = borracho.caminar()
        coordenada_actual = self.coordenadas[borracho]
        nueva_coordenada = coordenada_actual.mover(delta_x, delta_y)

        self.coordenadas[borracho] = nueva_coordenada
    
    def obtener_coordenada(self, borracho):

        return self.coordenadas[borracho]