%%
clear all;
clc;
%% 370 signs user dependent 
path_01  = 'D:\iData\Outputs\ftdcgrs_whj_output\dim334_CTskp_allFrame_369sign\test_50\';
path_02  = 'D:\iData\Outputs\ftdcgrs_whj_output\dim334_CTskp_allFrame_369sign\test_51\';
path_03  = 'D:\iData\Outputs\ftdcgrs_whj_output\dim334_CTskp_allFrame_369sign\test_52\';
path_04  = 'D:\iData\Outputs\ftdcgrs_whj_output\dim334_CTskp_allFrame_369sign\test_53\';
path_05  = 'D:\iData\Outputs\ftdcgrs_whj_output\dim334_CTskp_allFrame_369sign\test_54\';
fid = fopen('result\TraGRASPfrom1_CTC_334to5_allFrame_370sign.txt','wt');

% P50
[Para_ARMA_test,Para_ARMA_train,TTrainKernel, VValKernel,accuracy,test_label, training_label, model_precomputed] ...
    = GRASP_multiSeg_multiModel_370(50, path_05,path_02,path_03,path_04, path_01);
save result\TraGRASPfrom1_CTC_334to5_allFrame_370sign_P50.mat Para_ARMA_test Para_ARMA_train TTrainKernel...
    VValKernel accuracy test_label training_label model_precomputed;
fprintf(fid,'P%d\t %f\t %f\t %f\t %f\t %f\t %f \n',50, accuracy(1),accuracy(2),accuracy(3),accuracy(4),accuracy(5),accuracy(6));
% P51
[Para_ARMA_test,Para_ARMA_train,TTrainKernel, VValKernel,accuracy,test_label, training_label, model_precomputed] ...
    = GRASP_multiSeg_multiModel_370(51, path_01,path_05,path_03,path_04, path_02);
save result\TraGRASPfrom1_CTC_334to5_allFrame_370sign_P51.mat Para_ARMA_test Para_ARMA_train TTrainKernel...
    VValKernel accuracy test_label training_label model_precomputed;
fprintf(fid,'P%d\t %f\t %f\t %f\t %f\t %f\t %f \n',51, accuracy(1),accuracy(2),accuracy(3),accuracy(4),accuracy(5),accuracy(6));
% P52
[Para_ARMA_test,Para_ARMA_train,TTrainKernel, VValKernel,accuracy,test_label, training_label, model_precomputed] ...
    = GRASP_multiSeg_multiModel_370(52, path_01,path_02,path_05,path_04, path_03);
save result\TraGRASPfrom1_CTC_334to5_allFrame_370sign_P52.mat Para_ARMA_test Para_ARMA_train TTrainKernel...
    VValKernel accuracy test_label training_label model_precomputed;
fprintf(fid,'P%d\t %f\t %f\t %f\t %f\t %f\t %f \n',52, accuracy(1),accuracy(2),accuracy(3),accuracy(4),accuracy(5),accuracy(6));
% P53
[Para_ARMA_test,Para_ARMA_train,TTrainKernel, VValKernel,accuracy,test_label, training_label, model_precomputed] ...
    = GRASP_multiSeg_multiModel_370(53, path_01,path_02,path_03,path_05, path_04);
save result\TraGRASPfrom1_CTC_334to5_allFrame_370sign_P53.mat Para_ARMA_test Para_ARMA_train TTrainKernel...
    VValKernel accuracy test_label training_label model_precomputed;
fprintf(fid,'P%d\t %f\t %f\t %f\t %f\t %f\t %f \n',53, accuracy(1),accuracy(2),accuracy(3),accuracy(4),accuracy(5),accuracy(6));
% P54
[Para_ARMA_test,Para_ARMA_train,TTrainKernel, VValKernel,accuracy,test_label, training_label, model_precomputed] ...
    = GRASP_multiSeg_multiModel_370(54, path_01,path_02,path_03,path_04, path_05);
save result\TraGRASPfrom1_CTC_334to5_allFrame_370sign_P54.mat Para_ARMA_test Para_ARMA_train TTrainKernel...
    VValKernel accuracy test_label training_label model_precomputed;
