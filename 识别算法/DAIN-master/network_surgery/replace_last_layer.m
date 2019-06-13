function [ net ] = replace_last_layer( net, lr_old_layers, lr_new_layer, nClasses, dropOutRatio )

  [net_info] = vl_simplenn_display(net);
  net_dimensions = net_info.dataSize(3,:);

  scal = 1 ;
  net.layers{end-1} = struct('type', 'conv', ...
                             'filters', 0.01/scal * randn(1,1,net_dimensions(end-2),nClasses,'single'), ...
                             'biases', zeros(1, nClasses, 'single'), ...
                             'stride', 1, ...
                             'pad', 0, ...
                             'filtersLearningRate',  lr_new_layer(1) , ...
                             'biasesLearningRate',  lr_new_layer(2) , ...
                             'filtersWeightDecay', 1, ...
                             'biasesWeightDecay', 0) ;

  net.layers{end} = struct('type', 'softmaxloss') ;

  if dropOutRatio > 0
    % inject dropout for the two FC layers:
    dropout = struct('type', 'dropout', ...
                               'rate', dropOutRatio) ;
    nL = numel(net.layers);                         
    net.layers = {net.layers{1:nL-4} dropout net.layers{nL-3:nL-2} dropout net.layers{nL-1:end}};
  end


end
