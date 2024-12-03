%% test 1 for shrink() method

test1=[0 1 1 1; 0 1 1 1; 0 1 1 0];
expectedtest1_1=[0 0 1 1; 0 0 1 0; 0 0 0 0];
expectedtest1_3=[0 1 1 1; 0 1 1 1; 0 1 1 1];

bwimg = BlackWhite2D(test1);

if(any(any(bwimg.shrink() ~= expectedtest1_1)))
    error('simple domain test 1 failed')
end

if(any(any(bwimg.shrink(2) ~= zeros(3,4))))
    error('simple domain test 2 failed')
end


%% test 2 for shrink() method

test2=zeros(6,8);
test2(2:5, 4:8) = 1;

expectedtest2_1=zeros(6,8);
expectedtest2_1(2:5, 6:end)=1;

expectedtest2_2=zeros(6,8);
expectedtest2_2(3:4, 4:end)=1;


bwimg = BlackWhite2D(test2, [0 0 0; 1 1 1; 0 0 0]);

if(any(any(bwimg.shrink(2) ~= expectedtest2_1)))
    error('x line mask test failed')
end

if(any(any(bwimg.shrink(1, [0 1 0;0 1 0;0 1 0]) ~= expectedtest2_2)))
    error('y line mask test failed')
end

%% test 3 for shrink() method

test3=(magic(10)>20);
expectedtest3_1 = [0 0 0 0 0 0 0 1 1 1;0 0 0 0 0 0 0 1 1 1;0 0 0 0 0 0 1 1 1 1;0 0 0 0 0 0 0 1 1 1;0 0 0 0 0 0 0 1 1 1;0 0 0 0 0 0 1 1 1 1;0 0 0 0 0 1 1 1 1 1;0 0 0 0 0 1 1 1 1 1;0 0 0 0 1 1 1 1 1 1;0 0 0 0 1 1 1 1 1 1];

bwimg = BlackWhite2D(test3, logical([0 1 0; 1 1 1; 0 1 1]));

if(any(any(bwimg.shrink(2) ~= expectedtest3_1)))
    error('logical magic matrix test failed')
end