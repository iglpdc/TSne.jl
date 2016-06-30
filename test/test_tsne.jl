facts("tsne()") do
    context("Iris dataset") do
        iris = dataset("datasets","iris")
        X = convert(Matrix, iris[:, 1:4])
        Y = tsne(X, 3, -1, 1500, 15, verbose=true)
        @fact size(Y) --> (150, 3)

        context("no progress bar") do
            Y = tsne(X, 2, 50, 50, 20, progress=false)
            @fact size(Y) --> (150, 2)
        end
    end

    context("MNIST.traindata() dataset") do
        train_data, labels = MNIST.traindata()
        X = train_data[:, 1:2500]'
        Xcenter = X - mean(X)
        Xstd = std(X)
        X = Xcenter / Xstd
        Y = tsne(X, 2, 50, 50, 20)
        @fact size(Y) --> (2500, 2)
        context("PCA for initial layout") do
            Y = tsne(X, 2, 50, 50, 20, pca_init=true, cheat_scale=1.0, verbose=true)
            @fact size(Y) --> (2500, 2)
        end
    end
end
