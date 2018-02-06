

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                 %
%  Title: MachineLearning Kmeans Implementation   %
%  Author: Cheng Chen                             %
%  Date: 23/11/2017                               %
%                                                 %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Implementation1: Kmeans for 2 dimensions 

% 78 data points, 3 clusters, 2 dimensions

% load data 
data = zeros(100,2);
data = load('data.txt');
x = data(:,1);
y = data(:,2);

% drawing data, two dimensions, size 20, bule points, unfilled
figure;
scatter(x, y, 20, 'blue');
sample_num = size(data, 1);  % get number of samples
sample_dimension = size(data, 2);  % get dimension of samples

% initializing clusters
% original coordinates: C1(2,5.5), C2(3,4.5), C3(2.5,4)
cluster1 = [2,5.5];
cluster2 = [3,1.5];
cluster3 = [5,4];
hold on
% drawing first 3 cluster points
scatter(cluster1(1), cluster1(2), 60, 'red', '+');
scatter(cluster2(1), cluster2(2), 60, 'green', '+');
scatter(cluster3(1), cluster3(2), 60, 'blue', '+');
title('The original data and clusters');
legend('data points', 'cluster1', 'cluster2', 'cluster3');

% clustering
% creat 3 groups for the points belong to 3 different clusters
group1 = zeros(100,2);
group2 = zeros(100,2);
group3 = zeros(100,2);
% creat 3 buffer to save the locations of clusters each time 
buf_cluster1 = zeros(1,2);
buf_cluster2 = zeros(1,2);
buf_cluster3 = zeros(1,2);
distance = zeros(1,3);  % the distance for each points to 3 clusters
iterationNum = 0; % counting the frequency of iterations

% do the culstering until all culsters no longer changes
while ((buf_cluster1~=cluster1)|(buf_cluster2~=cluster2)|(buf_cluster3~=cluster3))
    iterationNum = iterationNum + 1;
    % save the present clustesr for comparing with next clusters
    buf_cluster1 = cluster1;  
    buf_cluster2 = cluster2;
    buf_cluster3 = cluster3;
    for i=1:sample_num
        % calculate the distance between each point and clusters: sqrt((x1-x2)^2 + (y1-y2)^2)
        distance(1) = norm(data(i,:) - cluster1); 
        distance(2) = norm(data(i,:) - cluster2); 
        distance(3) = norm(data(i,:) - cluster3); 
        dmin = min(distance);
        % check which cluster is closest to the point, pick it belong to that cluster 
        if distance(1) == dmin
            group1(i,:) = data(i,:);
        elseif distance(2) == dmin
            group2(i,:) = data(i,:);
        elseif distance(3) == dmin
            group3(i,:) = data(i,:);
        end
    end
   
    % recalculate locations of each cluster
    % moving them to the center of their group
    cluster1(1) = mean(nonzeros(group1(:,1)));
    cluster1(2) = mean(nonzeros(group1(:,2)));
    cluster2(1) = mean(nonzeros(group2(:,1)));
    cluster2(2) = mean(nonzeros(group2(:,2)));
    cluster3(1) = mean(nonzeros(group3(:,1)));
    cluster3(2) = mean(nonzeros(group3(:,2)));

    % drawing diagram again
    %cla;  % clean the diagram
    % different coordinates for different group
    x1 = nonzeros(group1(:,1));
    y1 = nonzeros(group1(:,2));
    x2 = nonzeros(group2(:,1));
    y2 = nonzeros(group2(:,2));
    x3 = nonzeros(group3(:,1));
    y3 = nonzeros(group3(:,2));
    figure;
    % drawing gropu1 with red points
    scatter(x1, y1, 20, 'red', 'filled');
    hold on
    % drawing group2 with green points
    scatter(x2, y2, 20, 'green', 'filled');
    hold on
    % drawing group3 with blue points
    scatter(x3, y3, 20, 'blue', 'filled');
    hold on
    % redrawing all clusters
    scatter(cluster1(1), cluster1(2), 60, 'red', '+');
    hold on
    scatter(cluster2(1), cluster2(2), 60, 'green', '+');
    hold on
    scatter(cluster3(1), cluster3(2), 60, 'blue', '+');
    title(['The ', num2str(iterationNum), 'th iterations of clustering']);
    legend('group of cluster1', 'group of cluster2', 'group of cluster3', 'clusters');
    
    % clear and reset all groups
    group1 = zeros(100,2);
    group2 = zeros(100,2);
    group3 = zeros(100,2);
end




