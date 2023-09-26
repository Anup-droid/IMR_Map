#Required package
library(viridis)
library(viridisLite)
library(MASS)
library(ggplot2)
library(gganimate)
library(sf)
library(transformr)
library(ggdark)
library(readxl)
library(readr)
library(ggeasy)

#Load shape file of India
url <- "https://github.com/Anup-droid/India_Map/raw/main/Shape_files.zip"
download.file(url, "Shape_files.zip")
unzip("Shape_files.zip")
map_data <- st_read("Shape_files/state.shp")

# Load the data with values and time periods
# You should have a dataframe with columns: 'ID' (common identifier with the shapefile), 'value', and 'time_period'
IMR_SRS <- read_csv("C:/Users/Anup Kumar/Desktop/R-Code/Data_Visualization/SRS/IMR_SRS.csv")
map_data <- merge(map_data, IMR_SRS, by = "OBJECTID", all.x = TRUE)
# Set up the base plot
base_plot <- ggplot(map_data) +
  geom_sf(aes(fill = IMR)) +
  scale_fill_viridis(option="inferno")+
  theme_void()+
  dark_theme_classic()
base_plot

# Create the animated plot
animated_plot <- base_plot +
  transition_time(as.integer(Year)) +
  dark_theme_classic()+
  easy_remove_axes()+
  labs(title = "Infant Mortality Rate | Year: {frame_time}",
       subtitle = "IMR : No.of Infant deaths per thousand live births",
       caption = "Data Source: SRS Bulletin, 2006-2020")+
  theme(plot.title = element_text(size = 20,color = "green"),
        plot.subtitle = element_text(size = 12))+
  guides(fill = guide_colorbar(title = "IMR"))

# Play the animation
imr_anim=animate(animated_plot,fps = 12)

#To save the animation
anim_save("C:/Users/Anup Kumar/Desktop/R-Code/Data_Visualization/SRS/IMR.gif",imr_anim)
