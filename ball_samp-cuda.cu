#include <iostream>
#include <random>
#include <assert.h>
#include <string>
#include <iomanip>
#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#include <curand_kernel.h>




__global__ void randgen(double* arr, int rows, int cols){
	int x = blockIdx.x*blockDim.x + threadIdx.x;
	curandState state;
	curand_init(15, x, 0, &state);
	double randnum = curand_uniform(&state);
	double sum = 0;
	
	while(1){
	if (x<rows){
		sum = 0;

		for(int r=0; r<cols; r++){
			randnum = curand_uniform(&state);
			sum += randnum*randnum;

		}
		if(sum<1){
			arr[x] = sum;
			break;
		}
//		printf("%f\n", arr[index]);
	}
		}
}


__global__ void get_hists(double* res, double* hists, double*arr, int n, int size, int total_vol){
	int x = blockIdx.x*blockDim.x + threadIdx.x;
	if(x<n){
		double sum = 0;
		for(int i=0; i<size; i++){
			if(res[i]>=arr[x] && res[i]<arr[x+1])
				sum += 1;
		}
		hists[x] = (double)sum/total_vol;	
	}
}


int main(int argc, char* argv[]){
	
//	int dim = std::stoi(argv[1]);
//	int dim = 3;
	int n = 15000000;
	for(int dim=2; dim<17; dim++){

	int rows = n;	
	int cols = dim;
	
	size_t total_bytes = rows*sizeof(double);
	
	// Allocate memory for the matrix on host
//	double* mat = (double*)malloc(total_bytes); // host
	double* matd; // device


	// Allocate memory for the matrix on device
	cudaMalloc(&matd, total_bytes);
	

	// copy host matrix to device (redundant! No need to because results are what we will obtain from the device. Also it is not initiated on host)

//	cudaMemcpy(matd, mat, total_bytes, cudaMemcpyHostToDevice);

	int blockSize, gridSize;

	// Number of threads in each block
	blockSize = 256;
	
	// Number of thread blocks in grid
	gridSize = (int)ceil((float)(rows/blockSize));
	// Execute the kernel
	randgen<<<gridSize, blockSize>>>(matd, rows, cols);
//	std::cout<<"done"<<std::endl;

	// Copy matrix back to host;
//	cudaMemcpy(mat, matd, total_bytes, cudaMemcpyDeviceToHost);

	// to print the initiated array	
//	for(int i=0; i<100; i++){
//		std::cout<<mat[i]<<" ";
		
//	}

	
	int size = rows; // size of results	
//	std::cout<<results[size-2]<<std::endl;
	
	int total_vol = n; // total number of points present inside hypersphere
	
	
	// creating intervals
	int samp = 101;
	double* arr = (double*)malloc(samp*sizeof(double));
	arr[0] = 0;
	
	for(int i=1; i<samp; i++){
		arr[i] = arr[i-1] + 0.01;
	}

	double* arrd;
	cudaMalloc(&arrd, samp*sizeof(double));
	cudaMemcpy(arrd, arr, samp*sizeof(double), cudaMemcpyHostToDevice);

	// obtaining hists
	double* hists = (double*)malloc((samp-1)*sizeof(double));
	double* histsd;
	cudaMalloc(&histsd, (samp-1)*sizeof(double));
	
	blockSize = 256;
	gridSize = (int)ceil((float)(samp-1)/blockSize);
	
	get_hists<<<gridSize, blockSize>>>(matd, histsd, arrd, samp-1, size, total_vol);

	cudaMemcpy(hists, histsd, (samp-1)*sizeof(double), cudaMemcpyDeviceToHost);


//	for(int i=0; i<samp-1; i++){
//		int sum = 0;
//		for(int j=0; j<size; j++){
//			if(results[j]>=arr[i] && results[j]<arr[i+1])
//				sum += 1;
//		}
//		hists[i] = (double)sum/total_vol;
//	}

	double total_sum = 0;
	std::cout<<"For dimension - "<<dim<<": ";
	for(int i=0; i<samp-1; i++){
		total_sum += hists[i];
		std::cout<<hists[i]<<" ";
	}
	std::cout<<std::endl;
	std::cout<<std::endl;
	std::cout<<total_sum<<std::endl;



	









	n /= 2;

	cudaDeviceSynchronize();








	// Release host memory
//	free(mat);
//	free(results);
	free(arr);
	free(hists);


	// Release device memory
	cudaFree(matd);
	cudaFree(histsd);
	cudaFree(arrd);
	}
	return 0;
}

