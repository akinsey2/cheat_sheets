##----------------------------------------------------
## General variable, vector, matrix, etc operations

c()
t()
length()
dim()
nrow()
ncol()
str()
head(X, n=number)
tail(X, n=number of rows)
typeof(result) #logical, numeric, character, integer
class(result) # vector, matrix, list, data frame, factor
is.numeric(), is.character(), is.vector(), is.array(), is.complex(), etc
print()
paste()
vector()
names()
rownames()
colnames()
attach()
factor()
as.factor()
na.omit()
seq()
rep()
matrix()
matrix1[1,,drop=F]
rbind()
cbind()
ifelse(condition, return_if_true, return_if_false)

#DataFrames (DF)
DataFrame$ColumnName == DataFrame[,"ColumnName"]  #New way to index columns
levels()        #- View the underlying "levels" of a factor
DataFrame$NewColName = xyzVector  #Add new Column to DataFrame (vector will be "recycled")
DataFrame$ColName = NULL    #Delete column from Data Frame 
  
    #filtering
filter <- DataFrame$ColName < value
DataFrame[filter,] #returns only rows that meet the criteria of the filter!

studios_filter <-  ( movies$Studio == "Buena Vista Studios" | 
                        movies$Studio == "Fox" |
                        movies$Studio == "Paramount Pictures" |
                        movies$Studio == "Sony" |
                        movies$Studio == "Universal" | 
                        movies$Studio == "WB")

movies2 <- movies[studios_filter,]

genre_filter = movies2$Genre %in% c("action", "adventure", "animation", "comedy", "drama")
movies3 = movies2[genre_filter,]

data.frame(data1, data2)   #Create new data frame


##---------------------------------------------------------------------------
## Data import/Export
##---------------------------------------------------------------------------

# ReadR
library(tidyverse)
guess_encoding(charToRaw(str1)) # Takes input string in raw, and tries to guess encoding

tibble <- read_csv("path", skip = 0, col_names = T | F) # Comma-separated files
tibble <- read_csv2("path", skip = 0, col_names = T | F) # Semicolon-separated files
tibble <- read_tsv("path", skip = 0, col_names = T | F) # Tab-delimited files
tibble <- read_delim("path", delim = '|')

write_csv(table, "path", na = 'NA', append = T | F, ...)
write_excel_csv(table, "path", na = 'NA', append = T | F, ...)

write_rds(table, "path") # save data in R's custom "RDS" binary format
tibble <- read_rds("path") # read data from R's custom "RDS" binary format

haven() #Reads SPSS, Stata, and SAS files.
readxl() # reads excel files (both .xls and .xlsx).
DBI()    #along with a database specific backend (e.g. RMySQL, RSQLite, RPostgreSQL etc) 
         #allows you to run SQL queries against a database and return a data frame.

# Generic R
ls()
rm()
getwd()
setwd("C:\\Users\\Stephanie\\Documents\\Machine Learning\\")
file.choose()
read.csv(file.choose())
read.table()
write.table()
write.csv()
fix()
savehistory()
loadhistory()


##---------------------------------------------------------------------------
## Data wrangling -Tidyr
##---------------------------------------------------------------------------

as_tibble()
is_tibble()     #- T/F - test whether object is tibble

drop_na(data, c(col1, ...))                                 #- Drop rows that have NAs in specified column                            
fill(data, c(col1, ...), .direction=("down" | "up"))        #- Replace NAs with nearest present values
replace_na(data, replace=list(col1 = 0L, col2 = 0, col3="NULL"))

pivot_longer(data, cols = (-col_name | c(col1, ...)), names_to="new_col_name", values_to="new_col_name2", ... 

    names_prefix="remove_this",                 #- Remove a common prefix that columns have, can be RegEx
    names_sep="separator",                      #- split complex col names: i.e. "Q1 2019" -> "Q1" and "2019" 
    values_drop_na = (TRUE | FALSE)             #- Drop rows containing NA values
    names_transform=list( col1 = as.factor ),   #- change data type of col names
    values_transform=list( col1 = as.integer ), #- change data type of values
    )


pivot_wider(tibble, names_from=c(col1, ...), values_from=c(col1, ...) ... 

    names_prefix="add_this",                    #- Add a common prefix to names
    names_sep="separator",                      #- join complex names in cols: i.e. "Q1" and "2019" -> "Q1 2019"
    names_glue="{names_from_variable}_{.value}",#- Fancy way to create many new col names
    names_sort=(TRUE | FALSE),                  #- Sort columns by name?
    values_fill = 

    )

