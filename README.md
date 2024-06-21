To run the cuda executable - 
```
make ball_samp-cuda
./ball_samp-cuda
```


### Description:

Consider a unit hypersphere and split it into 100 shells of equal thickness. This implementation aims to obtain the fractional volumes of each shell, primarily for dimensions ranging from 2 to 16.

The method employed involves first sampling a sufficient number of points within the hypersphere. After sampling, the number of points in each shell is counted as a measure to their volumes. Finally, each count is divided by the total number of points sampled in the entire hypersphere to obtain the fractional volume of each shell.

For sampling points, rejection sampling is used. Points are uniformly sampled within a unit hypercube, and those points that lie outside the hypersphere are rejected. This process ensures that only points within the hypersphere are considered.


### Procedure:

$I$\
For sampling one point -
1. Consider sampling the coordinates $(x_{1}, x_{2}, x_{3},...., x_{n})$ uniformly randomly in range [0, 1], where $n$ denotes number of dimensions.

2. Now, select this point only if it satisfies the following condition -\
	$$x_{1}^{2}+x_{2}^{2}+x_{3}^{2}+....+x_{n}^{2}\ \leq\ 1$$

The above inequality represents all the points present in the unit hypersphere centered at the origin. Using this procedure, we can obtain as many points as needed. Let's consider the total number of points we obtain to be N.

$II$\
Now, it is time to determine the fraction of points present in each shell. Let's divide the range [0, 1] into 100 parts, creating 100 shells of equal thickness but increasing radius. To be clear, all shells will have the same center and a thickness of 0.01. Consider one such shell with an inner radius of 𝑟 and a corresponding outer radius of (𝑟+0.01). For a given point to be in this shell, it must satisfy the following condition:
	$$r\ <\ x_{1}^{2}+x_{2}^{2}+x_{3}^{2}+....+x_{n}^{2}\ \leq\ (r+0.01)$$
 
In this way, count the number of points in each shell and divide these counts by the total number of points N in the hypersphere. These fractions represent the fractional volumes of the shells of the hypersphere. Follow this procedure for each shell to obtain its volume. Note that the sum of all the fractional volumes should be 1 (since we are using a unit hypersphere).

### Code:
The main block of the file "ball_samp-cuda.cu" contains a section called "editables", which are just a bunch of variables that you can adjust according to your system's capacity for the workload.

### Optional:
To run the cpu executable (optional for comparing relative performance) -
```
make ball_samp-cpu
./ball_samp-cuda
```







 



