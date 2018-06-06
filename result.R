# load library
library(RMySQL)

# settings
db_user <- 'root'
db_password <- 'Pwd123'
db_name <- 'example_db'
db_table <- 'digs_results'
db_host <- '127.0.0.1' # for local access
db_port <- 3306

# read data from db
mydb <-  dbConnect(MySQL(), user = db_user, password = db_password,
                 dbname = db_name, host = db_host, port = db_port)
s <- paste0("select * from ", db_table)
rs <- dbSendQuery(mydb, s)
df <-  fetch(rs, n = -1)

# save data to file
write.table(df, "results.txt", quote = FALSE, sep = "\t", row.names = FALSE)

quit("no")