gather(

complete()
expand()

# For structured/nested data (JSON, XML, etc)
unnest_longer()
unnest_wider()
unnest_auto()

nest()
unnest()


##---------------------------------------------------------------------------
## Data transformation -Dplyr
##---------------------------------------------------------------------------

glimpse(data, [col1, col2], width=num_of_chars_onscreen)

slice(.data, row_indices, .preserve= c(FALSE, TRUE))        #- Integer row values, either all positive values to keep, or all negative values to drop. Indices beyond the number of rows in the input are silently ignored.
slice_head(.data, [row_indices], n = num_top_rows OR prop = proportion_rows)    #- Slices from beginning of table
slice_tail(.data, [row_indices], n = num_top_rows OR prop = proportion_rows)    #- Slices from end of table
slice_min(.data, order_by = [var | fun(var)], ..., n, prop, with_ties = TRUE)   #- picks the rows with the smallest values of [var | fun(var)]
slice_max(.data, order_by = [var | fun(var)], ..., n, prop, with_ties = TRUE)   #- picks the rows with the largest values of [var | fun(var)]

#excellent for randomly selecting "train" and "test" groups
slice_sample(data, [n=num_rows | prop=proportion],

    order_by=[col1 | function()],
    weight_by=vector_of_n_weights,      #- Vector the same length as input to multiply selected values by
    replace = (FALSE | TRUE)            #- sampling without or with replacement
    )

sample_frac()  #-deprecated, slice-sample() instead

summarize(.tbl, new_metric1=fun(var1), new_metric2=fun(var2)<vars>, ...)

across(.cols = <select_semantics>, .fns = list(func1, func2), .names=["{.col}.{.fun}" or other "name glue spec" ])

summarize_all(.tbl, .funs = list(min, mean, max))    ==    summarize(.tbl, across(.cols=everything(), .fun=list(min, mean, max))
summarize_if(.tbl, .predicate, .funs)    ==    summarize(.tbl, across( where(.predicate) , ~ .fn(.x) ) )
summarize_at(.tbl, .vars, .funs, .cols)

#common summarize() helper functions
mean(), median(), 
sd(), IQR(), mad(), 
min(), max(), quantile()
first(), last(), nth(), 
n(), n_distinct(), 
any(), all()

filter(col1 %in% c("val1", "val2", etc))
filter(col1 == "val1" | col1 == "val2" | etc)

pull(.data, var = [var_name | positive_integer | negative_int , name = NULL)    #- Similar to "$" operator, pulls individual named vector out of table

mutate()

add_count(x=data, <...variables to group by>,       #- Similar to count(), but does NOT collapse rows and adds a new column
    wt = vector_of_n_weights,
    sort = FALSE,                                   #- Sort descending, or not?
    name = NULL)                                    #- name=NULL defaults new col name as "n", or specify what you want.

across()            #- see above

mutate_all(.tbl, .funs=[func1 | list(func1, func2)])        #New col names are generated automatically (can't specify)
mutate_if(.tbl, .predicate=is.numeric, .funs = [func1 | list(func1, func2) ])
mutate_at(.tbl, .vars=vars(...), .funs = [func1 | list(func1, func2) ])

#- Create new categorical variable, order MATTERS in execution
case_when(condition1 ~ result, condition2 ~ result, ...)
x <- 1:20
case_when(x %% 3 == 0 ~ "factor of 3", x %% 5 == 0 ~ "factor of five", TRUE ~ "factor something")



##---------------------------------------------------------------------------
## Factors - Forcats
##---------------------------------------------------------------------------

is.factor(var)                                  #- [TRUE | FALSE] Check if variable is factor
data %>% mutate_if(is.character, as.factor)     #- convert all "char" vars to factors

nlevels(factor_var)                             #- Number of levels in factor
levels(factor_var)                              #- names of levels in factor

summarize_if(is.factor, nlevels)                #- summarize only factor variables

fct_reorder(.f = factor_to_reorder, .x = var_to_use_to_reorder,     #- Apply ".fun" function to ".x" to get a new .fun(.x) vector
    .fun = c(median, mean, etc), .desc = c(True, False)  )          #- Reorder factor .f (desc or asc) based on results of .fun(.x)

fct_infreq(.f = factor_to_reorder, ordered = c(NA, TRUE, FALSE))    #- Reorders factor by the frequency of occurrence.  "ordered=NA" preserves the existing "ordered" status of the factor
fct_inseq(.f = factor_to_reorder, ordered = c(NA, TRUE, FALSE))     #- Reorders factor by the numeric value of level

fct_rev(.f = factor_to_reorder)         #- Reverse the ordering of the factor

fct_relevel(.f = factor_to_reorder, [function | formula | manual listing], after = factor_index_int)
fct_relevel(.f = factor_to_reorder, "d", "b", "c", "a")
fct_relevel(.f = factor_to_reorder, [sort, sample, rev, ...], after=Inf)        #- "after=Inf" places extra factors at the end.

fct_recode(.f = factor_to_rename, "new_label1" = "old_label1", "new_label2" = "old_label2", ... )  #- Rename factor levels manually
#- NOTE: If you get a warning when running this function, you've made a typo, and no names are changed.

#- Too many factor levels?  Combine them into fewer manually
fct_collapse(.f = factor_to_restructure, new_combined_level1 = c("old_name1", "old_name2", ...),
            new_combined_level2 = c("old_name3", "old_name4", ...),
            other_level = NULL)
fct_other(.f = factor_to_restructure, keep = c("name1", "name2", ...))   #- All NOT explicitly named collapsed into "other" factor level/category
fct_other(.f = factor_to_restructure, drop = c("old_name1", "old_name2", ...))   #- All explicitly named collapsed into "other" factor level/category

fct_lump(...)  #- DEPRECATED, but the following are still good
fct_lump_min(f = factor_to_restructure, min = min_num_occurences_int,   #- counts occurences of each factor, and keeps only factor levels occurring >= min times, lumping the rest in "other"
            w = NULL, other_level = "Other")       
fct_lump_prop(f = factor_to_restructure, prop = [0:1],                  #- counts occurences of each factor, and keeps only factor levels with frequency >= p, lumping the rest in "other"
            w = NULL, other_level = "Other")     
fct_lump_n( f = factor_to_restructure, n = num_levels_to_keep_int,      #- counts occurences of each factor, and keeps only the top n factor levels, lumping the rest in "other"
            w = NULL, other_level = "Other",
            ties.method = c("min", "average", "first", "last", "random", "max"))
fct_lump_lowfreq(f = factor_to_restructure, other_level = "Other")      #- lumps together the least frequent levels, ensuring that "other" is still the smallest level.


##---------------------------------------------------------------------------
## Strings - 
##---------------------------------------------------------------------------


##---------------------------------------------------------------------------
## Mathematical Operations
##---------------------------------------------------------------------------

sqrt()
outer()
factorial()

%%      #- Modulo operator


##---------------------------------------------------------------------------
##Statistical operations
##---------------------------------------------------------------------------

rnorm(), dnorm(), pnorm(), qnorm()
runif()     #- generate Uniformly dist. random data
cor()       #- Pearson correlation coefficient
mean()
var()       #- Variance
sd()
range()
summary()
choose()
library(mvtnorm)
#multivariate (2D+) Normal Distributions
dmvnorm(x, mean = c(0,0), sigma = var_covar_matrix) #Density Function for multivariate Gaussian
rmvnorm(n, mean = c(0,0), sigma = var_covar_matrix) #Generate (2D+) random Gaussian/normal data in matrix
pmvnorm(lower, upper, mean, length, sigma) #computes cumulative probability over a range of the multivariate gaussian
#Multivariate t-distributions
rmvt(n, sigma, df, delta, sigma)
dmvt(x)

#Simulate/Graph multivariate normal data
library(tidyverse)
library(mvtnorm)
library(plotly)
library(MASS)
sigma <- matrix(c(1,0,0,1), ncol = 2)
means <- c(0, 0)
n <- 1000
set.seed(42)
x <- rmvnorm(n = n, sigma = sigma)
d <- data.frame(x)
names(d)
p1 <- ggplot(data=d, aes(x=X1)) + geom_density()
p1
ggplotly(p1)
p2 <- ggplot(d, aes(x = X1, y = X2)) + geom_point(alpha = .5) + geom_density_2d()
p2
ggplotly(p2)
p3 <- ggplot(d, aes(x = X1, y = X2)) + geom_point(alpha = .5) + geom_bin2d() +
   scale_fill_viridis_c()
p3


##---------------------------------------------------------------------------
## Regression
##---------------------------------------------------------------------------

lm_object = lm( formula = output~input, data = data, subset = data_subset, 
                weights = weights_vector)

summary(lm_object)
names(lm_object)

# Quickly plot 2D dataset and regression
plot(input, output)
points(input, lm_object$fitted.values, pch=20, col='blue')
#quickly view four "diagnostic plots" of regression residuals
par( mfcol = c(2,2))
plot(lm_fit, pch=20)
#1 Residuals vs. predicted/fitted values: Should be "random", verifies if the fitted model is correct (linearity and homoscedasticity)
#2 Normal Q-Q Plot: verifies that the residuals are normally distributed, should be "close" to y=x
#3 Scale-Location: Similar to #1, allows to heteroscedasticity to be seen more clearly. (time-series?)
#4 Cook's Distance: measure of the influence of each observation on regression coefficients

abline(lm_object, lwd=3, col="blue")  #Quickly plot simple regression line - abline(intercept, slope)

Bj_vector = coef(lm_object) # preferred way to access lm_object$coefficients

conf_int_Bj = confint(lm_object)  #Generate confidence intervals for regression coefficients

#Multipurpose function to generate estimates, confidence intervals, prediction intervals
predict( lm_object, newdataframe_optional, df=InF, interval = "none"/"confidence"/"prediction",
         level = 0.95, type = "response"/"terms" )
# produces predicted values, obtained by evaluating the regression function in the frame newdata
# If newdata is omitted the predictions are based on the data used for the fit.


model_line_data = predict(lm_object) #Get raw output "prediction" values along regression line

coef_conf_int <- predict(lm_object, interval = "confidence")
prediction_int <- predict(lm_object, interval = "prediction")

lm_residual <- residuals(lm_object)

rstandard(lm_object) # "Standardized residuals" = "Internally Studentized residuals"
                     # RSE includes the suspected outlier in the RSE calculation
                     #  residuals/sd_residuals = residual_i / [RSE * sqrt(1 - h_i)] (Residual Standard Error)

rstudent(lm_object)  # "Studentized" residuals = "Externally Studentized Residual"
                     # RSE EXcludes the suspected outlier in the RSE calculation
                     # residuals/sd_residuals = residual_i / [RSE * sqrt(1 - h_i)]

dfbeta(lm_object)    # A measure of how much the coefficients B are changed by a particular 
dfbetas(lm_object)   # observation (X_i,Y_i) being removed from the regression

covratio(lm_object)

cooks.distance(lm_object)

hatvalues(lm_object)

install.packages("car")
vif(lm_object)   #Variance Inflation Factor: calculate if inputs are collinear/correlated.


##---------------------------------------------------------------------------
## CLASSIFICATION
##---------------------------------------------------------------------------

# Logistic Regression

glm( formula, family = binomial / quasibinomial / poisson / quasipoisson / Gaussian /
        Gamma / inverse.gaussian / quasi, data)

log_reg_model = glm(formula = Output ~ Input1 + Input2 + Input3, family = binomial , data = data_table )
summary(log_reg_model)
coef(log_reg_model)
coef(log_reg_model)$Input1
contrasts(data_table$Output)  #View the actual numeric "codings" of the class variable(s)

model_popredict(log_reg_model, type="response") #get the output values of the model (predicted)...defaults to training data

#Create "Confusion" Matrix

log_reg_preds = rep("Down", length(market$Direction))
glm1_preds[log_reg_model$fitted.values > 0.5] = "Up"          

conf_mat1 = table(predicted = glm1_preds, actual = market$Direction)

# Fisher's Linear Discriminant Analysis

library(MASS)
lda1 = lda(formula = output_factor ~ input1 + input2, data = data )
lda1 # print out summary....do NOT use "summary" function

lda1_pred = predict(object=lda1, newdata=test_dataset, prior=object$prior)
lda1$class #predicted output class (Up/Down) based on inputs....ASSUMES 50% threshold
lda1$posterior #raw predicted probabilities

# QDA - Quadratic Discriminant Analysis
qda1 = qda(formula = output ~ input1 + input2, data=data, subset)
qda1_preds = predict(object=qda1, newdata)
conf_mat4 = table(qda1_preds$class, new_data_truth)

# K Nearest Neighbors
library(class)
train_X = cbind(data1, data)[train_filter,]
test_X = cbind(data1, data)[!train_filter,]
train_Output = output[train_filter]


##---------------------------------------------------------------------------
## Charts, Graphs, Plotting
##---------------------------------------------------------------------------

plot()
matplot()
contour()
hist()
image()
persp()
pairs()
pairs.panels()
identify()
par( mfcol=c(num_rows, num_cols) ) #Generate "matrix" of plots (subplots)

# GGPlot2

#- !! NOTE: ggplot will display factors based on their "order", the numbers behind them. 
#-          To reorder the display of the factor variable, you must reorder the factor itself.
qplot()
p <- ggplot(data=dataFrame, aes( x= variable1, y=variable2, color=variable3, size = var4)) + 
  geom_point() +
  geom_line() + 
  geom_histogram( binwidth=10 , fill="White", color="Blue") +
  geom_density( aes(fill=variable1), position="stack" ) +
  geom_smooth(fill = "Color") +    #Add spline regression overlaying data
  geom_jitter() + 
  geom_boxplot(size = 1, alpha = 0.5) +
  geom_path() + 
  coord_flip()                  #- Switch x and y axes (flip across y=x)



#- "Dot Plots"...graphing changes in a value across various categories/factors (as rows)
#- I.E. change in wealth gap, 1995 to 2005, across various countries.
ggplot() + geom_path(aes(x = numeric_var, y = factor_var), arrow = arrow(...))
 
p <- ggplot(data=dataFrame, aes( x= variable1, y=variable2, color=variable3) )
  
#Overriding "plot" aesthetics - 
    #AES mappings set in "higher" layer will override AES mappings from lower layer.
ggplot(data=dataFrame, aes( x= variable1, y=variable2, color=variable3) ) +
  geom_point( aes(color = variable4) ) #color from variable 4 will be used instead of from variable 3!!

p + geom_point( aes( color = variable4 ) ) #same thing

#Mapping vs Setting
   # "Mapping" is correlating an aesthetic to a data variable (REQUIRES "aes()" function)
   p + geom_point( aes( color = variable4, size = variable3) )
   
   # "Setting" is "fixing" an aesthetic to fixed values (just set directly without "aes()" function)
   p + geom_point( color = c(1:5), size = 4 )
   
#Facets -------------------------

    p + facet_grid(var_for_columns ~ var_for_rows)
    p + facet_grid(var_for_cols ~ .)  #- Columns only
    p + facet_grid(. ~ var_for_rows)  #- Rows only

   p + geom_histogram( binwidth=10, aes(fill=variable1), color = "Black" ) +
     facet_grid(factor1 ~ ., scales = "free") #Will create ROWS of plots based on factor1
        #Order of "factor ~ . " is important!  Determines rows vs. columns


# Window View / Viewport / Limiting graphing region / Zooming -------------------------
    
    #- (Recommeded) without Clipping of visible data (retains unseen data points when rendering/drawing)
    p + coord_cartesian(xlim= c(min_value, max_value), ylim = c(min_value, max_value)
    # OR
    #- (Not recommended) WITH Clipping of Visible data (removes unseen data points when rendering/drawing)
    p + xlim(min_value, max_value) + ylim(min_value, max_value)


# Labels ---------------------------

geom_text(                                              #- Text Label without background color
    data=NULL,                                          #- If NULL, inherited from ggplot()
    mapping=aes(x=x_positions, y=y_positions, label=label_values
        alpha, angle, color, family, fontface, group, hjust, vjust, lineheight, size)
    position = ["pos_string" | position()],             #- Cannot be jointy specified with nudge_x or nudge_y.Position adjustment, either as a string, or the result of a call to a position adjustment function. 
    parse = c(FALSE, TRUE),                             #- If TRUE, the labels will be parsed into expressions and displayed as described in ?plotmath.
    [nudge_x, nudge_y] = nudge_dist,                    #- Horizontal and vertical adjustment to nudge labels by. Useful for offsetting text from points, particularly on discrete scales. Cannot be jointly specified with position.
    label.padding = size_in_lines,                      #- Amount of padding around label. Defaults to 0.25 lines.
    label.r = radius_in_lines,                          #- Radius of rounded corners. Defaults to 0.15 lines.
    label.size = size_in_mm,                            #- Size of label border, in mm.
    na.rm = c(FALSE, TRUE)                              #- If FALSE, the default, missing values are removed with a warning. If TRUE, missing values are silently removed.
    show.legend = c(NA, FALSE, TRUE),                   #- logical. Should this layer be included in the legends? NA, the default, includes if any aesthetics are mapped. FALSE never includes, and TRUE always includes. It can also be a named logical vector to finely select the aesthetics to display.
    inherit.aes = c(TRUE, FALSE)                        #- If FALSE, overrides the default aesthetics, rather than combining with them. This is most useful for helper functions that define both data and aesthetics and shouldn't inherit behaviour from the default plot specification, e.g. borders().
    check_overlap = c(FALSE, TRUE)                      #- If TRUE, text that overlaps previous text in the same layer will not be plotted. check_overlap happens at draw time and in the order of the data. Therefore data should be arranged by the label column before calling geom_text(). Note that this argument is not supported by geom_label().
    )

geom_label(...)                                         #- Text label WITH background color

   
## "Theme" Layer : Non-Data Ink-------------------
   
    
   
   o + xlab("The X Axis Label") + ylab("The Y Axis Label")

   o + labs(x = "x_label", y = "y_label", title = "", subtitle = "",
    caption = "lower_right", tag = "upper_left", alt = "alternate text for plot"
    )

#- Change display of axis scales
    o + scale_x_continuous()
    o + scale_y_continuous( name = c(waiver(), "axis_label_str", NULL )            
              breaks = c( waiver(), NULL, vector_of_positions, function() ),
              minor_breaks = c( waiver(), NULL, vector_of_positions, function() ),
              n.breaks = c(NULL, num_of_breaks_int),                                #- Specify the general number of breaks in scale. Only used when "breaks = waiver()""
              labels = c( waiver(), NULL, vector_of_labels_chr, function() ),
              limits = c( NULL, vect_min_max_limits ),
              expand = c( waiver(), expansion(...)),                                #- Use the convenience function expansion() to generate a vector of range expansion constants used to add some padding around the data to ensure that they are placed some distance away from the axes.
              oob = c(censor, squish, squish_infinite, other_function),             #- how to handle out-of-bounds values
              na.value = NA_real_,                                                  #- Missing values will be replaced with this value.
              trans = c("identity", "log", "log10", "exp", "sqrt", "logit", etc)    #- For continuous scales, the name of a transformation object or the object itself.
              guide = c( waiver(), guides() ),
              position = c( "left", "right", "top", "bottom" )                      #- For position scales, The position of the axis.
              sec.axis = c( waiver(), sec_axis() )                                  #- used to specify a secondary axis.
)

    o + scale_y_continuous( labels = scales::percent |  )                     #- format the Y-axis to show "%" on tick labels
 
 #- Pre-built themes    
   o + ( theme_grey(), theme_bw(), theme_linedraw(), theme_light(), theme_dark(),
    theme_minimal(), theme_classic(), theme_void(), theme_test() )

theme_get(), theme_set(), theme_update(), theme_replace()   #- Get, set, and modify the active theme

#- !! NOTE: assign any [theme element] = element_blank() to remove it from the view!

theme(                                                  #- Modify components of a theme
    line = element_line(...),                           #- modify all line elements
    text = element_text(...),                           #- modify all text elements at once
    title = element_text(...),                          #- modify all title elements: plot, axes, legends
    axis.title = element_text(...),                     #- modify all axis title elements
    [axis.title.x | axis.title.y] = element_text(...),  
    [axis.title.x.top | axis.title.x.bottom] = element_text(...),
    [axis.title.y.left | axis.title.y.right] = element_text(...),

    axis.text = element_text(...),                      #- modify all tick labels along axes
    [axis.text.x | axis.text.y] = element_text(...),    #- Use element_text(angle=90, hjust=1) to rotate/align the axis tick labels to be readable
    [axis.text.x.top | axis.text.x.bottom] = element_text(...),
    [axis.text.y.left | axis.text.y.right] = element_text(...),

    axis.ticks,
    axis.ticks.x, axis.ticks.x.top, axis.ticks.x.bottom,
    axis.ticks.y,
    axis.ticks.y.left, axis.ticks.y.right,
    axis.ticks.length,
    axis.ticks.length.x, axis.ticks.length.x.top, axis.ticks.length.x.bottom,
    axis.ticks.length.y, axis.ticks.length.y.left, axis.ticks.length.y.right,

    plot.background = element_rect(...),                #- background of the entire plot
    plot.title = element_text(...),                     #- plot title (text appearance) left-aligned by default
    plot.title.position = c("panel", "plot"),           #- Alignment of the plot title/subtitle and caption. The setting for plot.title.position applies to both the title and the subtitle. 
    plot.caption.position = = c("panel", "plot"),       #- A value of "panel" (the default) means that titles and/or caption are aligned to the plot panels. A value of "plot" means that titles and/or caption are aligned to the entire plot (minus any space for margins and plot tag).
    plot.subtitle = element_text(...),                  #- plot subtitle (text appearance) left-aligned by default
    plot.caption = element_text(...),                   #- caption below the plot (text appearance) right-aligned by default
    plot.tag = element_text(...),                       #- upper-left label to identify a plot (text appearance) left-aligned by default
    plot.tag.position = c(("topleft", "top", "topright", "left", "right", "bottomleft", "bottom", "bottomright") or a coordinate.),  #- The position of the tag as a string ("topleft", "top", "topright", "left", "right", "bottomleft", "bottom", "bottomright) or a coordinate. If a string, extra space will be added to accommodate the tag.
    plot.margin = unit(c(t=num, r=num, b=num, l=num, units=c("mm", "pts")  #- margin around entire plot (unit with the sizes of the top, right, bottom, and left margins)

    legend.background = element_rect(...),              #- background of legend
    legend.margin = margin(...),                        #- the margin around each legend
    legend.spacing = unit(,                              #- the spacing between legends
    [legend.spacing.x | legend.spacing.y] = unit,
    legend.key = element_rect(...),                     #- background underneath legend keys
    legend.key.size = unit,                             #- size of legend keys
    [legend.key.height | legend.key.width] = unit,    
    legend.text = element_text(...),                    #- legend item labels
    legend.text.align = [0:1],                          #- alignment of legend labels (number from 0 (left) to 1 (right))
    legend.title = element_text(...),                   #- title of legend
    legend.title.align = [0:1],                         #- alignment of legend title (number from 0 (left) to 1 (right))
    legend.position = c("none", "left", "right", "bottom", "top"),
    legend.direction = c("horizontal", "vertical"),     #- layout of items in legends
    legend.justification = c("center" or two-element numeric vector),  #- anchor point for positioning legend inside plot ("center" or two-element numeric vector) or the justification according to the plot area when positioned outside the plot
    legend.box = c("horizontal" or "vertical"),         #- arrangement of multiple legends
    legend.box.just = c("top", "bottom", "left", or "right"),  #- justification of each legend within the overall bounding box, when there are multiple legends
    legend.box.margin = margin(...),                    #- margins around the full legend area
    legend.box.background = element_rect(),             #- background of legend area
    legend.box.spacing = unit,                          #- The spacing between the plotting area and the legend box

    strip.background = element_rect(...),               #- background of facet labels
    [strip.background.x, strip.background.y] = element_rect(...),  #- Horizontal facet background (strip.background.x) & vertical facet background (strip.background.y) inherit from strip.background or can be specified separately  
    strip.placement = c("inside", "outside"),           #- placement of strip with respect to axes, either "inside" or "outside". Only important when axes and strips are on the same side of the plot.
    strip.text = element_text(...),                     #- facet labels
    [strip.text.x, strip.text.y] = element_text(...),   #- Horizontal facet labels (strip.text.x) & vertical facet labels
    strip.switch.pad.grid = unit,                       #- space between strips and axes when strips are switched (unit)
    strip.switch.pad.wrap = unit,                       #- space between strips and axes when strips are switched (unit)
    )

element_text(family = "name", face = c("plain", "italic", "bold", "bold.italic"), 
    color = NULL, size = num_pts, hjust = [0:1], vjust = [0:1], angle = [0:360], 
    lineheight = num, margin = margin(...), debug = [F|T], inherit.blank = FALSE)

element_rect(fill = NULL, color = NULL, size = num_mm,
    linetype = [0:8 factor], inherit.blank = FALSE)

element_line( color = NULL, size = num_mm, linetype = [0:8 factor], 
    lineend = ("round", "butt", "square"), arrow = grid::arrow(), 
    inherit.blank = FALSE)
   
margin(t = 0, r = 0, b = 0, l = 0, unit = "pt")

unit(value=num, unit=c("mm", "pt"))

new_theme <- function(){
    theme(
        plot.background = element_rect(fill="green"),
        panel.background = element_rect(fill="lightgreen")
        )
}

o + new_theme()
   
https://www.accuweather.com/en/videos/frDwk40a?jwsource=cl

#- Rendering images files from current plot ----------
pdf()
jpeg()
png()

g1 <- ggplot(...) + ...         #- Create plot
png(filename = "filename.png", width=1280, height=720, pointsize = 18, type = "windows")
plot(g1)
dev.off()

##---------------------------------------------------------------------------
## RMarkdown ("Pandoc" markdown)
##---------------------------------------------------------------------------

#- YAML Header
---
title: "Untitled"
subtitle: "Whatever"
author: "Anonymous"
date: 99 Juntember=
output: c(html_document,
        pdf_document,               #- pdf (requires Tex ),
        word_document,              #- Microsoft Word (.docx)
        odt_document,               #- OpenDocument Text
        rtf_document,               #- Rich Text Format
        md_document,                #- Markdown
        github_document,            #- Github compatible markdown
        ioslides_presentation,      #- ioslides HTML slides
        slidy_presentation,         #- slidy HTML slides
        beamer_presentation)        #- Beamer pdf slides (requires Tex)
    theme: specify_style_preset
    df_print: c(default,            #- IMPORTANT...makes table rendering not suck
                kable,
                tibble,
                paged)                 
    highlight: specify_highlighting_syntax
    toc: return_if_true             #- Add table of contents
    toc_float: false                #- Whether ToC moves when you scroll
    toc_depth: 42                   #- the "depth" of heading levels displayed in ToC
    code_folding: c(hide, show)     #- whether collapsible code blocks are hidden or shown by default
    number_sections: c(true, false)
    css: styles.css                 #- If the output type is HTML, you can including a CSS file
runtime: c(NULL, shiny)             #- Optional line for interactive documents
---

#For HTML docs, you can input CSS here
<style>
body, h1, h2, h3, h4 {font-family: "font_name", serif;}
body {color: caolor_name;}
a, a:hover { color: color_name;}
pre {font-size: 10px;}                  #adjust the font size of code elements
</style>

# Heading level                     #- WITH a space between hashes and text
## Heading level 2   {#identifier1} #- can add identifier for in-doc linking
### Heading level 3
#### Heading level 4
##### Heading level 5
###### Heading level 6

<blank line separating text>        #- Creates paragraphs
<two spaces at end of line>         #- Creates a line break

***bold and italic text***  or ___b+i text___ or __*
**bold text**  __bold text__
*italic text*  _italic text_
superscript^2^
subscript~2~
~~strikethrough~~

<www.rstudio.com>                       #- Hyperlink printed directly
[link text](www.rstudio.com)            #- Hyperlink printed with specified text
Jump to [Header 1](#anchor)             #- in document link
image: ![image caption](path/to/smallorb.png)

endash: --
emdash: ---
ellipsis: ...

inline equation: $A = \pi*r^{2}$        #- Surround with "$" symbols
Equation Block: $$E = mc^{2}$$          #- Creates full-width block on page
horizontal rule (or slide break): ***   
escaped: \*\_\\ -->  *_\                #- Add backslashes before special characters to print

A footnote [^1]
[^1]: Here is the footnote.

> block quote
> that continues over multiple lines 
> > and has a second nested block quote 
> > inside of it

<!--Text comment-->                     #- Not displayed

\textbf{Tex ignored in HTML}
<em>HTML ignored in pdfs</em>

* unordered list                        #- Add two spaces for each indentation level
  + sub-item 1
  + sub-item 2
    - sub-sub-item 1

1. ordered list                         #- Add two spaces for each indentation level
2. item 2
  i) sub-item 1
    A. sub-sub-item 1

- slide bullet 1
- slide bullet 2

(>- to have bullets appear on click)

(@) A list whose numbering
continues after
(@) an interruption

Term 1                                  #- Convenient formatting for defining terms
: Definition 1

#- Create Table
Right | Left | Default | Center |
|------:|:-----|---------|:------:|
| 12 | 12 | 12 | 12 |
| 123 | 123 | 123 | 123 |
| 1 | 1 | 1 | 1 |

| 200 Main St.                          #- To preserve division of lines to format text
| Berkeley, CA 94718                    #- use <pipe>+<space> to create "line blocks"

#- Embed Code with Knitr

inline code: 
`r getRversion()` --> Built with 3.2.3  #- single backticks either side

block code:                             #- triple backticks either end
```{r}                                  #- Can optionally specify the coding language                                             
{inline block of code}                  #- By default, all code and output is shown in RMarkdown docs
```

```{r optional_name, include=F, opt2=T} #- include=FALSE will hide the code chunk from report                                          
{inline block of code}
```

#other Knitr code options
include = c(TRUE, FALSE)                #- show the R code chunk and its output
echo = c(TRUE, FALSE)                   #- show the R code chunk
message = c(TRUE, FALSE)                #- show output messages
warning = c(TRUE, FALSE)                #- show output warnings
eval = c(TRUE, FALSE)                   #- whether to actually evaluate the R code chunk
fig.height = height_in_inches           #- Directly specify the height of redered image
fig.width = width_in_inches
fig.align = c("left", "center", "right")

~~~~~~~~~~~~                               #- Another way of code blocks ("fenced")
{lots of}
{code here}
~~~~~~~~~~~~                               #- At least 3 tildes in a row

#print prettier tables via code
```{r}
some_data_table %>% filter(something) %>%
knitr::kable()
```
