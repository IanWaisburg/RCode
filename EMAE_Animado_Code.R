library(tidyverse)
library(gganimate)
library(lubridate)
library(zoo)
library(ggthemes)

EMAE <- sh_emae_mensual_base2004 %>%
        mutate(fechas= as.Date(as.yearmon(Fechas, "%Y-%m"))) %>%
        filter(fechas >= "2013-01-01")



graph <- ggplot(EMAE, aes(fechas, serie_org)) +
                geom_line(color="steelblue",size=1.4) +
                labs(x="Período",
                     y="EMAE",
                     caption="Fuente: INDEC")+
                theme_solarized()
                
          
graph_anim<- graph + transition_reveal(fechas) +
                      view_follow() +
                      labs(subtitle="@Ian_Waisburg")

anim<-animate(graph_anim, end_pause = 20)

save_animation(anim, "EMAE_animado")