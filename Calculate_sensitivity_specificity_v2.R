
library(caret)
library(ggplot2)
library(lattice)

#Calculation of sensitivity, specificity, PPV and NPV for single RT-qPCR.

################## Commercial solution #####################

lvs <- c("No Event", "Event")
truth <- factor(rep(lvs, times = c(3, 14)),
                levels = rev(lvs))

pred <- factor(
  c(
    rep(lvs, times = c(1, 2)),
    rep(lvs, times = c(8, 6))),
  levels = rev(lvs))

table(pred, truth)

confusionMatrix(table(pred, truth))

################## Denaturing solution #####################

lvs <- c("No Event", "Event")
truth.2 <- factor(rep(lvs, times = c(8, 2)),
                  levels = rev(lvs))

pred.2 <- factor(
  c(
    rep(lvs, times = c(0, 8)),
    rep(lvs, times = c(0, 2))),
  levels = rev(lvs))

table(pred.2, truth.2)

confusionMatrix(table(pred.2, truth.2))

#Calculation of sensitivity, specificity, PPV and NPV for multiplex RT-qPCR.

################## Commercial solution #####################

lvs <- c("No Event", "Event")
truth.3 <- factor(rep(lvs, times = c(4, 18)),
                  levels = rev(lvs))

pred.3 <- factor(
  c(
    rep(lvs, times = c(0, 4)),
    rep(lvs, times = c(2, 16))),
  levels = rev(lvs))

table(pred.3, truth.3)

confusionMatrix(table(pred.3, truth.3))

################## Denaturing solution #####################

lvs <- c("No Event", "Event")
truth.4 <- factor(rep(lvs, times = c(2, 20)),
                  levels = rev(lvs))

pred.4 <- factor(
  c(
    rep(lvs, times = c(0, 2)),
    rep(lvs, times = c(5, 15))),
  levels = rev(lvs))

table(pred.4, truth.4)

confusionMatrix(table(pred.4, truth.4))

