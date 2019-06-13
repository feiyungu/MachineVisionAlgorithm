function mrcnn_build()
if ~exist('liblinear_train')
  fprintf('Compiling liblinear version 1.94\n');
  fprintf('Source code page:\n');
  fprintf('   http://www.csie.ntu.edu.tw/~cjlin/liblinear/\n');
  mex -outdir bin ...
      CFLAGS="\$CFLAGS -std=c99 -O3 -fPIC" -largeArrayDims ...
      external/liblinear-1.94/matlab/train.c ...
      external/liblinear-1.94/matlab/linear_model_matlab.c ...
      external/liblinear-1.94/linear.cpp ...
      external/liblinear-1.94/tron.cpp ...
      "external/liblinear-1.94/blas/*.c" ...
      -output liblinear_train;
end

if ~exist('adaptive_region_pooling_mex')
  fprintf('Compiling adaptive_region_pooling_mex\n');

  mex -outdir bin ...
      -largeArrayDims ...
      code/adaptive_region_pooling/adaptive_region_pooling_mex.cpp ...
      -output adaptive_region_pooling_mex;
end

if ~exist('nms_mex')
  fprintf('Compiling nms_mex\n');

  mex -outdir bin ...
      -largeArrayDims ...
      code/postprocessing/nms_mex.cpp ...
      -output nms_mex;
end
end
