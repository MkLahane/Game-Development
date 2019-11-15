class NeuralNetwork {
    constructor(m, a, b, c) {
      if (m instanceof tf.Sequential) {
        this.inputNodes = a;
        this.hiddenNodes = b;
        this.outputNodes = c;
        this.model = m;
      } else {
        this.inputNodes = m;
        this.hiddenNodes = a;
        this.outputNodes = b;
        this.model = this.createModel();
      }
    }
    createModel() {
      const model = tf.sequential();
      const hidden = tf.layers.dense({
        units: this.hiddenNodes[0],
        inputShape: [this.inputNodes],
        activation: 'sigmoid'
      });
      model.add(hidden);
      for (let i = 1; i < this.hiddenNodes.length; i++) {
        const temp = tf.layers.dense({
          units : this.hiddenNodes[i],
          activation : 'sigmoid'
        });
        model.add(temp);
      }
      const output = tf.layers.dense({
        units: this.outputNodes,
        activation: 'sigmoid'
      });
      model.add(output);
      return model;
    }
    copy() {
      return tf.tidy(() => {
        const modelCopy = this.createModel();
        const weights = this.model.getWeights();
        const weightsCopy = [];
        for (let i = 0; i < weights.length; i++) {
          weightsCopy[i] = weights[i].clone();
        }
        modelCopy.setWeights(weightsCopy);
        return new NeuralNetwork(modelCopy, this.inputNodes, this.hiddenNodes, this.outputNodes);
      });
    }
    crossover(a, b) {
      return tf.tidy(() => {
        const c = this.createModel();
        const aweights = a.model.getWeights();
        const bweights = b.model.getWeights();
        const cweights = [];
        for (let i = 0; i < aweights.length; i++) {
          let atensor = aweights[i];
          let btensor = bweights[i];
          let shape = atensor.shape;
          let avalues = atensor.dataSync().slice();
          let bvalues = btensor.dataSync().slice();
          let cvalues = new Array(avalues.length);
          for (let j = 0; j < cvalues.length; j++) {
            if (random(1) < 0.5) {
              cvalues[j] = avalues[j];
            } else {
              cvalues[j] = bvalues[j];
            }
          }
          let cTensor = tf.tensor(cvalues, shape);
          cweights[i] = cTensor; 
        }
        c.setWeights(cweights);
        return new NeuralNetwork(c, this.inputNodes, this.hiddenNodes, this.outputNodes);
      });
    }
    mutate(r) {
      tf.tidy(() => {
        const mutatedWeights = [];
        const weights = this.model.getWeights();
        for (let i = 0; i < weights.length; i++) {
          let tensor = weights[i];
          let shape = tensor.shape;
          let values = tensor.dataSync().slice();
          for (let j = 0; j < values.length; j++) {
            if (random(1) < r) {
              let w = values[j];
              values[j] = w + randomGaussian();
            }
          }
          let newTensor = tf.tensor(values, shape);
          mutatedWeights[i] = newTensor;
        }
        this.model.setWeights(mutatedWeights);
      });
    }
    predict(inputs) {
      return tf.tidy(() => {
        const xs = tf.tensor2d([inputs]);
        const ys = this.model.predict(xs);
        const outputs = ys.dataSync();
        return outputs;
      });
    }
    dispose() {
      this.model.dispose();
    }
}
  