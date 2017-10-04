# simple example to show the matrix multiplication with tensorflow

import tensorflow as tf
matrix1 = tf.constant([1.0,2.0,3.0,4.0], shape=[2, 2])
matrix2 = tf.matrix_inverse(matrix1)
product = tf.matmul(matrix1, matrix2)
with tf.Session() as sess:
    result = sess.run(product)
    print("result of matrix multiplication")
    print("===============================")
    print(result)
    print("===============================")
