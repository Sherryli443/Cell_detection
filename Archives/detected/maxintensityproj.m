%% read files
fid=fopen('tiflist.txt');
filelist=textscan(fid,'%q');
fclose(fid);
filelist=filelist{1};
%% stack them in one matrix
stack3dimg=zeros(505,512,3,293); % initialize the matrix
for f=1:293
% parfor f=1:10
    fileid=filelist{f};
    stack2dimg=imread(fileid,'tif');
        redimg=stack2dimg(:,:,1)-max(stack2dimg(:,:,2),stack2dimg(:,:,3));
        greenimg=stack2dimg(:,:,2)-max(stack2dimg(:,:,1),stack2dimg(:,:,3));
        blueimg=stack2dimg(:,:,3)-max(stack2dimg(:,:,1),stack2dimg(:,:,2));
        
        stack2dsatu(:,:,1)=redimg;
        stack2dsatu(:,:,2)=greenimg;
        stack2dsatu(:,:,3)=blueimg;
    stack3dimg(:,:,:,f)=stack2dsatu;
end
maxint=cell(1,3);
maxint_ind=cell(1,3);
%% z-axis
maxint{3}=zeros(505,512,3);
maxint_ind{3}=zeros(505,512,3);
for Nchannel=1:3
    for x=1:505
        for y=1:512
            zstack=stack3dimg(x,y,Nchannel,:);
            [M,I]=max(zstack);
            maxint{3}(x,y,Nchannel)=M;
            maxint_ind{3}(x,y,Nchannel)=I;
        end
    end
end
save('maxintensity','maxint','-v7.3')
%% y-axis
maxint{2}=zeros(505,512,3);
maxint_ind{2}=zeros(505,512,3);
for Nchannel=1:3
    for x=1:505
        for z=1:293
            ystack=stack3dimg(x,:,Nchannel,z);
            [M,I]=max(ystack);
            maxint{2}(x,z,Nchannel)=M;
            maxint_ind{2}(x,z,Nchannel)=I;
        end
    end
end
save('maxintensity','maxint','-v7.3')
%% x-axis
maxint{1}=zeros(505,512,3);
maxint_ind{1}=zeros(505,512,3);
for Nchannel=1:3
    for y=1:512
        for z=1:293
            xstack=stack3dimg(:,y,Nchannel,z);
            [M,I]=max(xstack);
            maxint{2}(y,z,Nchannel)=M;
            maxint_ind{2}(y,z,Nchannel)=I;
        end
    end
end
save('maxintensity','maxint','-v7.3')
%%
fiximg