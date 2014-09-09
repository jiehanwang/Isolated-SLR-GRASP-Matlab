function [Para_ARMA_test,Para_ARMA_train,TTrainKernel, VValKernel,accuracy,test_label, training_label, model_precomputed] ...
    = GRASP_1000(testID, training_path_01,training_path_02,test_path)

% test_path  = 'D:\iData\Outputs\ftdcgrs_whj_output\dim334_CTskp_allFrame_1000sign_zeng\test_30\';
% training_path_01  = 'D:\iData\Outputs\ftdcgrs_whj_output\dim334_CTskp_allFrame_1000sign_zeng\test_31\';
% training_path_02  = 'D:\iData\Outputs\ftdcgrs_whj_output\dim334_CTskp_allFrame_1000sign_zeng\test_32\';
% testID = 30;

addpath(genpath('D:\iCode\GitHub\libsvm\matlab'));
%% Settings and Initial
names = importdata('.\input\sign_1000_zeng.txt');
classNum = 370;
n = 10;              % 子空间大小
trainNum = 2;
segmentNum = 5;       % 将一个sign分成的段数。以后可以用low rank去求解
training_label = zeros(trainNum*length(names), segmentNum);
test_label = zeros(length(names), segmentNum);

Para_ARMA_train = cell(segmentNum, trainNum*length(names));
Para_ARMA_test = cell(segmentNum, length(names));
%%
for i = 1 : length(names)
    fprintf('Reading data: P%d------%d\n', testID, i);
    data = cell(1, 5);
    data{1} = importdata([training_path_01 names{i} '.txt'], ' ', 1);
    data{2} = importdata([training_path_02 names{i} '.txt'], ' ', 1);
    data{3} = importdata([test_path names{i} '.txt'], ' ', 1);
    
    for g=1:3   % g==3作测试用
        data_norm = (insertFrame(data{g}.data,n))';
        
        % 首先通过一个函数建立cov快查表
        [~, nframes] = size(data_norm);
        P = cell(1, nframes);
        Q = cell(1, nframes);
        for t=1 : nframes       % 这里将全部的cov算式组成部分算出，其实没有必要
            P{t} = sum(data_norm(:,1:t),2);
            Q{t} = data_norm(:,1:t)*data_norm(:,1:t)';
        end
        
        % 求得分段点的帧号
        segP = zeros(1, segmentNum);
        for seg = 1:segmentNum
            segP(seg) = floor(nframes*seg/segmentNum);
        end
        
        for seg = 1:segmentNum
            %data_insert = (insertFrame((data_norm(:,1:segP(seg)))', n))';
            endP = segP(seg);
            if g < 3 
                Para_ARMA_train{seg, trainNum*(i-1) + g}.C = grasp_region(1, endP, P, Q, n);
                %Para_ARMA_train{seg, trainNum*(i-1) + g} = construct_ARMA_whj(data_insert,n,n-1);
                training_label(trainNum*(i-1)+g, seg) = str2double(names{i}(2:5));
            else
                Para_ARMA_test{seg, i}.C = grasp_region(1, endP, P, Q, n);
                %Para_ARMA_test{seg, i} = construct_ARMA_whj(data_insert,n,n-1);
                test_label(i, seg) = str2double(names{i}(2:5));
            end
        end
    end
end
%% Training and test
score = zeros(classNum, classNum, segmentNum);
accuracy = zeros(1, segmentNum+1);
% 求segmentNum的score
for seg = 1 : segmentNum
    correctNum = 0;
    TrainKernel = kernel(Para_ARMA_train(seg,:),[],testID);
    ValKernel = kernel(Para_ARMA_train(seg,:),Para_ARMA_test(seg,:),testID);

    TTrainKernel = [(1:length(names)*trainNum)',TrainKernel];
    VValKernel = [(1:length(names))',ValKernel'];

    model_precomputed = svmtrain(training_label(:,1), TTrainKernel, '-t 4');
    [predict_label_P1, accuracy_P1, dec_values_P1] = svmpredict(test_label(:,1), VValKernel, model_precomputed);

    % 对第n段，求所有probe对所有类的score
    for i=1:classNum
        score(i,:,seg) = dec_values_score(dec_values_P1(i,:), classNum); 
        [~, index_sort] = sort(score(i,:,seg),'descend');
        if index_sort(1)  == i
            correctNum = correctNum + 1;
        end
    end
    accuracy(seg) = correctNum*100/classNum;
end

% 融合最后的score
score_fianl = sum(score,3);
correctNum = 0;
for i=1:classNum
    [~, index_sort] = sort(score_fianl(i,:),'descend');
    if index_sort(1)  == i
        correctNum = correctNum + 1;
    end
end
accuracy(seg+1) = correctNum*100/classNum;

