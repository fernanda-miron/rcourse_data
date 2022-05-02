## Cargamos las librerias que vamos a usar
library("vroom")   # Sirve para cargar archivos mas rapido y facil
library("dplyr")   # Sirve para manipular datos 
library("ggplot2") # Sirve para generar graficas bonitas

## Cargando data
tabla.df <- vroom(file = "https://raw.githubusercontent.com/fernanda-miron/rcourse_data/main/Periodic%20_Table%20_of%20_Elements.csv")


## Nuestra tabla tiene datos que no nos interesan tanto
## Vamos a quedarnos solo con densidad y tipo de elemento
filtrada.df <- tabla.df %>% 
  select(Element, Density, Type) %>% 
  na.omit()

## Ahora si, vamos a graficar
## Un boxplot muy basico.
p1 <- ggplot(data = filtrada.df, aes(x=Type, y=Density)) + 
  geom_boxplot()

## El grafico esta "guardado" en p1
## Vamos a invocarlo
p1

## Modificamos el codigo para añadir color por categoria
p2 <- ggplot(data = filtrada.df, aes(x=as.factor(Type), y=Density, color=Type)) + 
  geom_boxplot()

## Visualizamos
p2

## Vamos a añadir todas las entradas
p3 <- p2 +
  geom_jitter(size=1, alpha=0.9)
p3

## ¡Y no tenemos titulos!
p4 <- p3 +
  labs(title="Distribucion de densidad de los elementos",
       subtitle = "En funcion de su tipo",
       caption = "Datos: https://gist.github.com/GoodmanSciences/c2dd862cd38f21b0ad36b8f96b4bf1ee")

## Visualizamos
p4

## Vamos a hacerlo más bonito
## Lo primero, usamos un tema de ggplot
## Para ver los temas: https://ggplot2.tidyverse.org/reference/ggtheme.html
p5 <- p4 +
  theme_light()

## Visualizamos
p5

## Vamos a eliminar todo el eje x
## Reubicar el eje Y
## Y eliminar la leyenda
p6 <- p5 +
  theme(axis.title.x = element_blank(),
        axis.text.x = element_blank(),
        axis.title.y = element_text(hjust = 0.5),
        legend.title = element_blank())

## Visualizamos
p6

## Por ultimo, vamos a aumentar el tamaño de 
## todooo el texto
p7 <- p6 +
  theme(text = element_text(size=15))

## Visualizamos
p7

## Listo! Solo nos queda guardar nuestro grafico
ggsave(filename = "mi_boxplot.png", 
       plot = p7,
       width = 10, height = 7, units = "in",
       bg = "white",
       dpi = 300)

## Bonus track
## Vamos a usar paletas de color
library("viridis")

## Todo junto
p1.colors <- ggplot(data = filtrada.df, aes(x=Type, y=Density, color=Type)) + 
  geom_boxplot() +
  scale_colour_viridis_d(option = "D") +
  geom_jitter(size=1, alpha=0.9) +
  labs(title="Distribucion de densidad de los elementos",
       subtitle = "En funcion de su tipo",
       caption = "Datos: https://gist.github.com/GoodmanSciences/c2dd862cd38f21b0ad36b8f96b4bf1ee") +
  theme_light() +
  theme(axis.title.x = element_blank(),
        axis.text.x = element_blank(),
        axis.title.y = element_text(hjust = 0.5),
        legend.title = element_blank()) +
  theme(text = element_text(size=15))

## Visualizamos
p1.colors

## Guardamos  
ggsave(filename = "mi_boxplot_colors.png", 
       plot = p1.colors,
       width = 10, height = 7, units = "in",
       bg = "white",
       dpi = 300)

## Ahora vamos a hacer un plot de barras
## Vamos a partir de la barra principal y filtrar
filtrada_2.df <- tabla.df %>% 
  select(Element, Type) %>% 
  na.omit()

## Queremos plotear un grafico con los numeros de 
## elementos por categoria
counting.df <- filtrada.df %>% 
  group_by(Type) %>% 
  summarise(incidences = n())

## Ahora si, vamos a graficar
pb1 <- ggplot(data=counting.df, aes(x=Type, y=incidences,color=Type )) +
  geom_bar(stat="identity", width=0.5)

## Visualizamos
pb1

## Ese fondo negro se ve medio feo
pb1 <- ggplot(data=counting.df, aes(x=Type, y=incidences,fill=Type)) +
  geom_bar(stat="identity", width=0.5) +
  scale_fill_viridis_d(option = "B")

## Visualizamos
pb1

## Aniadimos titulos
pb2 <- pb1 +
  labs(title="Numero de elementos",
       subtitle = "En funcion de su tipo",
       caption = "Datos: https://gist.github.com/GoodmanSciences/c2dd862cd38f21b0ad36b8f96b4bf1ee")

## Visualizamos
pb2

## Vamos a hacerlo más bonito
## Lo primero, usamos un tema de ggplot
## Para ver los temas: https://ggplot2.tidyverse.org/reference/ggtheme.html
pb3 <- pb2 +
  theme_light()

## Visualizamos
pb3

## Vamos a eliminar todo el eje x
## Reubicar el eje Y
## Y eliminar la leyenda
pb4 <- pb3 +
  theme(axis.title.x = element_blank(),
        axis.text.x = element_blank(),
        legend.title = element_blank())

## Visualizamos
pb4

## Por ultimo, vamos a aumentar el tamaño de 
## todooo el texto
pb5 <- pb4 +
  theme(text = element_text(size=15))

## Visualizamos
pb5

## Listo! Solo nos queda guardar nuestro grafico
ggsave(filename = "mis_barras.png", 
       plot = pb5,
       width = 10, height = 7, units = "in",
       bg = "white",
       dpi = 300)

#######################################################################