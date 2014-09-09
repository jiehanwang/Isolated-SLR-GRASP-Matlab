% function [Para_ARMA_test,Para_ARMA_train,TTrainKernel, VValKernel,accuracy,test_label, training_label, model_precomputed] ...
%     = GRASP_370(testID, training_path_01,training_path_02,training_path_03,training_path_04,test_path)

test_path  = 'D:\iData\Outputs\ftdcgrs_whj_output\dim334_CTskp_allFrame_369sign\test_50\';
training_path_01  = 'D:\iData\Outputs\ftdcgrs_whj_output\dim334_CTskp_allFrame_369sign\test_51\';
training_path_02  = 'D:\iData\Outputs\ftdcgrs_whj_output\dim334_CTskp_allFrame_369sign\test_52\';
training_path_03  = 'D:\iData\Outputs\ftdcgrs_whj_output\dim334_CTskp_allFrame_369sign\test_53\';
training_path_04 = 'D:\iData\Outputs\ftdcgrs_whj_output\dim334_CTskp_allFrame_369sign\test_54\';
testID = 50;

addpath(genpath('D:\iCode\GitHub\libsvm\matlab'));
%%
names = importdata('.\input\sign_370.txt');
classNum = 370;
n = 5;
trainNum = 4;
segmentNum = 5;       %将一个sign分成的段数。以后可以用low rank去求解
training_label = zeros(trainNum*length(names)*segmentNum,1);
test_label = zeros(length(names)*segmentNum,1);

Para_ARMA_train = cell(1,segmentNum*trainNum*length(names));
Para_ARMA_test = cell(1, segmentNum*length(names));
%%
for i = 1 : length(names)
    fprintf('Reading data: P%d------%d\n', testID, i);
    data = cell(1, 5);
    data{1} = importdata([training_path_01 names{i} '.txt'], ' ', 1);
    data{2} = importdata([training_path_02 names{i} '.txt'], ' ', 1);
    data{3} = importdata([training_path_03 names{i} '.txt'], ' ', 1);
    data{4} = importdata([training_path_04 names{i} '.txt'], ' ', 1);
    data{5} = importdata([test_path names{i} '.txt'], ' ', 1);
    
    
    for g=1:5   % g==5作测试用
        data_norm = (insertFrame(data{g}.data,n))';
        
        % 首先通过一个函数建立cov快查表
        [~, nframes] = size(data_norm);
        P = cell(1, nframes);
        Q = cell(1, nframes);
        for t=1 : nframes       % 这里将全部的cov算式组成部分算出，其实没有必要
            P{t} = sum(data_norm(:,1:t),2);
            Q{t} = data_norm(:,1:t)*data_norm(:,1:t)';
        end
        
        segP = zeros(1, segmentNum);
        for seg = 1:segmentNum
            segP(seg) = floor(nframes*seg/segmentNum);
        end
        
        for seg = 1:segmentNum
            if seg == 1
                startP = 1;
            else
                startP = segP(seg-1)+1;
            end
            endP = segP(seg);
            
            if g < 5 
                Para_ARMA_train{segmentNum*(trainNum*(i-1) + g - 1) + seg}.C = grasp_region(startP, endP, P, Q, n);
                training_label(segmentNum*(trainNum*(i-1) + g - 1) + seg) = str2double(names{i}(2:5));
            else
                Para_ARMA_test{segmentNum*(i-1) + seg}.C = grasp_region(startP, endP, P, Q, n);
                test_label(segmentNum*(i-1) + seg) = str2double(names{i}(2:5));
            end
        end
    end
    
end
%% Training
TrainKernel = kernel(Para_ARMA_train,[],testID);
% ValKernel = kernel_ARMA(Para_ARMA_train,Para_ARMA_test,testID);

TTrainKernel = [(1:length(names)*trainNum*segmentNum)',TrainKernel];
% VValKernel = [(1:length(names)*segmentNum)',ValKernel'];

model_precomputed = svmtrain(training_label, TTrainKernel, '-t 4');
% [predict_label_P1, accuracy_P1, dec_values_P1] = svmpredict(test_label, VValKernel, model_precomputed);

