%
% please write help info for this class, see example at
% https://github.com/NeuroJSON/jsonlab/blob/master/jdict.m
%

classdef BlackWhite2D

  properties (Access = private)
    image0 % private property to stor the original unmodified 2D binary image
  end

  properties
    mask % public property to store binary mask
  end

  methods
    % Constructor
    function obj = BlackWhite2D(img_init, mask_init)
      if nargin < 1
        error('provide input image')
      end
      obj.image0 = logical(img_init); % image is binary

      % default mask: [0 1 0; 1 1 1; 0 1 0]
      if nargin < 2
        obj.mask = [0 1 0; 1 1 1; 0 1 0];
      else
        obj.mask = logical(mask_init);
      end
    end

    % grow operation method
    function output = grow(obj, iternum, newmask)
      if nargin < 2 || isempty(iternum)
        iternum = 1;
      end
      if nargin < 3
        mask = obj.mask;
      else
        mask = logical(newmask);
      end

      % mask dimensions
      [mRows, mCols] = size(mask);
      if mod(mRows, 2) == 0 || mod(mCols, 2) == 0
        error('mask dimensions must be odd');
      end

      R = floor(mRows/2)
      output = obj.image0

      for iter = 1:iternum
        paddedImage = padarray(output, [R R], 0);

        % growth operation with matrix operations
        neighbors = false(size(output));
        for k = 1:numel(mask)
          if mask(k)
            [rowShift, colShift] = ind2sub(size(mask), k);
            rowShift = rowShift - R - 1;
            colShift = colShift - R - 1;

            neighbors = neighbors & paddedImage((1:size(output, 1)) + R + rowShift, (1:size(output, 2)) + R + colShift);
            end
          end
          output = neighbors;
        end
      end

    % shrink operation method
    function output = shrink(obj, iternum, newmask)
      if nargin < 2 || isempty(iternum)
        iternum = 1;
      end
      if nargin < 3
        mask = obj.mask;
      else
        mask = logical(newmask);
      end

      % mask dimensions
      [mRows, mCols] = size(mask);
      if mod(mRows, 2) == 0 || mod(mCols, 2) == 0
        error('mask dimensions must be odd');
      end

      R = floor(mRows/2)
      output = obj.image0;

      
      for iter = 1:iternum
        paddedImage = padarray(output, [R R], 0);

        % shrink operation
        %neighbors = true(size(output));
        neighbors = output;
        neighborCounts = zeros(size(output));
        for k = 1:numel(mask)
          if mask(k)
            [rowShift, colShift] = ind2sub(size(mask), k);
            rowShift = rowShift - R - 1;
            colShift = colShift - R - 1;

            neighborCounts = neighborCounts + paddedImage((1:size(output, 1)) + R + rowShift, (1:size(output, 2)) + R + colShift);
            %neighbors = neighbors & (neighborCount == sum(mask(:)));
            %neighbors = neighbors & ~paddedImage((1:size(output, 1)) + R + rowShift, (1:size(output, 2)) + R + colShift)
          end
        end
        neighbors = neighbors & (neighborCounts < sum(mask(:)));
        output = neighbors
      end
    end

  end
end