fprintf(fid,'P%d\t %f\t %f\t %f\t %f\t %f\t %f \n',54, accuracy(1),accuracy(2),accuracy(3),accuracy(4),accuracy(5),accuracy(6));

fclose(fid);

%% 1000 signs_zeng user dependent 
% % dim61_CTskp_allFrame_1000sign_zeng dim334_CTskp_allFrame_1000sign_zeng
% path_01  = 'D:\iData\Outputs\ftdcgrs_whj_output\dim334_CTskp_allFrame_1000sign_zeng\test_30\';
% path_02  = 'D:\iData\Outputs\ftdcgrs_whj_output\dim334_CTskp_allFrame_1000sign_zeng\test_31\';
% path_03  = 'D:\iData\Outputs\ftdcgrs_whj_output\dim334_CTskp_allFrame_1000sign_zeng\test_32\';
% 
% fid = fopen('result\TraGRASPfrom1_TCT_334to10_allFrame_1000sign_zeng.txt','wt');
% outputDir = 'result\TraGRASPfrom1_TCT_334to10_allFrame_1000sign_zeng_P';
% % P30
% testID = 30;
% [Para_ARMA_test,Para_ARMA_train,TTrainKernel, VValKernel,accuracy,test_label, training_label, model_precomputed] ...
%     = GRASP_1000(testID, path_03, path_02, path_01);
% filename = [outputDir num2str(testID) '.mat'];
% save(filename, 'Para_ARMA_test', 'Para_ARMA_train', 'TTrainKernel'...
%     ,'VValKernel', 'accuracy', 'test_label', 'training_label','model_precomputed');
% fprintf(fid,'P%d\t %f\t %f\t %f\t %f\t %f\t %f \n',30,...
%     accuracy(1),accuracy(2),accuracy(3),accuracy(4),accuracy(5),accuracy(6));
% % P31
% testID = 31;
% [Para_ARMA_test,Para_ARMA_train,TTrainKernel, VValKernel,accuracy,test_label, training_label, model_precomputed] ...
%     = GRASP_1000(testID, path_01, path_03, path_02);
% filename = [outputDir num2str(testID) '.mat'];
% save(filename, 'Para_ARMA_test', 'Para_ARMA_train', 'TTrainKernel'...
%     ,'VValKernel', 'accuracy', 'test_label', 'training_label','model_precomputed');
% fprintf(fid,'P%d\t %f\t %f\t %f\t %f\t %f\t %f \n',31,...
%     accuracy(1),accuracy(2),accuracy(3),accuracy(4),accuracy(5),accuracy(6));
% % P32
% testID = 32;
% [Para_ARMA_test,Para_ARMA_train,TTrainKernel, VValKernel,accuracy,test_label, training_label, model_precomputed] ...
%     = GRASP_1000(testID, path_01, path_02, path_03);
% filename = [outputDir num2str(testID) '.mat'];
% save(filename, 'Para_ARMA_test', 'Para_ARMA_train', 'TTrainKernel'...
%     ,'VValKernel', 'accuracy', 'test_label', 'training_label','model_precomputed');
% fprintf(fid,'P%d\t %f\t %f\t %f\t %f\t %f\t %f \n',32,...
%     accuracy(1),accuracy(2),accuracy(3),accuracy(4),accuracy(5),accuracy(6));
% 
% fclose(fid);
%%  1000 sign user independent
% Path_1  = 'D:\iData\Outputs\ftdcgrs_whj_output\dim334_CTskp_allFrame_1000sign_7group\test_10\';
% Path_2  = 'D:\iData\Outputs\ftdcgrs_whj_output\dim334_CTskp_allFrame_1000sign_7group\test_11\';
% Path_3  = 'D:\iData\Outputs\ftdcgrs_whj_output\dim334_CTskp_allFrame_1000sign_7group\test_14\';
% Path_4  = 'D:\iData\Outputs\ftdcgrs_whj_output\dim334_CTskp_allFrame_1000sign_7group\test_15\';
% Path_5  = 'D:\iData\Outputs\ftdcgrs_whj_output\dim334_CTskp_allFrame_1000sign_7group\test_17\';
% Path_6  = 'D:\iData\Outputs\ftdcgrs_whj_output\dim334_CTskp_allFrame_1000sign_7group\test_19\';
% Path_7 = 'D:\iData\Outputs\ftdcgrs_whj_output\dim334_CTskp_allFrame_1000sign_7group\test_21\';
% 
% fid = fopen('result\ARMA_334to10_allFrame_1000sign_lamda0.5_7g.txt','a+');
% 
% % P10
% [Para_ARMA_test,Para_ARMA_train,TTrainKernel, VValKernel,accuracy,test_label, training_label]...
%     = arma_7groups(10,Path_7,Path_2,Path_3,Path_4,Path_5,Path_6,Path_1);
% save result\ARMA_334to10_allFrame_1000sign_lamda0.5_7g_P10.mat Para_ARMA_test Para_ARMA_train TTrainKernel...
%     VValKernel accuracy test_label training_label
% fprintf(fid,'P%d %f\t\n',10, accuracy(1,1));
% % P11
% [Para_ARMA_test,Para_ARMA_train,TTrainKernel, VValKernel,accuracy,test_label, training_label]...
%     = arma_7groups(11,Path_1,Path_7,Path_3,Path_4,Path_5,Path_6,Path_2);
% save result\ARMA_334to10_allFrame_1000sign_lamda0.5_7g_P11.mat Para_ARMA_test Para_ARMA_train TTrainKernel...
%     VValKernel accuracy test_label training_label
% fprintf(fid,'P%d %f\t\n',11, accuracy(1,1));
% % P14
% [Para_ARMA_test,Para_ARMA_train,TTrainKernel, VValKernel,accuracy,test_label, training_label]...
%     = arma_7groups(14,Path_1,Path_2,Path_7,Path_4,Path_5,Path_6,Path_3);
% save result\ARMA_334to10_allFrame_1000sign_lamda0.5_7g_P14.mat Para_ARMA_test Para_ARMA_train TTrainKernel...
%     VValKernel accuracy test_label training_label
% fprintf(fid,'P%d %f\t\n',14, accuracy(1,1));
% % P15
% [Para_ARMA_test,Para_ARMA_train,TTrainKernel, VValKernel,accuracy,test_label, training_label]...
%     = arma_7groups(15,Path_1,Path_2,Path_3,Path_7,Path_5,Path_6,Path_4);
% save result\ARMA_334to10_allFrame_1000sign_lamda0.5_7g_P15.mat Para_ARMA_test Para_ARMA_train TTrainKernel...
%     VValKernel accuracy test_label training_label
% fprintf(fid,'P%d %f\t\n',15, accuracy(1,1));
% % P17
% [Para_ARMA_test,Para_ARMA_train,TTrainKernel, VValKernel,accuracy,test_label, training_label]...
%     = arma_7groups(17,Path_1,Path_2,Path_3,Path_4,Path_7,Path_6,Path_5);
% save result\ARMA_334to10_allFrame_1000sign_lamda0.5_7g_P17.mat Para_ARMA_test Para_ARMA_train TTrainKernel...
%     VValKernel accuracy test_label training_label
% fprintf(fid,'P%d %f\t\n',17, accuracy(1,1));
% % P19
% [Para_ARMA_test,Para_ARMA_train,TTrainKernel, VValKernel,accuracy,test_label, training_label]...
%     = arma_7groups(19,Path_1,Path_2,Path_3,Path_4,Path_5,Path_7,Path_6);
% save result\ARMA_334to10_allFrame_1000sign_lamda0.5_7g_P19.mat Para_ARMA_test Para_ARMA_train TTrainKernel...
%     VValKernel accuracy test_label training_label
% fprintf(fid,'P%d %f\t\n',19, accuracy(1,1));
% % P21
% [Para_ARMA_test,Para_ARMA_train,TTrainKernel, VValKernel,accuracy,test_label, training_label]...
%     = arma_7groups(21,Path_1,Path_2,Path_3,Path_4,Path_5,Path_6,Path_7);
% save result\ARMA_334to10_allFrame_1000sign_lamda0.5_7g_P21.mat Para_ARMA_test Para_ARMA_train TTrainKernel...
%     VValKernel accuracy test_label training_label
% fprintf(fid,'P%d %f\t\n',21, accuracy(1,1));
% fclose(fid);
