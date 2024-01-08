## Put comments here that give an overall description of what your
## functions do

#these functions create a special "matrix" object that can cache its inverse.
#the "makeCacheMatrix" function takes a matrix "x", 
#initializes the inverse matrix to NULL, 
#and defines functions that set the value of the matrix,
#get the value of the matrix, set the value of the inverse
#and get the value of the inverse matrix.
#the function returns a list containing these four functions. 
#the "cacheSolve" function computes the inverse of the special "matrix" returned by
#makeCacheMatrix above. If the inverse has already been calculated
#(and the matrix has not changed), then the cachesolve should retrieve
#the inverse from the cache. Otherwise, it should compute the inverse
#matrix and set the value of the inverse in the cache via the setinv
#function.

## Write a short comment describing this function

#this function creates a special "matrix" object that can cache its inverse
#the function takes a matrix "x" as its argument, initializes the inverse matrix
#to NULL, and defines the following functions:
#1. set the value of the matrix
#2. get the value of the matrix
#3. set the value of the inverse
#4. get the value of the inverse
#the function returns a list containing these four functions

makeCacheMatrix <- function(x = matrix()) {
    inv <- NULL
    set <- function(y) {
        x <<- y
        inv <<- NULL
    }
    get <- function() x
    setinv <- function(inverse) inv <<- inverse
    getinv <- function() inv
    list(
        set = set,
        get = get,
        setinv = setinv,
        getinv = getinv
    )
}


## Write a short comment describing this function

#this function computes the inverse of the special "matrix" returned by
#makeCacheMatrix above. If the inverse has already been calculated
#(and the matrix has not changed), then the cachesolve should retrieve
#the inverse from the cache.
#the function takes a matrix "x" as its argument as runs getinv(x)
#if the inverse is in the cache, getinv returns a value which is returned.
#if the inverse is not in the cache, the inverse is solved and assigned to "inv"
#

cacheSolve <- function(x, ...) {
        ## Return a matrix that is the inverse of 'x'
        x <- x$getinv()
        if(!is.null(x)) {
            message("getting cached data")
            return(x)
        }
        data <- x$get()
        inv <- solve(data)
        x$setinv(inv)
        inv
}

#example usage
#x <- makeCacheMatrix(matrix(1:4, 2, 2))
# x$get()
# x$getinv()
#cacheSolve(x)
#cacheSolve(x)