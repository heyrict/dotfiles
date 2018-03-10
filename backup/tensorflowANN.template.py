#Info: A basic template for building a ANN by tensorflow
#Info: =================================================
#Info:
#Info: To estimate using the trained model, you may use tf.estimator described
#Info: [here](https://www.tensorflow.org/programmers_guide/saved_model).
#Info:
#Info: TODO: Maybe add License here

#-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-#

#Info: ## Import required libraries here

#-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-#

import numpy as np, tensorflow as tf
import os, sys
random_state = 0
np.random.seed(random_state)

#-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-#

#Info: ## Define pre-defined variables here

#-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-#

graph = tf.Graph()
num_steps = 1001
#batch_size = 128
model_name = "0"

summary_dir = os.path.join("/tmp/"+os.path.splitext(sys.argv[0])[0],model_name)
summary_inteval = 200
save_filename = os.path.join("./"+os.path.splitext(sys.argv[0])[0],model_name+".ckpt")

#-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-#

#Info: ## Useful functions

#-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-#

## Function to split 3 datasets
def train_validate_test_split(X, y, train_percent=.6, validate_percent=.2, random_state=None):
    from sklearn.cross_validation import train_test_split
    nvp = validate_percent / (1 - train_percent)
    X_train, X_cv, y_train, y_cv = train_test_split(X, y, train_size=train_percent, random_state=random_state)
    X_cv, X_test, y_cv, y_test = train_test_split(X_cv, y_cv, train_size=nvp, random_state=random_state)
    return X_train, X_cv, X_test, y_train, y_cv, y_test

## Function to calculate prediction
## predictions and labels should in format like [0,0,0,1].
def accuracy(predictions, labels):
    # An alternative:
    #return (100.0 * np.sum(np.argmax(predictions, 1) ==
    #     np.argmax(labels, 1)) / predictions.shape[0])
  return (100.0 * np.sum(predictions*labels) / predictions.shape[0])

## Function to Reshape labels(0->[1,0,0]; 1->[0,1,0]; 2->[0,0,1])
def reshape_labels(label, unique_label_num):
    return (np.arange(unique_label_num)==label[:,None]).astype(np.float32)

#-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-#

#Info: ## Load & format datasets here

#-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-#


#-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-#

#Info: ## Start graph design

#-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-#

with graph.as_default():
    # Datasets

    # Variables
    with tf.name_scope('weights'):
        pass

    with tf.name_scope('biases'):
        pass

    # Algorithms (calculate logits, loss, etc.)
    with tf.name_scope('hidden_layers'):
        pass

    # Optimize
    with tf.name_scope('train_loss'):
        #optimizer = tf.train.GradientDescentOptimizer(0.1).minimize(loss)
        pass

    # Predictions (predict accuracy of your training set etc.)
    with tf.name_scope('prediction'):
        pass

    # Merge all summaries
    merged = tf.summary.merge_all()

#-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-#

#Info: ## Run a session

#-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-#

with tf.Session(graph=graph) as sess:
    summary_writer = tf.summary.FileWriter(summary_dir, graph)
    saver = tf.train.Saver()
    if os.path.exists(save_filename+".meta"):
        saver.restore(sess, save_filename)
    else:
        tf.global_variables_initializer().run()

    try:
        for step in range(num_steps):
            # Define your feed_dict here
            #feed_dict = {}

            # Run your session here
            #_, summary, train_pred, l= sess.run([optimizer, merged, train_prediction, loss]
            #        , feed_dict=feed_dict)
            _, summary= sess.run([optimizer, merged], feed_dict=feed_dict)

            if (step % summary_inteval == 0):
                summary_writer.add_summary(summary, step)
                summary_writer.flush()
                saver.save(sess, save_filename)
                # Maybe print your temporary reports here
                #print("Train loss at step %d: %.2f" % (step, l))
                #print("Train accuracy at step %d: %.2f%%" % \
                #        (step, accuracy(train_pred, batch_labels)))
                #print("Valid accuracy at step %d: %.2f%%\n" % \
                #        (step, accuracy(valid_prediction.eval(), valid_labels)))
    except KeyboardInterrupt:
        pass

    # Maybe print your test accuravy here
    #print("Test accuracy at step %d: %.2f%%" % (step, accuracy(test_prediction.eval(), test_label)))

