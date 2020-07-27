#Cargamos los paquetes
library(readxl)
library(tidyverse)
library(gganimate)
library(dplyr)
library(stringr)
library(lubridate)

#Cargamos los datos
Dolar_Serie <- read_excel("Documents/Datos históricos USD_ARS.xlsx",sheet=1)
#Editamos la base para cambiar los strings que venian del excel y seleccionamos las columnas relevantes.
Dolar_Serie <- Dolar_Serie %>% 
                  mutate(fecha=dmy(Dolar_Serie$Fecha)) %>%
                    mutate(Oficial = as.numeric(str_replace_all(Venta,",","."))) %>%
                        mutate(Blue = as.numeric(str_replace_all(Venta_b,",","."))) %>%
                            mutate(MEP = as.numeric(str_replace_all(Venta_m,",","."))) %>%
                                mutate(ContadoCLiqui = as.numeric(str_replace_all(Venta_cl,",","."))) %>%
                                    select(fecha, Oficial, Blue, MEP, ContadoCLiqui) 
##Armamos el grafico
ggplot(Dolar_Serie, aes()) +
   geom_point(aes(1,Oficial),color="orange",size=8) +
   geom_point(aes(1.25,Blue),color="steelblue",size=8) +
   labs(title = "Valoración USD vs. ARS: Desde PASO 2019",
        y= "Valoración",
        caption="Fuente: Ámbito Financiero",
        x="  Oficial                                                                                                                          Blue ") +
   transition_time(fecha) +
   labs(subtitle = "Fecha:{frame_time}") +
   theme(axis.text.x = element_blank(),
         axis.ticks.x.bottom = element_blank(),
            axis.title.x = element_text(hjust=0))
#Guardamos el grafico
anim_save("Dolar Oficial vs Blue")


