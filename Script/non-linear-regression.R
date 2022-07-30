library(readxl)
library(rms)
library(ggplot2)
data <- read.csv("RQ1_Metric.csv", header=TRUE, sep=",")
View(data)

#Data processing Part I
#data$reviewtime <- round(difftime(data$lastime, data$firstime, units = c("hours")),0)
data$Purpose <- ifelse(grepl("doc|copyright|license", data$Title_Description, ignore.case = T), "Document", 
                            ifelse(grepl("bug|fix|defect", data$Title_Description, ignore.case = T), "Bug", "Feature"))
model_data <- data.frame(data$ReviewTime, data$Reviewer_Number, data$Comment_Reviewer, data$Comment_Author,
                         data$Comment_All, data$additions, data$deletions, data$Total_size,
                         data$commits, data$files, data$Author_Experience, data$Emoji, data$Description_length, data$Emoji_Number, 
                         data$Purpose,data$Language)
names(model_data)[1] <- "Reviewtime"
names(model_data)[2] <- "Commenter"
names(model_data)[3] <- "Reviewer_Comment"
names(model_data)[4] <- "Author_Comment"
names(model_data)[5] <- "Total_Comment"
names(model_data)[6] <- "insertions"
names(model_data)[7] <- "deletions"
names(model_data)[8] <- "total_size"
names(model_data)[9] <- "commit"
names(model_data)[10] <- "file"
names(model_data)[11] <- "Author_Exp"
names(model_data)[12] <- "Emoji"
names(model_data)[13] <- "Description_len"
names(model_data)[14] <- "Emoji_Number"
names(model_data)[15] <- "Purpose"
names(model_data)[16] <- "Language"
model_data$Reviewtime <- as.numeric(model_data$Reviewtime)
max(model_data$Emoji_Number)

dd <- datadist(model_data)
options(datadist = "dd")
dd
#Model Construction Part II
#Step1 calculate the budget
budget = floor ( model_data$Reviewtime / 15)
budget
#Step2 Normality adjustment
library(moments)
skewness ( model_data$Reviewtime )
kurtosis ( model_data$Reviewtime )

#Step3 Correlation analysis
library(rms)
ind_vars = c('Commenter', 'Reviewer_Comment', 'Author_Comment','Total_Comment','insertions','deletions',
             'total_size','commit','file','Author_Exp','Emoji','Description_len', 'Emoji_Number', 'Purpose','Language')
vc <- varclus(~ ., data=model_data[,ind_vars], trans="abs")
plot(vc)
threshold <- 0.7
abline(h=1-threshold, col = "red", lty = 2)

reject_vars <- c('total_size','Total_Comment', 'Commenter', 'insertions','Emoji')
ind_vars <- ind_vars[!(ind_vars %in% reject_vars)]
vc <- varclus(~ ., data=model_data[,ind_vars], trans="abs")
plot(vc)
threshold <- 0.7
abline(h=1-threshold, col = "red", lty = 2)


#Step4 Redundancy analysis
red <- redun(~., data=model_data[,ind_vars], nk=0) 
red
#Step5 Allocate degrees of freedom using log1p
spearman2 = spearman2(log1p(Reviewtime) ~ commit + Author_Comment + file + Reviewer_Comment + Emoji_Number + deletions + Purpose+ 
                        Author_Exp + Language + Description_len, data = model_data, p=2)
plot(spearman2)
#Step6 Model Construction
fit <- ols(log1p(Reviewtime) ~ rcs(Reviewer_Comment,5) + rcs(Author_Comment,5) + rcs(Description_len,3) + rcs(Emoji_Number,3) + rcs(commit,3)  +  
            file + deletions + Author_Exp + Purpose + Language, data=model_data, x=T, y=T) 

fit

#Model Evaluation Part III
#Assessment of model stability and calculate AUC
require (rms)
num_iter = 1000
val <- validate (fit, B= num_iter )
val
# Estimate power of explanatory variables
chisq <- anova(fit, test ="Chisq")
chisq
#Examine variables in relation to outcome
bootcov_obj = bootcov(fit, B= num_iter)

bootcov_obj

library(caret)

response_curve = Predict(bootcov_obj,
                         name = c('The number of Emoji reactions'),
                             fun = function (x) return (exp(x)))

plot(response_curve, ylab="Review Time (Hours)", xlab="Emoji",sub ="")

pred <- Predict(fit, Emoji_Number,fun = function (x) return (exp(x)))

plot(pred)

#print(names(coef(fit)), quote=FALSE)

#p <- ggplot(pred,aes(Emoji_Number, yhat)) + labs(x="The number of Emoji reactions",caption="") + scale_x_continuous(breaks = c(0,20,40,60,80,100,120,
#                                                                                                                               140,160,180,200), limits = c(0,200))
#p + geom_line(color="blue") + theme_light() + theme(plot.title = element_blank(),
#                                                    legend.title = element_blank(),
#                                                    legend.text = element_text(colour="black", size=12),
#                                                    axis.title.x = element_text(color="black", size=13, face="bold"),
#                                                    axis.title.y = element_text(color="black", size=13, face="bold"),
#                                                    axis.text.x = element_text(color="black", 
#                                                                               size=12),
#                                                    axis.text.y = element_text(color="black", 
#                                                                               size=12)) + ylab("Review Time (Hours)")
