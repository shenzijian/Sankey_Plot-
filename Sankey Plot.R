
# Sanky plot

library(readxl)
library(networkD3)





sankey <- read_excel('Common & Special.xlsx')
str(sankey)

sankey$Material = as.factor(sankey$Material)
sankey$`Model Type`=as.factor(sankey$`Model Type`)
sankey$Sale = as.integer(sankey$Sale)


#Generate a new table, name network, take out the required column data
network <- sankey[,1:3]   

#Name the new table columns
colnames(network) <- c("Material", "Model Type", "Sale") 

#List the start and end column names and the specific category names for each column
factor_list <- sort(unique(c(levels(network$Material), levels(network$`Model Type`))))

#Identifies the node length of the graph, since it starts at 0, so I will eventually reduce it by 1.
num_list <- 0:(length(factor_list)-1)

# Identify the number of nodes in each materials
levels(network$Material) <- num_list[factor_list %in% levels(network$Material)]

#Identify the number of nodes in each model type
levels(network$`Model Type`) <- num_list[factor_list %in% levels(network$`Model Type`)]

#factor type data is converted to numeric type
network$Material <- as.numeric(as.character(network$Material))
network$`Model Type` <- as.numeric(as.character(network$`Model Type`))

#Construct a data frame, name the attribute, and include the level factor names
attribute <- data.frame(name=c(factor_list))


sankeyNetwork(Links = network, Nodes = attribute,
              Source = "Material", Target = "Model Type",
              Value = "Sale", NodeID = "name", units = "TWh",
              fontSize= 12, nodeWidth = 30)
