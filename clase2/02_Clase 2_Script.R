# Script Clase 2. ----
# Introducción a Tidyverse ----
# Procesamiento de datos I ----
# Metodología Cuantitativa ----
# 01 de septiembre, 2021 ----


library(haven) # Importar bases
library(tidyverse) # Paquetes varios. Usaremos dplyr
library(tidylog) # Entrega info adicional cuando realizamos las operaciones

casen_2020 <- read_stata("data/02_Clase 2_Muestra_Casen2020.dta")

# Primero veamos cómo vienen ordenadas las variables inicialmente

casen_2020

View(casen_2020) # Visualizamos la base de datos

class(casen_2020) # Comprobamos que es un dataframe


glimpse(casen_2020) # Exploramos los datos 

names(casen_2020)

## Comando relocate ----

# Forma 1. Indicamos todas las variables y cambiamos posición de sexo y edad

casen_2020 %>% relocate(folio, o, region, zona, sexo, edad, ecivil, e6a, o1, o2, o3, o3b, 
                       activ, y1, y26b_espontanea, s13)

# Forma 2. Indicamos con el argumento .before que sexo debe estar antes que edad

casen_2020 %>% relocate(sexo, .before = edad)

# Forma 3. Indicamos con el argumento .after que edad debe estar después de sexo

casen_2020 %>% relocate(edad, .after = sexo)

casen_2020 <- casen_2020 %>% relocate(edad, .after = sexo)
casen_2020

# Nota: no se puede utilizar .before y .after a la vez.

## Comando select ----

# Forma 1. Seleccionamos todas las variables que queremos mantener

casen_2020 %>% select(folio, o, region, zona, sexo, edad, ecivil, 
                      e6a, activ, y1, y26b_espontanea, s13)


# Forma 2. Indicamos las variables que NO queremos mantener

casen_2020_subset <- casen_2020 %>% select(-o1, -o2, -o3, -o3b)

## Comando rename ----

casen_2020_subset <- casen_2020_subset %>% rename(condicion_activ = activ,
                                                  y26_espo = y26b_espontanea)

# Verificamos que la operación fue realizada correctamente
names(casen_2020_subset)


## Comando count y group_by ----

# Forma 1. Contamos la cantidad de casos por región

casen_2020_subset %>% count(region)

casen_2020_subset %>% count(sexo)


# Forma 2.Agrupamos por región y contamos la cantidad de hombres y mujeres

tabla_region_sexo <- casen_2020_subset %>% group_by(region) %>%
  count(sexo)

tabla_region_sexo

# Forma 3. Agrupamos por región, contamos y agregamos (mutate se verá la prox. clase)

casen_2020_subset %>% group_by(region) %>%
  count(sexo) %>%
  mutate(freq = n / sum(n))

# Forma 4. Agrupamos por región, contamos, agregamos y redondeamos a dos decimales.

casen_2020_subset %>% group_by(region) %>%
  count(sexo) %>%
  mutate(freq = round(n / sum(n),2))

## Comando filter ----

# Forma 1. Seleccionamos a las personas que tengan 60 años o más

casen_2020_subset %>% filter(edad >= 60)

# Forma 2. Seleccionamos solamente a las personas que tienen 60 años

casen_2020_subset %>% filter(edad == 60)

# Forma 3. Seleccionamos solamente a las personas que NO tienen 60 años

casen_2020_subset %>% filter(edad != 60)

# Forma 4. Seleccionamos solo a las personas de la región metropolitana

casen_2020_subset %>% filter(as_factor(region) == "Región Metropolitana de Santiago")

# Forma 5. Seleccionamos solo a las personas de la región metropolitana

casen_2020_subset %>% filter(region == 13)

# Forma 6. Seleccionamos a las personas de 60 años y más (O) a las que viven en la RM.

casen_2020_subset %>% filter(edad >= 60 | region == 13)

# Forma 7. Seleccionemos a las personas de 60 años y más (Y) a las que viven en la RM.

casen_2020_subset %>% filter(edad >= 60 & region == 13)

# Forma 8. Seleccionemos a las personas que viven en la región metropolitana o en la de Coquimbo

casen_2020_subset %>% filter(as_factor(region) %in% c("Región Metropolitana de Santiago",
                                           "Región de Coquimbo"))

# Forma 9. Seleccionemos a las personas que NO viven en la región Metropolitana o la de Coquimbo

base_filtrada <- casen_2020_subset %>% filter(!(as_factor(region) %in% c("Región Metropolitana de Santiago",
                                                      "Región de Coquimbo")))


base_filtrada %>% count(region)


## Comando arrange ----

# Forma 1. Ordenamos de manera ascendente por edad

casen_2020_subset %>% arrange(edad)

# Forma 2. Ordenamos de manera descendente por edad

casen_2020_subset %>% arrange(-edad)

# Forma 3. Otra forma de ordenar de manera descendente

casen_2020_subset %>% arrange(desc(-edad))

# Forma 4. Bonus: usar más de una variable para ordenar

casen_2020_subset %>% arrange(folio, edad)


## Comando slice ----

# Forma 1. Ordenamos por edad descendente y luego seleccionamos las primeras 5 filas

casen_2020_subset %>% arrange(-edad) %>%
  slice(1:5)

# Forma 2. Ordenamos por edad descendente y luego eliminamos las primeras 5 filas

casen_2020_subset %>% arrange(-edad) %>%
  slice(-(1:5))

# Forma 3. Ordenamos por edad y seleccionamos desde la fila 7 hasta el final

casen_2020_subset %>% arrange(-edad) %>%
  slice(7:n())

# Forma 4. Seleccionamos aleatoriamente el 10% de las filas

casen_2020_subset %>% slice_sample(prop = 0.1)
