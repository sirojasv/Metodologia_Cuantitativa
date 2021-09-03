# Script Clase 1. Introducción a R - Metodología Cuantitativa ----
# 25 de agosto, 2021 ----

## R como calculadora ---- 

1 + 1 # Aquí estoy sumando


## Instalación de paquetes ----

# install.packages("tidyverse") #Si ya los instalaron, no es necesario correrlos
# install.packages("summarytools") # Si ya los instalaron, no es necesario correrlos


# Se recomienda especificar todos los paquetes de la sesión al comienzo

library(tidyverse)
library(summarytools)
library(haven)

(5.5 + 3.8 + 6.1) / 3



promedio <- (5.5 + 3.8 + 6.1) / 3 # Puedo guardar los resultados en un objeto

promedio

## Vectores ----

vector_numerico <- c(1, 3, 5, 7, 9)

class(vector_numerico)

vector_letras <- c("Ud.", "Es", "Diabólico") # Las comillas indican que es texto

class(vector_letras)


## Matriz ----

matriz_1 <- matrix(1:9, ncol = 3)
matriz_1


matriz_2 <- matrix(1:9, ncol = 3, byrow = TRUE)
matriz_2

matriz_2[1, ] # Estoy seleccionando la fila 1 

matriz_2[, 1] # Estoy seleccionando la columna 1

matriz_2[1, 1] # Estoy seleccionando la fila 1 columna 1


## Tibble ----


nombre <- c("Julieta", "Gabriel", "Camila")

carrera <- c("Ingeniería", "Historia", "Biología")

gen <- c(2016, 2018, 2020)


data_estudiantes <- tibble(nombre, carrera, gen)

data_estudiantes

View(data_estudiantes)

# También es posible acceder a los elementos de un dataframe

data_estudiantes$nombre
data_estudiantes[["nombre"]]




## Listas ----

lista <- list("base_tibble_lista" = data_estudiantes,
              "matriz_lista" = matriz_1)

lista

lista$base_tibble_lista
lista[[2]]
lista[["matriz_lista"]][3,2] # Para acceder a la fila 3 de la columna 2 de la matriz en la lista