library(haven) # Importar bases
library(tidyverse) # Paquetes varios. Usaremos dplyr
library(tidylog) # Entrega info adicional cuando realizamos las operaciones

casen <- read_stata("data/02_Clase 2_Muestra_Casen2020.dta")


# Función count

casen %>% count(sexo)
casen %>% count(s13)
casen %>% count(sexo, s13)

# Noten que "a" y "b" son equivalentes

a <- casen %>% group_by(s13, sexo) %>% summarise(n = n())

b <- casen %>% group_by(sexo) %>%
  count(s13) %>%
  mutate(prop_row = round(n/ sum(n),3)) %>%
  ungroup() %>%
  group_by(s13) %>%
  mutate(tot_col = sum(n)) %>%
  ungroup() %>%
  mutate(col_prop = n / tot_col)


b


b_1 <- casen %>%
  group_by(sexo) %>%
  count(s13) %>%
  mutate(total_col = sum(n)) %>%
  mutate(prop_fila = round(n / sum(n), 3)) %>%
  ungroup() %>%
  group_by(s13) %>%
  mutate(tot_fila = sum(n)) %>% 
  ungroup() %>%
  mutate(total = sum(n))


  
casen %>%
  group_by(sexo) %>% # Agrupamos por sexo
  count(s13) %>% # Contamos s13, que está agrupada por sexo
  mutate(total_col = sum(n)) %>% # Crea total_col que es la suma de variable "n" agrupada 
  #(total de hombres y mujeres para s13)
  mutate(prop_fila = round(n / sum(n),3)) %>% # Crea prop_fila. 
  #Ej: proporción de hombres en el FONASA respecto tal total de hombres que responde (3253/4276= 0.761)
  ungroup() %>% # Desagrupamos la base
  group_by(s13) %>% # Agrupamos por s13
  mutate(tot_fila = sum(n)) %>% # Crea tot_fila que es la suma de la variablee "n" agrupada
  #total de personas para cada categoría de s13 sumando ambos sexos
  ungroup() %>% # Desagrupamos la base
  group_by(s13) %>%
  mutate(tot_col = tot_fila / sum(n) )



summarytools::ctable(casen$sexo, casen$s13, prop = "r")
summarytools::ctable(casen$sexo, casen$s13, prop = "c")



c <- casen %>%
  group_by(sexo, s13) %>%
  summarise(n = n()) %>%
  mutate(freq = n / sum(n)) %>%



d <- casen %>% add_count(sexo, s13)





# Función Tally

casen %>% tally(sexo)