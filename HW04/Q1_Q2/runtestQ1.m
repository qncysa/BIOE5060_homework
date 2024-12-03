%% test 1 for grow() method

test1=[0 0 0 0; 0 0 1 0; 0 0 0 0];
expectedtest1_1=[0 0 1 0; 0 1 1 1; 0 0 1 0];
expectedtest1_2=[0 1 1 1; 1 1 1 1; 0 1 1 1];
expectedtest1_3=[0 1 1 1; 0 1 1 1; 0 1 1 1];

bwimg = BlackWhite2D(test1);

if(any(any(bwimg.grow() ~= expectedtest1_1)))
    error('single pixel test 1 failed')
end

if(any(any(bwimg.grow(2) ~= expectedtest1_2)))
    error('single pixel test 2 failed')
end

if(any(any(bwimg.grow(1, ones(3)) ~= expectedtest1_3)))
    error('single pixel test 3 failed')
end

%% test 2 for grow() method

test2=full(sparse([2, 5, 7],[3, 3, 6],[1 1 1], 10, 8));
expectedtest2_1=repmat([0,1,0,0,1,0,1,0,0,0]', 1, 8);
expectedtest2_2=repmat([0,0,1,0,0,1,0,0], 10, 1);

bwimg = BlackWhite2D(test2, [0 0 0; 1 1 1; 0 0 0]);

if(any(any(bwimg.grow(10) ~= expectedtest2_1)))
    error('x line mask test failed')
end

if(any(any(bwimg.grow(10, [0 1 0;0 1 0;0 1 0]) ~= expectedtest2_2)))
    error('y line mask test failed')
end