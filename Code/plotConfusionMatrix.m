function plotConfusionMatrix(CM, modelName, datasetName)
    figure;
    heatmap(CM);
    title(['Confusion Matrix for ', modelName, ' on ', datasetName]);
    xlabel('Predicted Class');
    ylabel('True Class');
    drawnow;
end
