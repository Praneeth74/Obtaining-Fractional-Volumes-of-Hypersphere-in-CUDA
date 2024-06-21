To run cpu executable -
make ball_samp-cpu

To run gpu executable - 
make ball_samp-cuda


Description:

Consider a unit hypersphere and split it into 100 shells of equal thickness. Now, this implementation is for obtaining fractional volumes of each shell. It is primarily implemented for dimensions (2-16)

The method considered here is to first sample sufficient number of points in the hypershpere. After sampling we can consider counting number of points in each shell as a measurement to their volume. We finally divide each count by total number of points sampled in the whole of hypershpere. 

Here for sampling points, Rejection sampling is used where the points are uniformly sampled in an unit hypercube and then select those points that are present in the hypersphere. That is, rejecting those points which are outside hypersphere.


Procedure:

For sampling one point - 
$I$
1. Consider sampling the coordinates $(x_{1}, x_{2}, x_{3},...., x_{n})$ uniformly randomly in range [0, 1], where $n$ denotes number of dimensions.

2. Now, select this point only if it satisfies the following condition -\
	$$x_{1}^{2}+x_{2}^{2}+x_{3}^{2}+....+x_{n}^{2}\ \leq\ 1$$

The above inequality represents all the points present in the unit hypersphere centered at the origin. Now we can apply this procedure for obtaining as many points as need. Let's consider the total number of points we obtained to be N.

$II$
Now, it is time to get the fraction of points present in each shell. Let's divide the range [0, 1] into 100 parts giving rise to 100 shells of equal thickness but increasing radius. Just to be clear, all shells will have the same center and thickness of magnitude 0.1. Now, consider one such shell of inner radius r and corresponding outer radius (r+0.1). For a given point to be in this shell, it has to satisfy the following condition - 
	$$r\ <\ x_{1}^{2}+x_{2}^{2}+x_{3}^{2}+....+x_{n}^{2}\ \leq\ (r+0.1)$$



