
%������ͼƬ
testImg_file = './testPictures';
testImg_name = '/motianlun3.jpg';
image = imread([testImg_file testImg_name]);
figure(1);
imshow(image);

%��ȡ������ͼƬSIFT����
[~,descr,~,~ ] = do_sift([testImg_file testImg_name], 'Verbosity', 1, 'NumOctaves', 4, 'Threshold',  0.1/3/2 ) ;

%ѡ��������
K=500;

% ��ȡͼƬ��������ͼƬ��SIFT����
% [img_paths,Feats] = get_sifts('./img_paths.txt');

% �������K����ʼ����
% initMeans = Feats(randi(size(Feats,1),1,K),:);

% �������ɵĳ�ʼ���Ķ�����SIFT�������о���
% [KMeans] = K_Means(Feats,K,initMeans);


% ͳ��ͼƬ��ÿ��ͼƬÿ�������������������ÿ��ͼƬ��Ӧһ��Kά����
% [countVectors] = get_countVectors(KMeans,K��size(img_paths,1));

% ͳ�ƴ�����ͼƬÿ��������������������õ�һ��Kά����
[cosVector] = get_singleVector(KMeans,K,descr');

% �����������ƶ����������ͼƬ��ͼƬ��������ͼƬ�����Ҽн�
cosValues = zeros(1,size(img_paths,1));
for N =1:size(img_paths,1);
        dotprod = sum(cosVector .* countVectors(N,:));
        dis = sqrt(sum(cosVector.^2))*sqrt(sum(countVectors(N,:).^2));
        cosin = dotprod/dis;
        cosValues(N) = cosin;
end;

% �Խ������
[vals,index] = sort(acos(cosValues));


% ���ƥ�����ߵ�36��ͼƬ
figure(2);
c=0;
% show picture at host
for id = 1:36
    path = img_paths{index(id)};
    image = imread(path);
    if (mod(id-1,12) == 0&&id~=1)
        c=c+1;
        figure(c+2);
    end
    subplot(4,3,id-12*c);
    imshow(image);
end
        
        