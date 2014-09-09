segmentNum = 5;
classNum = 370;
score = zeros(classNum, classNum, segmentNum);
for seg = 1 : 5
    correctNum = 0;
    TrainKernel = kernel(Para_ARMA_train(seg,:),[],testID);
    ValKernel = kernel(Para_ARMA_train(seg,:),Para_ARMA_test(seg,:),testID);

    TTrainKernel = [(1:length(names)*trainNum)',TrainKernel];
    VValKernel = [(1:length(names))',ValKernel'];

    model_precomputed = svmtrain(training_label(:,1), TTrainKernel, '-t 4');
    [predict_label_P1, accuracy_P1, dec_values_P1] = svmpredict(test_label(:,1), VValKernel, model_precomputed);

    for i=1:classNum
        score(i,:,seg) = dec_values_score(dec_values_P1(i,:), classNum); 
        [~, index_sort] = sort(score(i,:,seg),'descend');
        if index_sort(1)  == i
            correctNum = correctNum + 1;
        end
    end
    fprintf('Mine correct: %f \n', correctNum/classNum);
end


score_fianl = sum(score,3);
correctNum = 0;
for i=1:classNum
    [~, index_sort] = sort(score_fianl(i,:),'descend');
    if index_sort(1)  == i
        correctNum = correctNum + 1;
    end
end
fprintf('Final correct: %f \n', correctNum/classNum);