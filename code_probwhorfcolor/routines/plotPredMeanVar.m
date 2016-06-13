function [predbias]=plotPredMeanVar(s_reconstr,s_reconstr_aug,pred,pred_ub,pred_lb,nsubj,nrun,npt)

predbias = mean(reshape(pred-s_reconstr_aug,npt,nsubj*nrun),2);
plot(s_reconstr,predbias,'r','linewidth',2)

end